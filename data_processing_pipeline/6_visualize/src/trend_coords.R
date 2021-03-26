
# export svgs for SNOTEL map insets ----------------------------------------------

library(xml2)
library(sf);library(rmapshaper)
library(tidyverse);library(reshape2)

# generate svg trend paths  -------------------------------------------------

## create d paths for trend lines of peak SWE, SM50, and WY2021, store in csv to call on mouseover event

## output dimensions
## creating a chart with many ovelrapping lines
## need the class to be the key to bind in browser

build_path_from_coords <- function(coords) {
  # Build path
  first_pt_x <- head(coords$x, 1)
  first_pt_y <- head(coords$y, 1)
  d <- sprintf("M%s %s %s", first_pt_x, head(coords$y, 1),
               paste0("L", c(tail(coords$x, -1)), " ", 
                      c(tail(coords$y, -1)), collapse = " "))
  return(d)
}

convert_trend_to_svg <- function(obj, svg_width, svg_height, ymax, ymin, xmin, xmax) {
  coords <- obj
  x_dec <- coords[,'x']
  y_dec <- coords[,'y']
  
  x_extent <- c(xmin, xmax) ## to scale each plot to the same space, use the full data extent
  y_extent <- c(ymin, ymax) # 130 for peak, 366 for sm50
  
  # Convert coords to SVG horizontal and vertical positions
  # Remember that SVG vertical position has 0 on top
  x_extent_pixels <- x_extent - xmin
  y_extent_pixels <- y_extent - ymin
  x_pixels <- x_dec - xmin #
  y_pixels <- y_dec - ymin 
  
  data.frame(
    x = round(approx(x_extent_pixels, c(0, svg_width), x_pixels$x)$y, 6),
    y = round(approx(y_extent_pixels, c(svg_height, 0), y_pixels$y)$y, 6)
  )
  
}
## some small error with function above not working for points...
convert_pt_to_svg <- function(obj, svg_width, svg_height, ymax, ymin, xmin, xmax) {
  coords <- obj
  x_dec <- coords[,'x']
  y_dec <- coords[,'y']
  
  x_extent <- c(xmin, xmax) 
  y_extent <- c(ymin, ymax) 
  

  x_extent_pixels <- x_extent - xmin
  y_extent_pixels <- y_extent - ymin
  x_pixels <- x_dec - xmin 
  y_pixels <- y_dec - ymin 
  
  data.frame(
    x = round(approx(x_extent_pixels, c(0, svg_width), x_pixels)$y, 6),
    y = round(approx(y_extent_pixels, c(svg_height, 0), y_pixels)$y, 6)
  )
  
}

init_svg <- function(viewbox_dims) {
  # create the main "parent" svg node. This is the top-level part of the svg
  svg_root <- xml_new_root('svg', viewBox = paste(viewbox_dims, collapse=" "), 
                           preserveAspectRatio="xMidYMid meet", 
                           xmlns="http://www.w3.org/2000/svg", 
                           `xmlns:xlink`="http://www.w3.org/1999/xlink", 
                           version="1.1")
  return(svg_root)
}


# generate svg d paths ----------------------------------------------------

## vue build data
conus_stat <- read_csv('2_process/out/SNOTEL_conus.csv') %>% filter(water_year >= 1981) 
ak_stat <- read_csv('2_process/out/SNOTEL_ak.csv') %>% filter(water_year >= 1981) 

## trend data
all_stat <- read_csv('2_process/out/SNOTEL_stats_POR.csv')%>%
  mutate(peak_swe_sqrt = sqrt(peak_swe),
         peak_swe_log = log(peak_swe+1))

## to set fixed chart limits
range(all_stat$water_year)
range(all_stat$peak_swe)
range(all_stat$sm50_day)
all_stat%>%filter(sm50_day <= 50)
range(na.omit(all_stat$apr1_swe))
all_stat%>%
  ggplot()+
  geom_histogram(aes(sm50_day))+
  scale_color_scico(palette="lajolla")

range(all_stat$peak_swe_log)
range(all_stat$peak_swe_sqrt)

str(all_stat)

## timeseries across years - peak SWE, SM50
## sizing of the mini plot that pops up
time_w <- 200
time_h <- 100

# drawing svg paths for each line

