#' Download and unzip a Census cartographic boundary shapefile
#'
#' @param layer chr, file name without extension, e.g. "cb_2018_us_state_5m"
#' @param out_dir chr, directory to unzip into
#' @param fetch_date chr, date used to force a re-fetch; not otherwise used
#' @return chr, path of the .shp file
fetch_census_shp <- function(layer, out_dir, fetch_date) {
  url <- sprintf("https://www2.census.gov/geo/tiger/GENZ2018/shp/%s.zip", layer)
  zip_file <- tempfile(fileext = ".zip")
  download.file(url, zip_file, mode = "wb", quiet = TRUE)
  unzip(zip_file, exdir = file.path(out_dir, layer))
  unlink(zip_file)
  file.path(out_dir, layer, paste0(layer, ".shp"))
}
