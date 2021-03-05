library(snotelr)
library(soilDB);library(RNRCS)
library(tidyverse);library(reshape2)
library(scico);library(patchwork)
library(maps);library(rmapshaper)
library(elevatr);library(tidyverse)
library(sp);library(sf);library(raster)
library(lubridate)
library(scales)


num <- function(x)length(unique(na.omit(x)))


# functions for processing SNOTEL data ------------------------------------

# fetch and process data --------------------------------------------------

# pull metadata for all SNOTEL sites
meta <- grabNRCS.meta('SNTL')
num(meta$SNTL$wyear)
num(meta$SNTL$site_id) #881 sites

## find start and end dates for each site
sntl_meta<-meta$SNTL%>%distinct(site_id, wyear, start, enddate) 

## drop sites not active in 20201
sntl_active<-meta$SNTL%>%filter(enddate == '2100-January')#875 currently active sites

## nrcs historical = 1981 - 2010
## how many sites have that historical??
sntl_hist<-sntl_active %>%
  mutate(ano = word(start, 1, 1, sep="-"))%>%
  filter(ano <= 2000)
str(sntl_hist) # 469 sites that are currently active and have on or before 1981

# start and end dates for each site
sntl_meta <- sntl_hist %>% distinct(site_id, wyear, start, enddate)

## pull SWE forall data, all sites with 20+ years of data
clean_SWE <- function(today){
  
  # organize data, make water year variables
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
    select(date, water_year, water_day, swe, year) 
  
  
  return(site_curve)
}

get_SWE_today <- function(site, date_today) {
  
  date <- as.Date(date_today)
  year <- word(site_meta$start, 1,1, sep="-")
  site_meta <- sntl_meta %>% filter(site_id == site)
  
  sitey <- gsub('SNTL:', '', site_meta$site_id)
  
  ## pull data for nrcs historical range
  sntl <- grabNRCS.data(network = 'SNTL', 
                        site_id = sitey, 
                        timescale = 'daily', 
                        DayBgn = sprintf("%s-10-01", year),
                        DayEnd = date)
  
  
  if("Snow.Water.Equivalent..in..Start.of.Day.Values" %in% colnames(sntl)){
    
    sntl_clean <- clean_SWE(today = sntl) %>% mutate(site_id = sitey)
    write.csv(sntl_clean, sprintf('out/data/swe_today_all_%s.csv', sitey),row.names=FALSE)
    return(sntl_clean)
    
  }
  
  
  
}

today<-get_SWE_today(site=sntl_hist$site_id[430], date_today=Sys.Date())

## do this to all sites with 20+ years of data that are still active
site_list <- sntl_hist$site_id

swe_df <- NULL
for (i in 662:num(site_list)) {
  
  swe_out <- get_SWE_stats(site=site_list[i], date_today = Sys.Date())
  if (nrow(swe_out > 0)) {
    swe_df<-rbind(swe_df, swe_out)
    swe_out <- NULL
  }
  
}
grep('SNTL:670', sntl_hist$site_id)
## error at 33
length(site_list)#661


saveRDS(swe_df, 'out/data/swe_all.rds')
rm(swe_df)

# calculate snow metrics from time series data -----------------------------

calc_yr_stats <-  function(data){
  # find peak swe and sm50_swe for each year
  peaks <- data %>%
    group_by(site_id, water_year)%>%
    summarize(peak_swe = max(swe, na.rm=TRUE)) %>%
    mutate(sm50 = peak_swe/2)
  
  # find date of peak swe each year
  peak_dates <- data %>%
    left_join(peaks) %>%
    filter(swe == peak_swe)%>%
    group_by(water_year)%>%
    filter(water_day == max(water_day, na.rm=TRUE))%>%
    mutate(peak_date = date, peak_water_day = water_day)%>%
    select(-date, -water_day, -swe, -year) 
  str(peak_dates)
  
  # find date of sm50_swe for each year
  m50_dates <- data %>%
    left_join(peak_dates) %>%
    group_by(site_id, water_year)%>%
    filter(water_day > peak_water_day) %>%
    filter(swe <= sm50) %>%
    filter(water_day == min(water_day, na.rm=TRUE)) %>%
    mutate(sm50_day = water_day, 
           sm50_date = date, sm50_swe = swe) %>%
    select(-date, -water_day, -swe)
  
  return(m50_dates)
  
}

