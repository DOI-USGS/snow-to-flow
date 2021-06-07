
# preliminaries -----------------------------------------------------------


library(tidyverse);library(sf);library(raster);library(stringr)
library(reshape2);library(lubridate)

# read in data ------------------------------------------------------------

ref_gages <- c('6696980','6614800','6746095','7083000','9034900','9035800','9035900','9047700','9065500','9066000','9066200','9066300','9306242')
non_ref <-c('6714800','7083200','9022000','9024000','9025000','9025300','9026500','9032000','9032100','9035500','9035700','9046490','9051050','9063900','9064000','9065100','9067000','9067200','9072550','9073005','9074000','9132985','9132995','9134000','9143500','9358550')

## gages
flow <- read.csv('data/daily_flow_2011_2012_GAGES2_upper_CO.csv') %>%
  mutate(date = as.Date(Date), 
         site_no = gsub('X', '', site_no),
         water_year = year(date) + ifelse(month(date) >= 10, 1, 0), 
         water_day = (date - as.Date(sprintf('%s-10-01', water_year)))) %>%
  group_by(water_year) %>%
  mutate(water_day_max = min(water_day)) %>% ungroup() %>%
  mutate(water_day = water_day - water_day_max + 1)%>%
  filter(site_no %in% ref_gages | site_no %in% non_ref) %>%
  select(-water_day_max)
str(flow)
length(unique(flow$site_no))

## SWE
swe <- read.csv('data/Broxton_daily_SWE_2011_2012_select_small_gages_2.csv') %>%
  select(-X) %>%
  melt(id.vars = c('date'),value.name = "swe") %>%
  mutate(date = as.Date(date),
         site_no = gsub('X', '', variable),
         water_year = year(date) + ifelse(month(date) >= 10, 1, 0), 
         water_day = (date - as.Date(sprintf('%s-10-01', water_year)))) %>%
  group_by(water_year) %>%
  mutate(water_day_max = min(water_day)) %>% ungroup() %>%
  mutate(water_day = water_day - water_day_max + 1)%>%
  filter(site_no %in% ref_gages | site_no %in% non_ref) %>%
  select(-water_day_max, -variable)
str(swe)
length(unique(swe$site_no))

both <- flow %>%
  left_join(swe) %>%
  filter(water_year %in% c(2011, 2012) &  site_no %in% min200$site_no)
str(both)


# drop sites with only afew data points
min200<-both %>% 
  group_by(site_no, mean_annual_snow_persistence, water_year)%>%
  summarize(n=length(unique(water_day)))%>%
  arrange(n)%>%
  filter(n>300 & site_no != '9073005', site_no != '9035800', site_no != '9306242')
length(unique(min200$site_no))
min200
range(min200$mean_annual_snow_persistence)

## data sequence for full year
date_list<-both %>%
  group_by(water_year)%>%
  filter(water_day == min(water_day) | water_day == max(water_day)) %>%
  distinct(water_year, water_day, date)
date_list

#both%>%filter(water_year == 2012)%>%
 # write.csv('C:/Users/cnell/Documents/Projects/snow-to-flow/public/data/mmd_df_2012.csv', row.names=FALSE)

bb<-both%>%filter(water_year == 2012)%>%
  select(site_no, Date, mmd, water_year, water_day, swe, sp=mean_annual_snow_persistence)%>%
  dcast(Date+water_year+water_day~site_no, value.var="mmd", fill=0)%>%
  arrange(water_day)%>%select(-Date, -water_year)
colnames(bb)<-paste0('site_',colnames(bb))  
write.csv(bb, 'C:/Users/cnell/Documents/Projects/snow-to-flow/public/data/mmd_df_2012.csv', row.names=FALSE)

bb<-both%>%filter(water_year == 2011)%>%
  select(site_no, Date, mmd, water_year, water_day, swe, sp=mean_annual_snow_persistence)%>%
  dcast(Date+water_year+water_day~site_no, value.var="mmd", fill=0)%>%
  arrange(water_day)%>%select(-Date, -water_year)
colnames(bb)<-paste0('site_',colnames(bb))  
write.csv(bb, 'C:/Users/cnell/Documents/Projects/snow-to-flow/public/data/mmd_df_2011.csv', row.names=FALSE)

