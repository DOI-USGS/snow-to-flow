# Write the data the site reads from public/data

#' Write a data frame to csv and return the path, for `format = "file"`
write_web_csv <- function(data, file_out) {
  write_csv(data, file_out, na = "")
  return(file_out)
}

#' Site table for the map: one row per site
#'
#' @param sites data frame from `build_site_table()`
#' @param site_xy data frame of site_id, panel, x, y from `site_panel_xy()`
format_sites <- function(sites, site_xy) {
  sites |>
    left_join(site_xy, by = "site_id") |>
    transmute(
      site_id,
      sntl_id = paste0("sntl_", site_id),
      state, site_name, elev_ft,
      latitude = round(latitude, 5),
      longitude = round(longitude, 5),
      panel, x, y,
      swe,
      ptile_swe = round(ptile_swe, 4),
      wy_n,
      peak_swe, peak_date, peak_day, peak_met,
      sm50_swe, sm50_date, sm50_day, sm50_met,
      apr1_swe,
      record_years,
      has_charts
    )
}

#' Annual peak SWE and SM50 day for the chart sites, for the trend charts
#'
#' @param annual_stats data frame from `calc_annual_stats()`
#' @param sites data frame from `build_site_table()`
#' @param record_start_wy int, first water year shown in the trend charts
format_annual <- function(annual_stats, sites, record_start_wy) {
  annual_stats |>
    filter(site_id %in% sites$site_id[sites$has_charts],
           water_year >= record_start_wy) |>
    # a peak or SM50 not yet reached (TBD) is not a value for the trend charts
    mutate(
      peak_swe = if_else(peak_met == "TBD", NA_real_, peak_swe),
      peak_day = if_else(peak_met == "TBD", NA_integer_, peak_day),
      sm50_day = if_else(sm50_met == "TBD", NA_integer_, sm50_day)
    ) |>
    select(site_id, water_year, peak_swe, peak_day, sm50_day, apr1_swe) |>
    arrange(site_id, water_year)
}

#' Daily SWE in the focal water year for the chart sites, for the current
#' year chart
#'
#' @param swe data frame from `read_sntl_swe()`
#' @param sites data frame from `build_site_table()`
#' @param focal_wy int, the water year shown on the site
format_daily_swe <- function(swe, sites, focal_wy) {
  swe |>
    filter(water_year == focal_wy, site_id %in% sites$site_id[sites$has_charts],
           !is.na(swe)) |>
    select(site_id, water_day, swe) |>
    arrange(site_id, water_day)
}

#' Settings the site's text and charts depend on, as a one-row table
format_run_info <- function(water_year, percentile_date, data_end_date,
                            record_start_wy, percentile_min_share,
                            chart_min_years) {
  tibble(
    water_year,
    percentile_date,
    data_end_date,
    record_start_wy,
    percentile_min_share = round(percentile_min_share, 4),
    chart_min_years
  )
}

#' State boundaries for the basemap: CONUS states and Alaska, in longitude and
#' latitude (d3 projects them), simplified for the web
#'
#' @param states_shp chr, path of the Census states shapefile
#' @param keep num, share of vertices to keep when simplifying
prep_states <- function(states_shp, keep) {
  st_read(states_shp, quiet = TRUE) |>
    filter(!STUSPS %in% c("HI", "PR", "GU", "AS", "MP", "VI")) |>
    select(state = STUSPS, name = NAME) |>
    st_transform(4326) |>
    rmapshaper::ms_simplify(keep = keep, keep_shapes = TRUE)
}

#' Write an sf object to GeoJSON and return the path, for `format = "file"`
#'
#' @param digits int, decimal places kept in coordinates
write_web_geojson <- function(data, file_out, digits = 4) {
  geojsonsf::sf_geojson(data, digits = digits) |>
    writeLines(file_out)
  return(file_out)
}
