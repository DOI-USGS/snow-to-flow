
# processing SNOTEL data --------------------------------------------------

library(RNRCS)
library(tidyverse);library(reshape2);library(lubridate)
library(scico);library(patchwork)
library(maps);library(rmapshaper);library(sp);library(sf);library(raster);library(scales)

num <- function(x)length(unique(na.omit(x)))
se <- function(x) sqrt(var(x)/length(x))

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
    mutate(apr1_swe = swe)%>%
    dplyr::select(site_id, water_year, apr1_swe)
  
  # find peak swe and sm50_swe for each year
  peaks <- data %>%
    left_join(apr1)%>%
    group_by(site_id, water_year)%>%
    summarize(peak_swe = max(swe, na.rm=TRUE)) %>%
    mutate(sm50_swe = peak_swe/2)
  
  # find date of peak swe each year
  peak_dates <- data %>%
    left_join(peaks) %>%
    filter(swe == peak_swe)%>%
    group_by(site_id, water_year)%>%
    filter(water_day == max(water_day, na.rm=TRUE))%>%
    mutate(peak_date = date, peak_day = water_day)%>%
    dplyr::select(-date, -water_day, -swe, -year) %>%
    mutate(peak_met = ifelse(peak_date == Sys.Date(), 'TBD', NA))

  
  
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
    mutate(sm50_met = NA)
  
  ## if sm50 has not been met in 2021, add empty row with latest day
  #if (nrow(m50_dates%>%filter(water_year  == 2021)) == 0) {
    tbd_date <- data %>%
      left_join(peak_dates) %>%
      filter(water_year == 2021)%>%
      filter(water_day == max(water_day, na.rm=TRUE)) %>%
      mutate(sm50_day = water_day, 
             sm50_date = date) %>%
      dplyr::select(-date, -water_day, -swe)%>%
      mutate(sm50_met = 'TBD')
    
    m50_dates <- rbind(m50_dates, tbd_date)
  #}
  
  
  return(m50_dates)
  
}

## calculate for every year there is data
hist_files <- list.files('1_fetch/out/SNOTEL', pattern="hist", full.names=TRUE)
wy_files <- list.files('1_fetch/out/SNOTEL', pattern="wy2021", full.names=TRUE)

# read in and combine all data
hist_data <- lapply(hist_files, read_csv) %>% bind_rows()
wy_data <- lapply(wy_files, read_csv) %>% bind_rows()
all_data <- rbind(hist_data, wy_data)
num(all_data$site_id) # 846

## calculate annual metrics
all_stat <- calc_yr_stats(all_data)
num(all_stat$site_id) # 846
str(all_stat)

wy21<-all_stat%>%filter(water_year == 2021)
num(wy21$site_id) #835
str(wy21)

dubs<-wy21%>%group_by(site_id)%>%summarize(n=length(site_id))%>%filter(n>1)

wy21%>%filter(site_id %in% dubs$site_id)%>%arrange(site_id)


# find percentile of Apr 1st / given date ---------------------------------

## given a date, April 1st or most recent
## pull SWE, compare to 1981-2010 to find percentile
## if there is no POR,leave site in data with NA for ptile

wy_today <- wy_data %>% filter(date == '2021-03-22')
num(wy_today$site_id)

hist_today <- hist_data %>% filter(date == as.Date(sprintf("%s-%s-%s", year(date), month(Sys.Date()), day(as.Date('2021-03-22')))))
hist_por <- hist_today %>% filter(water_year > 1980 & water_year <= 2010 & site_id %in% wy_today$site_id & !is.na(swe))
num(hist_por$site_id) # 710

## how many years in the POR? (out of 30)
por_yrs <- hist_por %>%
  group_by(site_id)%>%
  summarize(wy_n = num(water_year)) 
por_20 <- por_yrs %>%
  filter(wy_n >= 20)
num(por_yrs$site_id) # 533 sites with 20+ years in POR

## get percentile for each site on today's date
percentile_df <- NULL
for (i in intersect(unique(wy_today$site_id), unique(por_20$site_id))){
  dv <- hist_por %>% filter(site_id == i)
  do <- wy_today %>% filter(site_id == i)
  percentile <- ecdf(dv$swe)
  percentile(do$swe)
  pout <- data.frame(site_id = i, ptile = percentile(do$swe))
  percentile_df <- rbind(percentile_df, pout)
}

## percentiles were calculated based on daily swe values for a given date compared to the period of record (1981-2010)
# sites were included if the had (1) at least 20 years of non-NA data in the POR  for given date, (2) were active during 2021 wy, (3)
# this was a total of 533 sites

# metadata for all SNOTEL sites
meta <- grabNRCS.meta('SNTL')

## combine with annual stats for
## includes all sites, including without POR
wy_stats <- all_stat %>% 
  filter(water_year == 2021)%>%
  left_join(percentile_df)%>%
  left_join(wy_today)%>%
  left_join(por_yrs)%>%
  filter(!(site_id %in% dubs$site_id & is.na(sm50_met)))%>%
  ungroup()%>%
  mutate(text_peak = ifelse(peak_met == 'TBD', 'TBD', peak_swe),
         text_sm50 = ifelse(sm50_met == 'TBD', 'TBD', sm50_day),
         text_today = ifelse(is.na(swe), 'no data', swe),
         text_ptile = ifelse(is.na(ptile), 'no data',NA))%>%
  left_join(meta$SNTL %>% dplyr::select(site_id, elev_ft, latitude, longitude, site_name)%>%
              mutate(site_id = as.numeric(gsub("SNTL:", "", site_id))))
str(wy_stats)

write_csv(wy_stats, '2_process/out/SNOTEL_stats_2021.csv')
## add trend d paths for peak, sm50, 2021 SWE