site_stats_yr <- function(data, grp) {
  
  ## peak SWE, sm50 for each year in record
  data_yr <- calc_yr_stats(data) ## calculates  for each water year
  
  # peak swe and sm50 
  data_yr_s <- data_yr %>%  select(-year, -sm50_swe)
  
  colnames(data_yr_s) <- c('water_year', 'site_id',
                           sprintf('%s_peak', grp),
                           sprintf('%s_sm50', grp),
                           sprintf('%s_peak_date', grp),
                           sprintf('%s_peak_day', grp),
                           sprintf('%s_sm50_day', grp),
                           sprintf('%s_sm50_date', grp))
  
  ## overall SWE mean, median, n, sd
  # data_grp_yr <- data %>%
  #   group_by(site_id, water_year)%>%
  #   summarize(grp_n=length(unique(na.omit(year))))
  # 
  # colnames(data_grp_yr) <- c('site_id','water_year',
  #                        sprintf('%s_n', grp),
  #                        sprintf('%s_sd', grp))
  #                        
  #data_yr_calc <- data_yr_s %>% left_join(data_grp_yr)
  return(data_yr_s)
  
}

## single day comparison given a site
## calculate annual metrics - peak SWE, sm50_day - mean, median, n, sd
## calculate metrics for given day in record - mean,  median,  n, sd
get_past_stats <- function(fp_in, date_today){
  
  date_today <- as.Date(date_today)
  mon_day<- paste0(month(date_today),'_',day(date_today))
  
  ## filter to this day across POR
  data_in <- read.csv(fp_in)# %>%
  
  empties <- data_in %>% filter(!is.na(swe))
  
  if(nrow(empties) == 0) {
    
  } else {
    
    ## calculate for each year in period of record
    por_all <- data_in %>% filter(water_year != 2021)
    
    por_yr <- site_stats_yr(por_all, grp = 'POR') # peak SWE, SM50
    write.csv(por_yr, sprintf('out/POR/sntl_por_%s.csv', unique(por_yr$site_id)), row.names=FALSE)
    
    ## calculate for NRCS historic periods (1981-2010)
    nrcs_all <- data_in %>% 
      filter(water_year >= 1981 & water_year <= 2010)
    empties <- nrcs_all %>% filter(!is.na(swe))
    
    if(nrow(empties) == 0) {
      
    } else {
      
      nrcs_yr <- site_stats_yr(nrcs_all, grp = 'NRCS')
      write.csv(nrcs_yr, sprintf('out/NRCS/sntl_nrcs_%s.csv', unique(nrcs_yr$site_id)), row.names=FALSE)
    }
  }
  
}

today_files <- list.files('out/data/', pattern="swe_today_all_", , full.names=TRUE)
length(today_files) #647

for (i in 1:length(today_files)) {
  get_past_stats(fp_in =today_files[i], date_today =Sys.Date())
}

## summary statistics for each POR and NRCS record
por_list <- list.files('out/POR/', pattern="sntl_por_", full.names=TRUE)
nrcs_list <- list.files('out/NRCS/', pattern="sntl_nrcs_", full.names=TRUE)

## for daily metrics
site_stats <-  function(fp_in, grp) {
  
  data <- read.csv(fp_in)
  
  ## overall SWE mean, median, n, sd
  data_grp <- data %>%
    group_by(site_id)%>%
    summarize(grp_swe_avg = mean(swe, na.rm=TRUE), 
              grp_swe_mdn = median(swe, na.rm=TRUE), 
              grp_n=length(unique(na.omit(year))),
              grp_swe_sd = sd(swe, na.rm=TRUE))
  
  colnames(data_grp) <- c('site_id',
                          sprintf('%s_avg', grp),
                          sprintf('%s_mdn', grp),
                          sprintf('%s_n', grp),
                          sprintf('%s_sd', grp))
  
  return(data_grp)
  
}

## find summary stats arcross all recorded years
por<-lapply(por_list, function(x)site_stats(x, grp = 'POR'))
write.csv(por, 'data/POR_summary.csv', row.names=FALSE)