sb11<-both%>%filter(water_year == 2011)%>%
  select(site_no, Date, mmd, water_year, water_day, swe, sp=mean_annual_snow_persistence)%>%
  dcast(Date+water_year+water_day~site_no, value.var="swe", fill=0)%>%
  arrange(water_day)%>%select(-Date, -water_year)
colnames(sb11)<-paste0('site_',colnames(sb11))  
write.csv(sb11, 'C:/Users/cnell/Documents/Projects/snow-to-flow/public/data/swe_df_2011.csv', row.names=FALSE)



sb12<-both%>%filter(water_year == 2012)%>%
  select(site_no, Date, mmd, water_year, water_day, swe, sp=mean_annual_snow_persistence)%>%
  dcast(Date+water_year+water_day~site_no, value.var="swe", fill=0)%>%
  arrange(water_day)%>%select(-Date, -water_year)
colnames(sb12)<-paste0('site_',colnames(sb12))  
write.csv(sb12, 'C:/Users/cnell/Documents/Projects/snow-to-flow/public/data/swe_df_2012.csv', row.names=FALSE)

both%>%
  select(site_no, water_year, water_day,swe, mmd)%>%
  melt(id.vars=c('site_no','water_year','water_day'))%>%
ggplot(aes(x=water_day, y=value, color=variable))+
  geom_line(aes(group=interaction(variable,site_no)))+
  facet_wrap(.~water_year)

sp<-both%>%
  mutate(site_no =paste0('site_',site_no),  sp=mean_annual_snow_persistence, elev = ELEV_MEAN_M_BASIN)%>%
  select(site_no, sp, elev)%>%
  distinct()%>%
  arrange(desc(sp))
unique(both$site_no)
max(both$swe)
max(both$mmd)

write.csv(sp, 'C:/Users/cnell/Documents/Projects/snow-to-flow/public/data/gage_sp.csv', row.names=FALSE)

nchar(sp$site_no)
# plot hydro curves -------------------------------------------------------

library(ggridges);library(scico)

theme_ridge <- function() {
  theme_ridges(grid=FALSE) +
    theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.line.y=element_blank(),
        legend.position="none",
        panel.grid = element_blank(),
        panel.spacing.y = unit(-5, "lines"), 
        strip.background = element_blank(),
        strip.text=element_blank())
}

## stacked by water year
ggplot(data=both, aes(x=water_day, group=site_no, color=mean_annual_snow_persistence))+
  geom_line(aes(y=mmd), size=1, alpha=.5, fill=NA)+
  theme_classic(base_size=20)+
  scale_x_continuous(limits=c(0, 365))+
  scale_color_scico(palette = "broc", direction = -1)+
  scale_fill_scico(palette = "broc", direction = -1)+
  labs(y=" ", x=" ")+
  theme_ridge()+
  facet_grid(water_year~.)


# ridgeline effect
ggplot(data=both%>%filter(water_year == 2011), aes(x=water_day, group=site_no, color=mean_annual_snow_persistence))+
  geom_line(aes(y=mmd), size=1, alpha=.5, fill=NA)+
  theme_classic(base_size=20)+
  scale_x_continuous(limits=c(0, 365))+
  scale_color_scico(palette = "broc")+
  scale_fill_scico(palette = "broc")+
  labs(y=" ", x=" ")+
  facet_grid(rev(mean_annual_snow_persistence)~., space="free")+
  theme_ridge()

site_ord<-both%>%
  distinct(site_no, mean_annual_snow_persistence)%>%
  arrange(desc(mean_annual_snow_persistence))

both<-both%>%mutate(facet_ord=factor(site_no,levels=site_ord$site_no))

library(patchwork)

ridge_2011 <- ggplot(data=both%>%filter(water_year == 2011), 
       aes(x=water_day, group=interaction(site_no, factor(water_year)), color=factor(water_year), fill=factor(water_year)))+
  geom_area(aes(y=mmd),alpha=.2)+
  geom_line(aes(y=mmd),alpha=.8, color="darkslateblue")+
  theme_classic(base_size=20)+
  scale_x_continuous(limits=c(0, 365))+
  scale_color_manual(values=c("turquoise","gold"))+
  scale_fill_manual(values=c("turquoise","gold"))+
  labs(y=" ", x=" ")+
  theme_ridge()+
  facet_grid(facet_ord~.)

