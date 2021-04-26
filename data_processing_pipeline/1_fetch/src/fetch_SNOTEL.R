
# SNOTEL map data assembly --------------------------------------------------------

library(tidyverse);library(reshape2);library(lubridate)
library(raster);library(ncdf4);library(sf)
library(RNRCS);library(dataRetrieval)
library(RColorBrewer);library(scico);library(colorspace);library(viridis)

num <- function(x)length(unique(na.omit(x)))

# fetch 2021 WY data --------------------------------------------------------------

# metadata for all SNOTEL sites
meta <- grabNRCS.meta('SNTL')

sntl_meta <- meta$SNTL %>% 
  mutate(sntl_id = site_id, site_id = gsub("SNTL:", "", site_id)) %>%
  distinct(sntl_id, site_id, wyear, start, enddate) %>% 
  filter(enddate == '2100-January') # 875 currently active sites
## include all of these on the map

## sites with historic record (data starting in 1981)
sntl_hist <- sntl_meta %>% filter(word(start, 1, 1, sep="-") <= 1981)# 469 sites that are currently active and have on or before 1981

# pull 2021 water year SWE up to current date
get_SWE_2021 <- function(site, date_today) {
  
  date <- as.Date(date_today)
  site_meta <- sntl_meta %>% filter(site_id == site)
  year <- word(site_meta$start, 1,1, sep="-")
  sitey <- gsub('SNTL:', '', site_meta$site_id)
  
  ## pull data for nrcs historical range
  sntl <- grabNRCS.data(network = 'SNTL', 
                        site_id = sitey, 
                        timescale = 'daily', 
                        DayBgn = "2020-10-01",
                        DayEnd = date)
  print(i)
  
  if("Snow.Water.Equivalent..in..Start.of.Day.Values" %in% colnames(sntl)){
    
    sntl_clean <- clean_SWE(today = sntl) %>% mutate(site_id = sitey)
    write.csv(sntl_clean, sprintf('1_fetch/out/SNOTEL/swe_wy2021_%s.csv', sitey),row.names=FALSE)
    return(sntl_clean)
    
  }
}

clean_SWE <- function(today){
  
  # organize data
  site_curve <- today %>%
    mutate(date = as.Date(Date), 
           year = year(date), month = month(date), 
           water_year = year(date) + ifelse(month(date) >= 10, 1, 0), 
           water_day = (date - as.Date(sprintf('%s-10-01', water_year)))) %>%
    group_by(water_year) %>%
    mutate(water_day_max = min(water_day)) %>% ungroup() %>%
    mutate(water_day = as.numeric(water_day - water_day_max + 1)) %>%
    ungroup() %>%
    mutate(swe = Snow.Water.Equivalent..in..Start.of.Day.Values) %>%
    dplyr::select(date, water_year, water_day, swe, year) 
  
  return(site_curve)
}


## pull 2021 water year data for all currently active sites
site_list <- unique(sntl_meta$site_id)

for (i in 1:length(site_list)) {
  swe_out <- tryCatch(get_SWE_2021(site=site_list[i], date_today = Sys.Date()),
                      error = function(e) return())
}

# fetch historic data --------------------------------------------------------

## 1981-2010 POR is not available for all sites for historic comparison
## but still want all data for each site to build trend line of peak SWE and melt sm50

get_SWE_hist <- function(site) {
  
  site_meta <- sntl_meta %>% filter(site_id == site)
  year <- word(site_meta$start, 1,1, sep="-")
  sitey <- gsub('SNTL:', '', site_meta$site_id)
  
  ## pull data for nrcs historical range
  sntl <- grabNRCS.data(network = 'SNTL', 
                        site_id = sitey, 
                        timescale = 'daily', 
                        DayBgn = sprintf("%s-10-01", year),
                        DayEnd = "2020-09-30")
  
  if("Snow.Water.Equivalent..in..Start.of.Day.Values" %in% colnames(sntl)){
    
    sntl_clean <- clean_SWE(today = sntl) %>% mutate(site_id = sitey)
    write.csv(sntl_clean, sprintf('1_fetch/out/SNOTEL/swe_hist_%s.csv', sitey),row.names=FALSE)

  }
}

## pull historical data for all currently active sites
site_list <- unique(sntl_meta$site_id)

# this takes a hot minute
for (i in 1:length(site_list)) {
  swe_out <- tryCatch(get_SWE_hist(site=site_list[i]),
                      error = function(e) return())
}