nrcs<-lapply(nrcs_list, function(x)site_stats(x, grp = 'NRCS'))
write.csv(nrcs, 'data/NRCS_summary.csv', row.names=FALSE)


## find peak SWE and SM50 for 2021 and 2020
# read in just this water year
today_in_swe <- lapply(today_files, function(x) {
  
  data_in <- read.csv(x) 
  data_out <- data_in %>% filter(water_year==2021)
  return(data_out)
}
)
str(today_in_swe)

today_swe <-today_in_swe %>% bind_rows()
write.csv(today_swe, 'out/data/swe_2021.csv', row.names=FALSE)

calc_2021_stats <-  function(data){
  data_out <- NULL
  # find peak swe and sm50_swe for each year
  peaks <- data %>%
    group_by(site_id, water_year)%>%
    summarize(peak_swe = max(swe, na.rm=TRUE)) %>%
    mutate(sm50 = peak_swe/2)
  
  # find date of peak swe each year
  peak_dates <- data %>%
    left_join(peaks) %>%
    filter(swe == peak_swe)%>%
    group_by(site_id, water_year)%>%
    filter(water_day == max(water_day, na.rm=TRUE))%>%
    mutate(peak_date = date, peak_water_day = water_day)%>%
    select(-date, -water_day, -swe, -year) 
  
  # find date of sm50_swe for each year
  m50_date_range <- data %>%
    left_join(peak_dates) %>%
    group_by(site_id, water_year)%>%
    filter(water_day >= peak_water_day) 
  
  sites <- unique(m50_date_range$site_id)
  
  for (i in 1:length(sites)) {
    site_rows <- m50_date_range %>% filter(site_id == sites[i])
    
    #peak day
    print(i)
    
    # if there is no  sm50
    # dates after peak swe but more
    if (min(na.omit(site_rows$swe)) > unique(site_rows$sm50)){
      current <- site_rows %>%
        filter(water_day == max(water_day)) %>%
        mutate(sm50_day = NA, 
               sm50_date = NA, 
               sm50_swe = NA) %>%
        select(-date, -water_day, -swe)
      
    } else {
      current <- site_rows %>%
        filter(swe <= sm50) %>%
        filter(water_day == min(water_day)) %>%
        mutate(sm50_day = water_day, 
               sm50_date = date, 
               sm50_swe = swe) %>%
        select(-date, -water_day, -swe)
    }
    
    
    data_out <- rbind(data_out, current)
  }
  
  return(data_out)
}
today_stats <- calc_2021_stats(today_swe)
write.csv(today_stats, 'out/data/swe_2021_today.csv', row.names=FALSE)

# repeat for 2020
today_in_swe <- lapply(today_files, function(x) {
  
  data_in <- read.csv(x) 
  data_out <- data_in %>% filter(water_year==2020)
  return(data_out)
}
)
today_swe <- today_in_swe %>% bind_rows()
write.csv(today_swe, 'out/data/swe_2020.csv', row.names=FALSE)


data_out <- NULL
# find peak swe and sm50_swe for each year
peaks <- today_swe %>%
  group_by(site_id, water_year)%>%
  summarize(peak_swe = max(swe, na.rm=TRUE)) %>%
  mutate(sm50 = peak_swe/2)

# find date of peak swe each year
peak_dates <- today_swe %>%
  left_join(peaks) %>%
  filter(swe == peak_swe)%>%
  group_by(site_id, water_year)%>%
  filter(water_day == max(water_day, na.rm=TRUE))%>%
  mutate(peak_date = date, peak_water_day = water_day)%>%
  select(-date, -water_day, -swe, -year) 
peak_dates
# find date of sm50_swe for each year
m50_date_range <- today_swe %>%
  left_join(peak_dates) %>%
  group_by(site_id, water_year)%>%
  filter(water_day >= peak_water_day) 
