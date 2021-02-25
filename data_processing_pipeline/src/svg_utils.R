
# preliminaries -----------------------------------------------------------


library(tidyverse);library(sf);library(maps);library(rmapshaper)
library(xml2);


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

build_svg_map <- function(svg_fp, svg_height, svg_width) {
  
  ##### Create whole SVG #####
  svg_root <- init_svg(viewbox_dims = c(0, 0, svg_width, svg_height))
  
  ##### Add the SVG nodes #####
  get_census_boundaries()
  add_background_map(svg_root, svg_width, outline=FALSE)
  add_background_map(svg_root, svg_width, outline=TRUE)
  #add_shapes(svg_root, svg_width, shape_in = 'data/wbd_west.shp')
  add_pts(svg_root, svg_width, bbox=states_sf, shape_in = 'data/SNOTEL_sites.shp')
  
  ##### Write out final SVG to file #####
  xml2::write_xml(svg_root, svg_root, file = svg_fp)
  
}

add_pts <- function(svg=svg_root, svg_width, shape_in, bbox=states_sf, proj=proj_str){
  
  site_data <- st_read(shape_in) %>%st_transform(proj)
  
  add_grp <- xml_add_child(svg, 'g', id = "sites")
  
  purrr::map(site_data$ID, function(ID_in, site_data, svg_width) {
    d <- site_data %>%
      filter(ID == ID_in)%>%
      convert_coords_to_svg(view_bbox = st_bbox(bbox), svg_width)
    
    d$x <- round(d$x, 2)
    d$y <- round(d$y, 2)
    
    xml_add_child(add_grp, 'circle', class="SNTL", 
                  id = sprintf('sntl_%s', ID_in), 
                  r=6, cx=d[,1], cy=d[,2])
    
  }, site_data, svg_width)
  
}

get_census_boundaries <- function(mainDir= '1_fetch/out/', subDir= 'cb_2018_us_state_5m'){
  download.file(url = sprintf("https://www2.census.gov/geo/tiger/GENZ2018/shp/%s.zip", subDir), 
              destfile= sprintf('1_fetch/out/%s.zip', subDir))
ifelse(!dir.exists(file.path(mainDir, subDir)), dir.create(file.path(mainDir, subDir)), FALSE)
unzip(sprintf('1_fetch/out/%s.zip', subDir), exdir=sprintf('1_fetch/out/%s', subDir))

}

generate_usa_map_data <- function(proj_str = NULL, state_ext = "all",
                                  outline_states) {
  if(is.null(proj_str)) {
    # Albers Equal Area
    proj_str <- "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"
  }
  
  ## get map of states
  map_in <- maps::map("state", fill=TRUE, plot=FALSE) %>%
    st_as_sf() %>%
    st_transform(proj_str) %>%
    ms_simplify(keep=0.2) %>%
    st_buffer(0) ## fix CO corner
  
  state_list <- unique(map_in$ID)
  
  ## western states
  state_list <- c('Arizona','California','Colorado','Idaho','Montana','New Mexico','Nevada','Oregon','Utah','Washington','Wyoming')
  ## areas spatially separated from CONUS
  state_no <- c('Alaska','Guam','Hawaii','Puerto Rico','American Samoa', 'Commonwealth of the Northern Mariana Islands', "United States Virgin Islands")
  if (state_ext == 'all') {
    state_list <- 
  }
  
  if (outline_states == TRUE) {
    states_sf <- st_read(state_path) %>%
      filter(NAME %in% state_list) %>%
      sf::st_as_sf() %>% 
      group_by() %>%
      summarize() %>%
      st_transform(proj_str) %>% 
      st_buffer(0) %>%
      mutate(STUSPS = 'USA')
  } else {
    states_sf <- st_read(state_path) %>%
      filter(NAME %in% state_list) %>%
      sf::st_as_sf() %>% 
      st_transform(proj_str) %>% 
      st_buffer(0) 
  }
  
  return(states_sf)
}

add_background_map <- function(svg, svg_width, outline) {
  map_data <- generate_usa_map_data(outline_states = outline)%>% 
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


add_shapes <- function(svg=svg_root, svg_width, imp_in ){
  
  imp_data <- st_read(imp_in)%>% 
    st_cast(to='POLYGON', do_split=TRUE)%>%
    mutate(poly_id = rownames(.)) %>%
    st_buffer(0) 
  
  imp_grp <- xml_add_child(svg, 'g', id = "IMP")
  
  purrr::map(imp_data$poly_id, function(polygon_id, imp_data, svg_width) {
    d <- imp_data %>%
      filter(poly_id == polygon_id) %>% 
      convert_coords_to_svg(view_bbox = st_bbox(imp_data), svg_width) %>% 
      build_path_from_coords()
    xml_add_child(imp_grp, 'path', d = d, class='IMP-50')
  }, imp_data, svg_width)
  
  
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
  #sf_obj <- sf_obj%>%st_cast('MULTIPOLYGON')
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


# generate svg map --------------------------------------------------------


### make the svg
svg_height <- 1000
svg_width <- 700

proj_str <- "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"

svg_root <- init_svg(viewbox_dims = c(0, 0, svg_width, svg_height))
svg_root

build_svg_map(svg_fp = 'out/sntl_sites.svg', svg_width=700, svg_height=1000)
