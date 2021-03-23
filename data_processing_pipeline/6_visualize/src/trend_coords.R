
# export svgs for SNOTEL map ----------------------------------------------

library(rvest);library(xml2)
library(sf);library(rmapshaper)

# find site coords for map ------------------------------------------------

wy_stats <-read.csv('2_process/out/SNOTEL_stats_2021.csv')

proj_conus <-'+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs'
proj_ak  <- '+proj=aea +lat_1=55 +lat_2=65 +lat_0=50 +lon_0=-154 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs'

# areas not included in conus map
state_no <- c('Alaska','Guam','Hawaii','Puerto Rico','American Samoa', 'Commonwealth of the Northern Mariana Islands', "United States Virgin Islands")

#filter and reproject to states of interest
usa <- st_read('1_fetch/out/cb_2018_us_state_5m/cb_2018_us_state_5m.shp') %>% 
  st_transform(proj_conus) %>% 
  ms_simplify(keep=.2) %>% 
  st_buffer(0) %>%
  filter(!(NAME %in%state_no))

alaska <- st_read('1_fetch/out/cb_2018_us_state_5m/cb_2018_us_state_5m.shp') %>% 
  st_transform(proj_ak) %>% 
  ms_simplify(keep=.2) %>% 
  st_buffer(0) %>%
  filter(NAME == 'Alaska')

# export svg trend paths  -------------------------------------------------

## create d paths for trend lines of peak SWE, SM50, and WY2021, store in csv to call on mouseover event

hist_files <- list.files('1_fetch/out/SNOTEL', pattern="hist", full.names=TRUE)
wy_files <- list.files('1_fetch/out/SNOTEL', pattern="wy2021", full.names=TRUE)

# read in and combine all data
hist_data <- lapply(hist_files, read_csv) %>% bind_rows()
wy_data <- lapply(wy_files, read_csv) %>% bind_rows()
all_data <- rbind(hist_data, wy_data)


## output dimensions
## creating a chart with many ovelrapping lines
## need the class to be the key to bind in browser

svg_w <- 200
svg_h <- 100

# drawing svg paths for each line

build_path_from_coords <- function(coords) {
  # Build path
  first_pt_x <- head(coords$x, 1)
  first_pt_y <- head(coords$y, 1)
  d <- sprintf("M%s %s %s", first_pt_x, head(coords$y, 1),
               paste0("L", c(tail(coords$x, -1), first_pt_x), " ", 
                      c(tail(coords$y, -1), first_pt_y), collapse = " "))
  return(d)
}

convert_coords_to_svg <- function(obj=half_info%>%select(x,y), svg_width=svg_w) {
  coords <- obj
  x_dec <- coords[,'x']
  y_dec <- coords[,'y']
  
  x_extent <- c(1981, 2021)
  y_extent <- c(0, 100)
  
  # Convert longitude and latitude to SVG horizontal and vertical positions
  # Remember that SVG vertical position has 0 on top
  x_extent_pixels <- x_extent - 1981
  y_extent_pixels <- y_extent - 0
  x_pixels <- x_dec - 1981 # Make it so that the minimum longitude = 0 pixels
  y_pixels <- y_dec - 0 # Make it so that the maximum latitude = 0
  
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

## create dataframe with svg d paths
df_out <- NULL
for  (i in unique(half_info$site_id)){
  half_site <- half_info %>%filter(site_id == i)
  half_site$x <- half_site$water_year
  
  # peak swe
  half_site$y <- half_site$peak_swe
  peak<-convert_coords_to_svg(obj=half_site%>%select(x,y), svg_width=svg_w) %>%
    build_path_from_coords()
  
  # swe date
  half_site$y <- half_site$sm50_day
  sm50<-convert_coords_to_svg(obj=half_site%>%select(x,y), svg_width=svg_w) %>%
    build_path_from_coords()
  
  df_out <- rbind(df_out, data.frame(id = sprintf("sntl_%s", i), d_peak = peak, d_sm50 = sm50))
  
}

# add sites to svg
svg_root <- init_svg(viewbox_dims = c(0, 0, svg_width=svg_w, svg_height=svg_h))

for (i in unique(half_info$site_id)){
  df_site <- df_out %>%filter(id == sprintf("sntl_%s", i))
  xml_add_child(svg_root, "path",class = sprintf('sntl_%s', i), d = df_site$d_peak)
}

xml2::write_xml(svg_root, file = 'C:/Users/cnell/Documents/Projects/snow-to-flow/data_processing_pipeline/6_visualize/sntl_trend.svg')

# export d paths ----------------------------------------------------------

## bind d paths to diff data and save
conus <- read.csv("C:/Users/cnell/Documents/Projects/snow-to-flow/public/data/conus_por_2021.csv")
conus_coords <- conus%>%
  transform(site_id=sprintf("sntl_%s", as.character(site_id)))%>%
  left_join(df_out, by=c('site_id' = 'id'))%>%
  mutate(d_peak = gsub(" Z", "", d_peak))
write.csv(conus_coords, "C:/Users/cnell/Documents/Projects/snow-to-flow/public/data/conus_coord.csv", row.names=FALSE)

ak <- read.csv("C:/Users/cnell/Documents/Projects/snow-to-flow/public/data/ak_por_2021.csv")

ak_coords <- ak%>%
  transform(site_id=sprintf("sntl_%s", as.character(site_id)))%>%
  left_join(df_out, by=c('site_id' = 'id'))%>%
  mutate(d_peak = gsub(" Z", "", d_peak))

write.csv(ak_coords, "C:/Users/cnell/Documents/Projects/snow-to-flow/public/data/ak_coord.csv", row.names=FALSE)

