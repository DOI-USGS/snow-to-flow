
# processing SNOTEL data --------------------------------------------------

library(tidyverse);library(reshape2);library(lubridate)
library(scico);library(patchwork)
library(maps);library(rmapshaper);library(sp);library(sf);library(raster);library(scales)

num <- function(x)length(unique(na.omit(x)))
se <- function(x) sqrt(var(na.omit(x))/length(na.omit(x)))

# calculate trend metrics from time series data ----------------------------

## annual metrics - peak SWE, date of peak SWE, melt (SM509), April 1st SWE
## some of these have not occurred yet in 2021! indicate if that is the case (i.e. it's TODAY but really TBD)

## exports
### wy 2021 timeseries with col indicating peak SWE and SM50
### timeseries - all years with cols for each metric and percentile they fall in

calc_yr_stats <-  function(data){
  
  ## april 1st SWE 
  apr1 <- data %>% 
    filter(date == sprintf('%s-04-01', year)) %>%
    mutate(apr1_swe = swe, apr1_day = water_day)%>%
    dplyr::select(site_id, water_year, apr1_swe, apr1_day)
  
  # find peak swe and sm50_swe for each year
  peaks <- data %>%
    group_by(site_id, water_year)%>%
    summarize(peak_swe = max(swe, na.rm=TRUE)) %>%
    mutate(sm50_swe = peak_swe/2)
    
  # find date of peak swe each year
  peak_dates <- data %>%
    left_join(peaks) %>%
    group_by(site_id, water_year)%>%
    filter(swe == peak_swe)%>%
    filter(water_day == max(water_day, na.rm=TRUE))%>% # take latest date peak is measured
    mutate(peak_date = date, peak_day = water_day)%>%
    dplyr::select(-date, -water_day, -swe, -year) %>%
    ungroup()%>%
    mutate(peak_met = case_when(
      as.character(peak_date) == Sys.Date() ~ 'TBD', 
      TRUE ~ as.character(peak_date)))

  # find date of sm50_swe for each year
  m50_dates <- data %>%
    left_join(peak_dates) %>%
    group_by(site_id, water_year)%>%
    filter(water_day >= peak_day) %>%
    filter(swe <= sm50_swe) %>%
    filter(water_day == min(water_day, na.rm=TRUE)) %>% # earliest water day at or below peak/2
    mutate(sm50_day = water_day, 
           sm50_date = date) %>%
    dplyr::select(-date, -water_day, -swe)%>%
    mutate(sm50_met = case_when(
      as.character(sm50_date) == Sys.Date() ~ 'TBD', 
      TRUE ~ as.character(sm50_date)))
  
  m50_current <- m50_dates %>% filter(water_year == 2021)
  
 # if sm50 has not been met in 2021, add empty row with latest day
  tbd_sites <- setdiff(unique(data$site_id), unique(m50_current$site_id))

     tbd_date <- data %>% 
       filter(water_year == 2021)%>%
       filter(site_id %in% tbd_sites) %>%
       left_join(peak_dates) %>%
        group_by(site_id, water_year)%>%
       filter(water_day == max(water_day, na.rm=TRUE)) %>% # set everything to latest date 
       mutate(sm50_day = water_day, 
              sm50_date = date) %>%
       dplyr::select(-date, -water_day, -swe)%>%
       mutate(sm50_met = 'TBD')
     
     data_out <- rbind(m50_dates, tbd_date) %>%
       left_join(apr1)

  return(data_out)
  
}

## calculate for every year there is data
hist_files <- list.files('1_fetch/out/SNOTEL', pattern="hist", full.names=TRUE)
wy_files <- list.files('1_fetch/out/SNOTEL', pattern="wy2021", full.names=TRUE)

# read in and combine all data
hist_data <- lapply(hist_files, read_csv) %>% bind_rows()
wy_data <- lapply(wy_files, read_csv) %>% bind_rows()
all_data <- rbind(hist_data, wy_data)%>%filter(water_year >= 1981)

## calculate annual metrics - peak swe, sm50, apr 1st swe, and water_day variables correspond to the last date pulled
all_stat <- calc_yr_stats(all_data)
write_csv(all_stat, '2_process/out/SNOTEL_stats_POR.csv')

# find percentile of Apr 1st / given date ---------------------------------

## given a date, April 1st or most recent
## pull SWE, compare to 1981-2010 to find percentile
## if there is no POR leave site in data with NA 

today <- '2021-04-26' ## find percentile for this date
wy_today <- wy_data %>% filter(date == today) # 834 sites for today

