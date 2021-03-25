
# preliminaries -----------------------------------------------------------

library(tidyverse);library(sf);library(maps);library(rmapshaper)
library(xml2)

# svg utility functions ---------------------------------------------------

init_svg <- function(viewbox_dims) {
  # create the main "parent" svg node. This is the top-level part of the svg
  svg_root <- xml_new_root('svg', viewBox = paste(viewbox_dims, collapse=" "), 
                           preserveAspectRatio="xMidYMid meet", 
                           xmlns="http://www.w3.org/2000/svg", 
                           `xmlns:xlink`="http://www.w3.org/1999/xlink", 
                           version="1.1")
  return(svg_root)
}

build_svg_map <- function(svg_fp, svg_height, svg_width, proj_str, state_ext, sntl_fp) {
  
  ##### Create whole SVG #####
  svg_root <- init_svg(viewbox_dims = c(0, 0, svg_width, svg_height))
  
  ##### Add the SVG nodes #####svg, svg_width, proj_str, state_ext, outline, state_path
  get_census_boundaries(mainDir= '1_fetch/out/', subDir= 'cb_2018_us_state_5m')
  states_map <- get_map_extent(proj_str, state_ext, state_path= 'cb_2018_us_state_5m')
  
  add_background_map(svg_root, svg_width, proj_str, state_ext, outline=FALSE, states_map)
  add_background_map(svg_root, svg_width, proj_str, state_ext, outline=TRUE, states_map)
  #add_shapes(svg_root, svg_width, shape_in = 'data/wbd_west.shp')
  add_pts(svg_root, svg_width, bbox=states_map, sntl_fp, proj_str)
  
  ##### Write out final SVG to file #####
  xml2::write_xml(svg_root, svg_root, file = svg_fp)
  
}

add_pts <- function(svg=svg_root, svg_width, bbox, sntl_fp, proj_str){
  
  site_data <- sntl_fp %>% st_transform(proj_str) 
  
  add_grp <- xml_add_child(svg, 'g', id = "sites")
  
  purrr::map(site_data$site_id, function(ID_in, site_data, svg_width) {
    d <- site_data %>%
      filter(site_id == ID_in)%>%
      convert_coords_to_svg(view_bbox = st_bbox(bbox), svg_width)
    
    d$x <- round(d$x, 2)
    d$y <- round(d$y, 2)
    
    xml_add_child(add_grp, 'circle', class="SNTL", 
                  id = sprintf('sntl_%s', ID_in), 
                  r=6, cx=d[,1], cy=d[,2])
    
  }, site_data, svg_width)
}

get_census_boundaries <- function(mainDir= '1_fetch/out/', subDir= 'cb_2018_us_state_5m'){
  # download shapefile zip
  download.file(url = sprintf("https://www2.census.gov/geo/tiger/GENZ2018/shp/%s.zip", subDir), 
              destfile= sprintf('1_fetch/out/%s.zip', subDir))
  # check to see if subdirectory already exists, if not make one
  ifelse(!dir.exists(file.path(mainDir, subDir)), dir.create(file.path(mainDir, subDir)), FALSE)
  #unzip file there
  unzip(sprintf('1_fetch/out/%s.zip', subDir), exdir=sprintf('1_fetch/out/%s', subDir))

}

get_map_extent <- function(proj_str, state_ext, state_path){
  ## get map of states
  state_shp <- sprintf('1_fetch/out/%s/%s.shp', state_path, state_path)
  map_in <- st_read(state_shp)
  states <- unique(map_in$NAME)
  
  ## areas spatially separated from CONUS
  state_no <- c('Alaska','Guam','Hawaii','Puerto Rico','American Samoa', 'Commonwealth of the Northern Mariana Islands', "United States Virgin Islands")
  if (state_ext == 'all') {
    state_list <- setdiff(states, state_no)
  } else if (state_ext == 'west') {
    ## western states
    state_list <- c('Arizona','California','Colorado','Idaho','Montana','New Mexico','Nevada','Oregon','Utah','Washington','Wyoming')
  } else if (!(state_ext %in% c('all','west'))) {
    state_list <- state_ext
  }
  
  states_map <- map_in %>%
    filter(NAME %in% state_list) %>%
    sf::st_as_sf()%>%
    st_transform(proj_str)
  return(states_map)
  
}

#state_ext is either 'all' ,'west', or a list of states
generate_usa_map_data <- function(outline_states, states_map) {

  ## outline_states is logical, whether or not want the state outlines or the aggregate border around the selected states
  if (outline_states == TRUE) {
    states_sf <- states_map %>%
      group_by() %>%
      summarize() %>%
      st_buffer(0) %>%
      mutate(STUSPS = 'USA')
  } else {
    states_sf <- states_map %>% 
      st_buffer(0) 
  }
  
  return(states_sf)
}