ridge_2012 <- ggplot(data=both%>%filter(water_year == 2012), 
       aes(x=water_day, group=interaction(site_no, factor(water_year)), color=factor(water_year), fill=factor(water_year)))+
  geom_area(aes(y=mmd),alpha=.2)+
  geom_line(aes(y=mmd),alpha=.8, color="darkslateblue")+
  theme_classic(base_size=20)+
  scale_x_continuous(limits=c(0, 365))+
  scale_color_manual(values=c("turquoise","gold"))+
  scale_fill_manual(values=c("turquoise","gold"))+
  labs(y=" ", x=" ")+
  theme_ridge()+
  facet_grid(facet_ord~.)

ridge_2011 + ridge_2012


## both on same scale

ggplot(data=both, 
       aes(x=water_day, group=interaction(site_no, factor(water_year)), color=factor(water_year), fill=factor(water_year)))+
  geom_area(aes(y=mmd),alpha=.2)+
  geom_line(aes(y=mmd, color=water_year),alpha=.8)+
  theme_classic(base_size=20)+
  scale_x_continuous(limits=c(0, 365))+
  scale_color_manual(values=c("darkslateblue","brown"))+
  scale_fill_manual(values=c("turquoise","gold"))+
  labs(y=" ", x=" ")+
  theme_ridge()+
  facet_grid(facet_ord~water_year)
ggsave("out/both.png", width=10, height=7)

## plot mmd and swe together?
str(both)

date_list <- seq(as.Date('2010-10-01'), as.Date('2012-09-30'), by=1)
date_list
data_st <- both %>%
  filter(date<=date_list[180])




# animate mmd -------------------------------------------------------------
library(colorspace)

datey<-date_list[180]
datey

draw_mmd <- function(fp_out, width, height, datey){
  
  data_st <- both 
  
  filename <- sprintf('out/mmd_co/mmd_%s.png', gsub("-", "", as.character(datey)))
  
  
  png(filename = filename, units='px', width = width, height = height)
  
  print({
    
    
    ggplot(data = data_st,
           aes(x = water_day, group = interaction(site_no, water_year), y = mmd))+
      geom_area(data = data_st, fill = NA, color = NA, alpha = 0)+
      geom_area(data = data_st %>% filter(date <= datey), 
                fill = NA, color = NA, alpha = .2)+
      geom_line(data = data_st %>% filter(date <= datey), 
                aes(y = mmd, color = mmd), alpha = .8, size=.7)+
      theme_classic(base_size = 20)+
      scale_color_continuous_sequential(palette="ag_GrnYl", begin=.3)+
      scale_fill_continuous_sequential(palette="ag_GrnYl", begin=.3)+
      scale_x_continuous(limits=c(0, 365))+
      labs(y=" ", x=" ")+
      theme_ridge()+
      facet_grid(facet_ord~water_year)
    
    
  })
  
  dev.off()
  
  
}
for (i in date_list) {
  draw_mmd(fp_out = 'out/mmd_co/', width = 550, height = 400, datey = i)
}


# stitch to rasters -------------------------------------------------------

library(magick)

## animate the whole series!

#
length(list.files('out/mmd_co', full.names=TRUE))
mmd <- image_read(list.files('out/mmd_co', full.names=TRUE)[500])
swe <- image_read(list.files('out/co_swe', full.names=TRUE)[500])
img <- c(image_border(image_scale(swe, 'x350'), "white", "0x40"), mmd)

image_append(img, stack=TRUE)
img_out <-image_append(img)
img_out

image_write(img_out, path = "combo/both.png", format = "png")

for (i in 1:731) {
  mmd <- image_read(list.files('out/mmd_co', full.names=TRUE)[i])
  swe <- image_read(list.files('out/co_swe', full.names=TRUE)[i])
  img <- c(image_border(image_scale(swe, 'x350'), "white", "0x40"), mmd)
  
  img_out <-image_append(img)
  img_out
  
  image_write(img_out, path = sprintf("combo/both_%s.png",i), format = "png")
}