m50_date_range
sites <- unique(m50_date_range$site_id)
sites
for (i in 1:length(sites)) {
  site_rows <- m50_date_range %>% filter(site_id == sites[i])
  
  #peak day
  print(i)
  
  # if there is no  sm50
  # dates after peak swe but more
  if (min(na.omit(site_rows$swe)) > unique(site_rows$sm50)){
    current <- site_rows %>%
      filter(water_day == max(water_day)) %>%
      mutate(sm50_day = NA, 
             sm50_date = NA, 
             sm50_swe = NA) %>%
      select(-date, -water_day, -swe)
    
  } else {
    current <- site_rows %>%
      filter(swe <= sm50) %>%
      filter(water_day == min(water_day)) %>%
      mutate(sm50_day = water_day, 
             sm50_date = date, 
             sm50_swe = swe) %>%
      select(-date, -water_day, -swe)
  }
  
  
  data_out <- rbind(data_out, current)
}
data_out

write.csv(data_out, 'out/data/swe_2020_2021.csv', row.names=FALSE)
##thesesame can  be regenerated each day and used fordaily or annualtrends


# annual trends -----------------------------------------------------------

## calculate trend metrics for 2021 and 2020 peak and sm50

#read in 2020 peak and sm50
ncrs <- read.csv('data/NRCS_summary.csv')
View(ncrs)
now <-read.csv('out/data/swe_2020_2021.csv')%>%
  select(-year)
str(now)

site_fp<-por_list[1]
site_por <- lapply(por_list, read.csv) %>% bind_rows() # allsiteall years POR
site_por

site_now <- now %>%filter(site_i)

por_stat <- site_por %>% 
  mutate(POR_sm50 = POR_sm50_day) %>%
  group_by(site_id) %>%
  summarize(across(c(POR_peak, POR_sm50), 
                   list(mean = ~mean(na.omit(.x)),
                        median = ~mean(na.omit(.x)),
                        sd = ~sd(na.omit(.x)))))  %>%
  left_join(now) %>%
  mutate

por_diff<-por_stat %>%
  mutate(diff_peak = get_diff(POR_peak_mean,peak_swe),
         diff_sm50 = get_diff(POR_sm50_mean,sm50_day),
         perd_peak =perc_ch(POR_peak_mean,peak_swe),
         perd_sm50 =perc_ch(POR_sm50_mean,sm50_day),
         perpast_peak =perc_past(POR_peak_mean,peak_swe),
         perpast_sm50 =perc_past(POR_sm50_mean,sm50_day),
         anom_peak = anomaly(POR_peak_mean,POR_peak_sd,peak_swe),
         anom_sm50 = anomaly(POR_sm50_mean,POR_sm50_sd,sm50_day))%>%
  select(site_id, water_year, diff_peak, diff_sm50 ,perd_peak, perd_sm50, perpast_peak,  perpast_sm50, anom_peak, anom_sm50)

write.csv(por_diff, 'out/data/POR_diff_20_21.csv',row.names=FALSE)

nrcs_diff %>%
  ggplot()+
  geom_point(aes(site_id, ))

## one site at a time
get_diff <- function(POR,  today) {
  today-POR
  
}
perc_ch <- function(POR, today){
  ((today-POR)/POR)*100
}
perc_past<-function(POR, today){
  (today/POR)*100
}
anomaly<-function(POR_mean, POR_sd, today){
  (today-POR_mean)/POR_sd
}

site_nrcs <- lapply(nrcs_list, read.csv) %>% bind_rows() # allsiteall years POR
site_nrcs

nrcs_stat <- site_nrcs %>% 
  mutate(NRCS_sm50 = NRCS_sm50_day) %>%
  group_by(site_id) %>%
  summarize(across(c(NRCS_peak, NRCS_sm50), 
                   list(mean = ~mean(na.omit(.x)),
                        median = ~mean(na.omit(.x)),
                        sd = ~sd(na.omit(.x)))))  %>%
  left_join(now) %>%
  mutate

NRCS_diff<-nrcs_stat %>%
  mutate(diff_peak = get_diff(NRCS_peak_mean,peak_swe),
         diff_sm50 = get_diff(NRCS_sm50_mean,sm50_day),
         perd_peak =perc_ch(NRCS_peak_mean,peak_swe),
         perd_sm50 =perc_ch(NRCS_sm50_mean,sm50_day),
         perpast_peak =perc_past(NRCS_peak_mean,peak_swe),
         perpast_sm50 =perc_past(NRCS_sm50_mean,sm50_day),
         anom_peak = anomaly(NRCS_peak_mean,NRCS_peak_sd,peak_swe),
         anom_sm50 = anomaly(NRCS_sm50_mean,NRCS_sm50_sd,sm50_day))%>%
  select(site_id, water_year, diff_peak, diff_sm50 ,perd_peak, perd_sm50, perpast_peak,  perpast_sm50, anom_peak, anom_sm50)