## all days in the historic record for this date
hist_today <- hist_data %>% 
  filter(date == as.Date(sprintf("%s-%s-%s", year(date), month(as.Date(today)), day(as.Date(today)))))

## filter to 1981-2011 period of record, only include sites that have data for current year
hist_por <- hist_today %>% 
  filter(water_year > 1980 & water_year <= 2010 & site_id %in% wy_today$site_id & !is.na(swe))
num(hist_por$site_id) # 722

## how many years in the POR for each site? (out of 30 possible)
por_yrs <- hist_por %>%
  group_by(site_id)%>%
  summarize(wy_n = num(water_year)) 

##  limit to sites with a minimum of 20 years in the POR
por_20 <- por_yrs %>%filter(wy_n >= 20)
num(por_20$site_id) # 542

## get percentile for each site on given date
percentile_df <- NULL
for (i in intersect(unique(wy_today$site_id), unique(por_20$site_id))){
  dv <- hist_por %>% filter(site_id == i)
  do <- wy_today %>% filter(site_id == i)
  
  p_swe <- ecdf(dv$swe)
  
  pout <- data.frame(site_id = i, 
                     ptile_swe = p_swe(do$swe))
  percentile_df <- rbind(percentile_df, pout)
}


# join percentiles to site-level data -------------------------------------

## percentiles were calculated based on daily swe values for a given date compared to the period of record (1981-2010)
# sites were included if the had (1) at least 20 years of non-NA data in the POR  for given date, (2) were active during 2021 wy, (3)
# this was a total of 542 sites

# metadata for all SNOTEL sites
meta <- RNRCS::grabNRCS.meta('SNTL')

## all_stat is the peak sm50 etc for each site and each year
## for 2021 -  each site with single row that has coordinates, this years peak and sm50 and if it's met
# with the d paths and ptile
# add to svg map coords so everything is in one place

## combine with annual stats for
## includes all sites, including without POR
conus_stat <- read.csv('6_visualize/out/conus_sites.csv') %>%# svg coordinates
  left_join(wy_today) %>% # todays swe
  left_join(all_stat %>% filter(water_year == 2021))%>% # plus peak and melt for this year
  left_join(percentile_df)%>% # plus percentile for todays swe
  left_join(por_yrs) %>% # plus the number of years in the POR
  left_join(meta$SNTL %>% # plus site level  data of interest
              dplyr::select(site_id, elev_ft, latitude, longitude, site_name) %>%
              mutate(sntl_id = site_id, 
                     site_id = as.numeric(gsub("SNTL:", "", sntl_id))) %>%
              transform(elev_ft = as.numeric(elev_ft)))

write_csv(conus_stat, '2_process/out/SNOTEL_conus.csv')

ak_stat <- read.csv('6_visualize/out/ak_sites.csv') %>%# svg coordinates
  left_join(wy_today) %>% # todays swe
  left_join(all_stat %>% filter(water_year == 2021))%>% # plus peak and melt for this year
  left_join(percentile_df)%>% # plus percentile for todays swe
  left_join(por_yrs) %>% # plus the number of years in the POR
  left_join(meta$SNTL %>% # plus site level  data of interest
              dplyr::select(site_id, elev_ft, latitude, longitude, site_name) %>%
              mutate(sntl_id = site_id, 
                     site_id = as.numeric(gsub("SNTL:", "", sntl_id))) %>%
              transform(elev_ft = as.numeric(elev_ft)))

write_csv(ak_stat, '2_process/out/SNOTEL_ak.csv')

## add trend d paths for peak, sm50, 2021 SWE using 6_visualize/src/trend_coords.R


# find percentile bands for current year ----------------------------------

# ptile for every day of this year
all_por <- all_data %>% 
  filter(water_year > 1980 & water_year <= 2010 & site_id %in% wy_today$site_id & !is.na(swe))


ptile_df <- NULL
for (i in intersect(unique(wy_today$site_id), unique(por_20$site_id))){
  dv <- all_por %>% filter(site_id == i)
  do <- wy_data %>% filter(site_id == i) %>% arrange(desc(water_day))

  for (j in unique(do$water_day)){
    de <- dv %>%filter(water_day == j)
    dr <- do %>%filter(water_day == j)
    p_q <- quantile(de$swe, probs = c(.1,.25, 0.5, .75, .9))
 
    ptile_df <- rbind(ptile_df, as.data.frame(p_q) %>%
                        rownames_to_column('p') %>% 
                        mutate(water_day = j, site_id = i) %>%
                        dcast(site_id+water_day~p, value.var='p_q')) 
  }

}

str(ptile_df)

