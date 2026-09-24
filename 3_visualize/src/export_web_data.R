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
      state,
      state_name = c(state.name, "District of Columbia")[match(state, c(state.abb, "DC"))],
      site_name, elev_ft,
      latitude = round(latitude, 5),
      longitude = round(longitude, 5),
      panel, x, y,
      swe,
      ptile_swe = round(ptile_swe, 4),
      wy_n,
      peak_swe, peak_date, peak_day, peak_met,
      sm50_swe, sm50_date, sm50_day, sm50_met,
      apr1_swe,
      normal_peak_swe = round(normal_peak_swe, 1),
      normal_peak_day = round(normal_peak_day),
      normal_sm50_day = round(normal_sm50_day),
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