NRCS_diff
write.csv(NRCS_diff, 'out/data/NRCS_diff_20_21.csv',row.names=FALSE)


# given date comparisons --------------------------------------------------


## for a given date, find swe for POR and NRCS


##for a given date, calculate trend in swe for POR and NRCS



# QAQC --------------------------------------------------------------------

se <- function(x) sqrt(var(x)/length(x))

hist_files <- list.files('out/data', pattern="hist", full.names=TRUE)
hist_files

hist <- lapply(hist_files, read.csv)%>%bind_rows()
str(hist)

# how many years of data for each site?
hist_20yrs<-hist%>%
  group_by(site_id)%>%
  summarize(yrs=num(water_year))%>%
  filter(yrs >= 20)
str(hist_20yrs) ## reduces to 462 sites, most sites have 30/30 years of data

# what day is the sm50 and peak swe usually on? before april 1st? 

hist_site <- hist %>%
  filter(site_id %in% hist_20yrs$site_id) %>%
  group_by(site_id)%>%
  summarize(mean_peak=mean(peak_swe), se_peak = se(peak_swe),
            mean_sm50=mean(sm50_water_day), se_sm50 = se(sm50_water_day))


ggplot(data=hist_site, aes(site_id, mean_peak))+
  geom_point() +
  geom_errorbar(aes(ymin=mean_peak-se_peak, ymax=mean_peak+se_peak), width=.1)+
  geom_hline(yintercept=mean(hist_site$mean_peak), color="orchid", size=1, lty="dashed")+
  theme_classic()
# around 20

ggplot(data=hist_site, aes(site_id, mean_sm50))+
  geom_point() +
  geom_errorbar(aes(ymin=mean_sm50-se_sm50, ymax=mean_sm50+se_sm50), width=.1)+
  geom_hline(yintercept=mean(hist_site$mean_sm50), color="orchid", size=1, lty="dashed")+
  theme_classic()
# around 215-220``

# by year
hist_yr <- hist %>%
  filter(site_id %in% hist_20yrs$site_id) %>%
  group_by(water_year)%>%
  summarize(mean_peak=mean(peak_swe), se_peak = se(peak_swe),
            mean_sm50=mean(sm50_water_day), se_sm50 = se(sm50_water_day))


ggplot(data=hist_yr, aes(water_year, mean_peak))+
  geom_point() +
  geom_errorbar(aes(ymin=mean_peak-se_peak, ymax=mean_peak+se_peak), width=.1)+
  geom_line()+
  geom_smooth(method="loess")+
  geom_hline(yintercept=mean(hist_site$mean_peak), color="orchid", size=1, lty="dashed")+
  theme_classic()
# around 20

ggplot(data=hist_yr, aes(water_year, mean_sm50))+
  geom_point() +
  geom_errorbar(aes(ymin=mean_sm50-se_sm50, ymax=mean_sm50+se_sm50), width=.1)+
  geom_line()+
  geom_smooth(method="loess")+
  geom_hline(yintercept=mean(hist_site$mean_sm50), color="orchid", size=1, lty="dashed")+
  theme_classic()

#there is less water and it's later, sort of. lots of temporal variation

## what is the temporal trend for these variables?
hist%>%
  filter(site_id %in% hist_20yrs$site_id) %>%
  ggplot()+
  geom_line(aes(water_year, sm50_water_day, group=site_id), alpha=.5)+
  theme_classic()

hist%>%
  filter(site_id %in% hist_20yrs$site_id) %>%
  ggplot()+
  geom_line(aes(peak_swe, sm50_water_day, group=site_id), alpha=.5)+
  geom_point(aes(peak_swe, sm50_water_day, group=site_id), size=.1, alpha=.5,color="orchid")+
  theme_classic()



## look at current data
now_files <- list.files('out/data', pattern="current", full.names=TRUE)
now_files

now_dos <- lapply(now_files, function(x)read.csv(x, colClass=col_types))
str(now)
bind_rows(now)

now[[43]]