add_background_map <- function(svg, svg_width, proj_str, state_ext, outline, states_map) {
  map_data <- generate_usa_map_data(outline_states = outline, states_map)%>% 
    st_cast('MULTIPOLYGON')%>%
    st_cast(to='POLYGON', do_split=TRUE)%>%
    mutate(poly_id = paste0(STUSPS, '-', rownames(.)))
  
  if (outline == FALSE){
    map_class <- 'state'
  } else if (outline == TRUE) {
    map_class <- 'usa'
  }
  
  bkgrd_grp <- xml_add_child(svg, 'g', id = sprintf('map-%s',map_class))
  purrr::map(map_data$poly_id, function(polygon_id, map_data, svg_width) {
    d <- map_data %>%
      filter(poly_id == polygon_id) %>% 
      convert_coords_to_svg(view_bbox = st_bbox(map_data), svg_width) %>% 
      build_path_from_coords()
    xml_add_child(bkgrd_grp, 'path', d = d, class=map_class, id=polygon_id)
  }, map_data, svg_width)
  
}

build_path_from_coords <- function(coords) {
  # Build path
  first_pt_x <- head(coords$x, 1)
  first_pt_y <- head(coords$y, 1)
  d <- sprintf("M%s %s %s Z", first_pt_x, head(coords$y, 1),
               paste0("L", c(tail(coords$x, -1), first_pt_x), " ", 
                      c(tail(coords$y, -1), first_pt_y), collapse = " "))
  return(d)
}

convert_coords_to_svg <- function(sf_obj, svg_width, view_bbox = NULL) {

  coords <- st_coordinates(sf_obj)
  x_dec <- coords[,1]
  y_dec <- coords[,2]
  
  # Using the whole view, figure out coordinates
  # If view_bbox isn't provided, assume sf_obj is the whole view
  if(is.null(view_bbox)) view_bbox <- st_bbox(sf_obj)
  
  x_extent <- c(view_bbox$xmin, view_bbox$xmax)
  y_extent <- c(view_bbox$ymin, view_bbox$ymax)
  
  # Calculate aspect ratio
  aspect_ratio <- diff(x_extent)/diff(y_extent)
  
  # Figure out what the svg_height is based on svg_width, maintaining the aspect ratio
  svg_height <- svg_width / aspect_ratio
  
  # Convert longitude and latitude to SVG horizontal and vertical positions
  # Remember that SVG vertical position has 0 on top
  x_extent_pixels <- x_extent - view_bbox$xmin
  y_extent_pixels <- y_extent - view_bbox$ymin
  x_pixels <- x_dec - view_bbox$xmin # Make it so that the minimum longitude = 0 pixels
  y_pixels <- y_dec - view_bbox$ymin # Make it so that the maximum latitude = 0
  
  data.frame(
    x = round(approx(x_extent_pixels, c(0, svg_width), x_pixels)$y, 6),
    y = round(approx(y_extent_pixels, c(svg_height, 0), y_pixels)$y, 6)
  )
}


# generate svg maps --------------------------------------------------------

## add positioning coordinates to data t draw with D3
wy_stats <- read.csv('2_process/out/SNOTEL_stats_2021.csv')

## SNOTEL sites
sntl_sf <- wy_stats %>% st_as_sf(coords=c('longitude','latitude'), crs=4326) 

### make the CONUS svg
# define scale
conus_height <- 600
conus_width <- 900

proj_conus <- "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"

build_svg_map(svg_fp = '6_visualize/out/conus_sites.svg', 
              svg_width = conus_width, svg_height = conus_height, 
              proj_str = proj_conus, state_ext = 'all',
              sntl_fp = sntl_sf)

## make Alaska basemap

# define scale
ak_height <- 600*.79 # adjusted to draw on same pixel-distance scale
ak_width <- 900*0.67

proj_ak <- '+proj=aea +lat_1=55 +lat_2=65 +lat_0=50 +lon_0=-154 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs '

build_svg_map(svg_fp = '6_visualize/out/ak_sites.svg', 
              svg_width=conus_width, svg_height=conus_height, 
              proj_str = proj_ak, state_ext = 'Alaska',
              sntl_fp = sntl_sf)

# export site coordinates scaled to svg -----------------------------------

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

sntl_conus <- sntl_sf %>%
  st_transform(proj_conus) %>% 
  st_intersection(usa)

xy_conus <- sntl_conus %>%
  convert_coords_to_svg(view_bbox = st_bbox(usa), svg_width) %>%
  mutate(site_id = sntl_conus$site_id,
         x=round(x, 2), y=round(y, 2))

sntl_ak <- sntl_sf %>%
  st_transform(proj_ak) %>% 
  st_intersection(alaska)

xy_ak <- sntl_ak %>%
  convert_coords_to_svg(view_bbox = st_bbox(alaska), ak_width) %>%
  mutate(site_id = sntl_ak$site_id,
         x=round(x, 2), y=round(y, 2))# 

sntl_sites <- rbind(xy_conus, xy_ak) %>% distinct()
glimpse(sntl_sites) # 835 sites

xy_conus %>% write.csv('6_visualize/out/conus_sites.csv', row.names=FALSE)
xy_ak %>% write.csv('6_visualize/out/ak_sites.csv', row.names=FALSE)