## create dataframe with svg d paths
df_out <- NULL
for  (i in unique(all_stat$site_id)){
  all_site <- all_stat %>% filter(site_id == i) %>% arrange(water_year)
  all_site$x <- all_site$water_year
  
  # peak swe
  all_site$y <- all_site$peak_swe
  site_obj <- all_site %>% dplyr::select(x,y)
  peak <- convert_trend_to_svg(obj = site_obj, svg_width = time_w, svg_height = time_h, 
                               ymax=130, ymin = 0, xmin = 1981, xmax= 2021) %>%
    build_path_from_coords()
  
  all_site$y <- all_site$peak_swe_log
  site_obj <- all_site %>% dplyr::select(x,y)
  peak_log <- convert_trend_to_svg(obj = site_obj, svg_width = time_w, svg_height = time_h, 
                               ymax=5, ymin = 0, xmin = 1981, xmax= 2021) %>%
    build_path_from_coords()
  
  all_site$y <- all_site$peak_swe_sqrt
  site_obj <- all_site %>% dplyr::select(x,y)
  peak_sqrt <- convert_trend_to_svg(obj = site_obj, svg_width = time_w, svg_height = time_h, 
                               ymax=11.5, ymin = 0, xmin = 1981, xmax= 2021) %>%
    build_path_from_coords()
  
  # swe date
  all_site$y <- all_site$sm50_day
  sm50 <- convert_trend_to_svg(obj = site_obj, svg_width = time_w, svg_height = time_h, 
                               ymax=366, ymin = 0, xmin = 1981, xmax= 2021) %>%
    build_path_from_coords()
  
  # swe date
  all_site$y <- all_site$apr1_swe
  apr1 <- convert_trend_to_svg(obj = site_obj, svg_width = time_w, svg_height = time_h, 
                               ymax=120, ymin=0, xmin = 1981, xmax= 2021) %>%
    build_path_from_coords()
  
  df_out <- rbind(df_out, 
                  data.frame(sntl_id = sprintf("sntl_%s", i),
                             d_peak = peak, d_sm50 = sm50, d_apr1 = apr1, 
                             d_peak_log = peak_log, d_peak_sqrt  = peak_sqrt))
  
}

str(df_out)

## timeseries within 2021 - SWE with coords for peak SWE and SM50
## sizing of the mini plot that pops up
wy_files <- list.files('1_fetch/out/SNOTEL', pattern="wy2021", full.names=TRUE)
wy_data <- lapply(wy_files, read_csv) %>% bind_rows()
str(wy_data)
range(na.omit(log(wy_data$swe+1)))

wy_stats <- read_csv('2_process/out/SNOTEL_stats_2021.csv')

year_w <- 200
year_h <- 200

# create dataframe with svg d paths
df_swe <- NULL
for  (i in unique(wy_data$site_id)){
  
  # swe through time
  all_site <- wy_data %>% filter(site_id == i) %>% arrange(water_day)
  all_site$x <- all_site$water_day
  all_site$y <- all_site$swe
  site_obj <- all_site %>% dplyr::select(x,y)
  swe <- convert_trend_to_svg(obj = site_obj, 
                              svg_width = year_w, svg_height = year_h, 
                              ymax=100, ymin = 0, xmin = 1, xmax = 180) %>%
    build_path_from_coords()
  
  
  all_site$x <- all_site$water_day
  all_site$y <- log(all_site$swe+1)
  site_obj <- all_site %>% dplyr::select(x,y)
  swe_log <- convert_trend_to_svg(obj = site_obj, 
                              svg_width = year_w, svg_height = year_h, 
                              ymax=5, ymin = 0, xmin = 1, xmax = 180) %>%
    build_path_from_coords()
  
  ## convert day  and value at peak SWE AND sm50 to coords
  sitey <- all_stat  %>% 
    filter(site_id == i & water_year == 2021) %>%
    dplyr::select(water_year, site_id, peak_swe, peak_day, sm50_swe, sm50_day, apr1_swe)%>%
    mutate(apr1_day = 173) %>%
    melt(id.vars=c('site_id','water_year'))%>%
    separate(variable, into=c('metric','var'), sep='_') %>%
    dcast(site_id + water_year + metric ~ var)
  sitey$x <- sitey$day
  sitey$y <- sitey$swe
  site_obj <- sitey %>% dplyr::select(x,y)
  swe_pts <- convert_pt_to_svg(obj = site_obj, 
                              svg_width = year_w, svg_height = year_h, 
                              ymax=100, ymin = 0, xmin = 1, xmax = 180) %>%
    mutate(metric = sitey$metric, site_id = i) %>%
    melt(id.vars=c("site_id","metric")) %>%
    dcast(site_id ~ metric + variable)

  swe_today<-data.frame(site_id = i, sntl_id = sprintf("sntl_%s", i), d_swe = swe, d_swe_log = swe_log,
                        d_swe_scaled = swe_scaled)%>%
    left_join(swe_pts)
  
  df_swe <- rbind(df_swe, swe_today)
  
}
str(df_swe)

# bind to site coordinates and export -------------------------------------

## add back to site-level coordinate data linked to mouseover effect
## so this datasheet has literally everything in it for the map
read.csv('2_process/out/SNOTEL_conus.csv') %>%
  mutate(sntl_id  = gsub("SNTL:", "sntl_", sntl_id)) %>%
  left_join(df_out)%>%
  left_join(df_swe) %>% 
  write_csv("6_visualize/out/SNOTEL_conus_d.csv")

read.csv('2_process/out/SNOTEL_ak.csv') %>%
  mutate(sntl_id  = gsub("SNTL:", "sntl_", sntl_id)) %>%
  left_join(df_out)%>%
  left_join(df_swe) %>% 
  write_csv("6_visualize/out/SNOTEL_ak_d.csv")

file.copy("6_visualize/out/SNOTEL_conus_d.csv",
          "C:/Users/cnell/Documents/Projects/snow-to-flow/public/data/SNOTEL_conus_d.csv",
          overwrite = TRUE)
file.copy("6_visualize/out/SNOTEL_ak_d.csv",
          "C:/Users/cnell/Documents/Projects/snow-to-flow/public/data/SNOTEL_ak_d.csv",
          overwrite = TRUE)