### drop empties
str(now[[3]])
colTypes(now[[3]])
col_types<-sapply(now[[5]], class)

str(now, max.level = 1)

now_keep<-now[sapply(now, nrow)>0]
recent<-now_keep%>%bind_rows()
str(recent)


# calculate metrics -------------------------------------------------------


## difference between today and past

prez<-recent %>%
  melt(id.vars=c('site_id','water_year')) %>%
  dcast(site_id ~ variable + water_year)


past <- hist%>%
  filter(site_id %in% hist_20yrs$site_id) #%>%
str(past)

past_prez<-past %>% 
  group_by (site_id)%>%
  summarize(mean_peak=mean(peak_swe), median_peak = median(peak_swe),
            se_peak = se(peak_swe),sd_peak = sd(peak_swe),
            mean_sm50=mean(sm50_water_day), median_sm50 = median(sm50_water_day),
            se_sm50 = se(sm50_water_day),sd_sm50 = sd(sm50_water_day)) %>%
  left_join(prez) %>%
  mutate(across(everything(), as.numeric)) %>%
  mutate(peak_swe_diff_2021 = peak_swe_2021 - median_peak,
         peak_swe_diff_2020 = peak_swe_2020 - median_peak,
         sm50_diff_2021 = sm50_2021 - mean_sm50,
         sm50_diff_2020 = sm50_2020 - mean_sm50) %>%
  mutate(peak_anomaly_2020 = (peak_swe_2020-mean_peak)/sd_peak,
         peak_anomaly_2021 = (peak_swe_2021-mean_peak)/sd_peak,
         sm50_anomaly_2020 = (sm50_water_day_2020-mean_sm50)/sd_sm50,
         sm50_anomaly_2021 = (sm50_water_day_2021-mean_sm50)/sd_sm50,
         peak_perc_2020 = ((peak_swe_2020/mean_peak)),
         peak_perc_2021 = ((peak_swe_2021/mean_peak)),
         peak_percdiff_2020 = ((peak_swe_2020-mean_peak)/mean_peak),
         peak_percdiff_2021 = ((peak_swe_2021-mean_peak)/mean_peak))

## anomaly
# change relative to a reference period in a standardized format
# difference between current period anf reference, scaled by the division of ref standard deviation
# ( current - mean(ref))/sd(ref)
# makes easy to use consistent untis to shaow variability among lcoation in a comparable way



# prep data for visualization ---------------------------------------------



ggplot()+
  geom_sf(data=states, fill=NA)+
  geom_sf(data=sntl_sf%>%filter(!is.na(peak_swe_diff_2020)), aes(color = peak_swe_diff_2020))+
  scale_color_gradientn(colors=rev(c("dodgerblue","turquoise","green","lightgreen","white","yellow","orange","orangered","red")),
                        values=rescale(c(-12.5, -9.375, -6.25,  -3.1225, 0, 3.125, 6.25, 9.375, 12.5)), limits=c(-12.5, 12.5))
## this mimics what is in the mapper


ggplot()+
  geom_sf(data=states, fill=NA)+
  geom_sf(data=sntl_sf%>%filter(!is.na(peak_swe_diff_2020)), aes(color = peak_swe_diff_2020))+
  scale_color_scico(palette="nuuk", direction=-1)+
  theme_void()


## plotting anomalies
ggplot()+
  geom_sf(data=states, fill=NA)+
  geom_sf(data=sntl_sf%>%filter(!is.na(peak_anomaly_2020)), aes(color = peak_anomaly_2020))+
  scale_color_scico(palette="broc", direction=-1)+
  theme_void()


ggplot()+
  geom_sf(data=states, fill=NA)+
  geom_sf(data=sntl_sf%>%filter(!is.na(peak_anomaly_2021)), aes(color = peak_anomaly_2021))+
  scale_color_scico(palette="broc", direction=-1)+
  theme_void()
## only a few sites thatare very extreme


ggplot()+
  geom_sf(data=states, fill=NA)+
  geom_sf(data=sntl_sf%>%filter(!is.na(peak_anomaly_2020)), aes(color = sm50_anomaly_2020))+
  scale_color_scico(palette="broc", direction=-1, limits=c(-3,3))+
  theme_void()


ggplot()+
  geom_sf(data=states, fill=NA)+
  geom_sf(data=sntl_sf%>%filter(!is.na(peak_anomaly_2021)), aes(color = sm50_anomaly_2021))+
  scale_color_scico(palette="broc", direction=-1, limits=c(-3,3))+
  theme_void()

## percent of POR average
ggplot()+
  geom_sf(data=states, fill=NA)+
  geom_sf(data=sntl_sf%>%filter(!is.na(peak_anomaly_2020)), aes(color = peak_perc_2021))+
  scale_color_gradientn(limits=c(0, 2), 
                        colors=rev(c("dodgerblue","turquoise","green","lightgreen","white","yellow","orange","orangered","red")),
                        values=rescale(c(0,.25,.5,.75,1,1.25,1.5,1.75,2)))+
  theme_void()


ggplot()+
  geom_sf(data=states, fill=NA)+
  geom_sf(data=sntl_sf%>%filter(!is.na(peak_anomaly_2021)), aes(color = peak_percdiff_2020))+
  scale_color_scico(palette="hawaii", direction=1, limits=c(-.5, .5))+
  theme_void()

# save sites for map ------------------------------------------------------

## reproject sites and export as shapefile to add to map
nrcs <- read.csv('out/data/NRCS_diff_20_21.csv')
por <- read.csv('out/data/POR_diff_20_21.csv')

# export sites for  cONUS & AK, POR &NRCS

## SNOTEL sites
sntl_sf <- meta$SNTL %>%
  select(-wyear)%>%
  mutate(site_id = as.numeric(gsub('SNTL:','', site_id))) %>%
  st_as_sf(coords=c('longitude','latitude'), crs=4326)
glimpse(sntl_sf)


# conus
state_no <- c('Alaska','Guam','Hawaii','Puerto Rico','American Samoa', 'Commonwealth of the Northern Mariana Islands', "United States Virgin Islands")
usa <- st_read('data/cb_2018_us_state_5m/cb_2018_us_state_5m.shp') %>% 
  st_transform(proj_conus) %>% 
  ms_simplify(keep=.2) %>% 
  st_buffer(0) %>%
  filter(!(NAME %in%state_no))

proj_conus <-'+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs'

por_conus<-sntl_sf %>% 
  filter(site_id %in% unique(por$site_id))%>%
  st_transform(proj_conus) %>%
  st_intersection(usa) %>%
  dplyr::select(site_id, state) #%>%
st_write(por_conus, 'data/SNOTEL_conus_por.shp', driver = 'ESRI Shapefile', delete_layer=TRUE)
plot(por_conus)

nrcs_conus<-sntl_sf %>% 
  filter(site_id %in% unique(nrcs$site_id))%>%
  st_transform(proj_conus) %>%
  st_intersection(usa) %>%
  dplyr::select(site_id,state) #%>%
st_write(nrcs_conus, 'data/SNOTEL_conus_nrcs.shp', driver = 'ESRI Shapefile', delete_layer=TRUE)
plot(nrcs_conus)

# alaska
proj_ak  <- '+proj=aea +lat_1=55 +lat_2=65 +lat_0=50 +lon_0=-154 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs '

alaska <- st_read('data/cb_2018_us_state_5m/cb_2018_us_state_5m.shp') %>% 
  st_transform(proj_ak) %>% 
  ms_simplify(keep=.2) %>% 
  st_buffer(0) %>%
  filter(NAME == 'Alaska')
alaska

por_ak<-sntl_sf %>% 
  filter(site_id %in% unique(por$site_id))%>%
  st_transform(proj_ak) %>%
  st_intersection(alaska) %>%
  dplyr::select(site_id, state) 
st_write(por_ak,'data/SNOTEL_ak_por.shp', driver = 'ESRI Shapefile', delete_layer=TRUE)
plot(por_ak)

nrcs_ak<-sntl_sf %>% 
  filter(site_id %in% unique(nrcs$site_id))%>%
  st_transform(proj_ak) %>%
  st_intersection(alaska) %>%
  dplyr::select(site_id,state)
st_write(nrcs_ak, 'data/SNOTEL_ak_nrcs.shp', driver = 'ESRI Shapefile', delete_layer=TRUE)
plot(nrcs_ak)


