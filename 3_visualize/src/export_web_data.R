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

#' Annual peak SWE and SM50 day for the chart sites, for the trend charts,
#' with each year's change from the site's 1991-2020 normal
#'
#' `peak_swe_pct` is peak SWE as a percent of the site's normal peak SWE, and
#' `sm50_diff` the melt date (SM50) in days after the site's normal SM50
#' (negative when earlier). Both are missing for sites without a normal.
#'
#' @param annual_stats data frame from `calc_annual_stats()`
#' @param sites data frame from `build_site_table()`, with the normals from
#'   `calc_site_normals()`
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
    left_join(select(sites, site_id, normal_peak_swe, normal_sm50_day), by = "site_id") |>
    mutate(
      peak_swe_pct = if_else(normal_peak_swe > 0, round(100 * peak_swe / normal_peak_swe), NA_real_),
      sm50_diff = round(sm50_day - normal_sm50_day)
    ) |>
    select(site_id, water_year, peak_swe, peak_day, sm50_day, apr1_swe,
           peak_swe_pct, sm50_diff) |>
    arrange(site_id, water_year)
}

#' Write one JSON file per map site for the site panel: SWE percentile bands
#' through the water year (empty for sites without charts), and the focal
#' year's daily SWE
#'
#' Each file holds `band_days` (water days of the bands), `bands` (one row per
#' band day of min, p10, p30, p50, p70, p90, max), and `swe` (the focal year's
#' SWE by water day from 1, null where missing).
#'
#' @param bands data frame from `calc_daily_bands()`
#' @param swe data frame from `read_sntl_swe()`
#' @param sites data frame from `build_site_table()`
#' @param focal_wy int, the water year shown on the site
#' @param out_dir chr, folder to write into; files already there are removed
#' @return chr, paths of the files written
write_site_chart_json <- function(bands, swe, sites, focal_wy, out_dir) {
  unlink(out_dir, recursive = TRUE)
  dir.create(out_dir, recursive = TRUE)

  focal <- swe |>
    filter(water_year == focal_wy, site_id %in% sites$site_id)

  sites$site_id |>
    purrr::map_chr(function(id) {
      site_bands <- filter(bands, site_id == id) |> arrange(water_day)
      site_swe <- filter(focal, site_id == id)
      daily <- rep(NA_real_, max(c(site_swe$water_day, 1L)))
      daily[site_swe$water_day] <- site_swe$swe
      file_out <- file.path(out_dir, paste0(id, ".json"))
      jsonlite::write_json(
        list(
          band_days = site_bands$water_day,
          bands = as.matrix(site_bands[, c("min", "p10", "p30", "p50", "p70", "p90", "max")]) |>
            round(1) |> unname(),
          swe = daily
        ),
        file_out, digits = 1, na = "null", auto_unbox = TRUE
      )
      file_out
    })
}

#' Write each map site's SWE percentile for every day of the snow season, as
#' percents to one decimal, for the map's date slider. One decimal keeps every
#' site in the same map class as its unrounded percentile.
#'
#' The file holds `days` (water days of the season) and `percentiles`, keyed by
#' site_id, one value per day (null where a site has no percentile).
#'
#' @param daily_percentiles data frame from `calc_swe_percentiles()`
#' @param sites data frame from `build_site_table()`
#' @param dates Date, the season's days
#' @param file_out chr, path of the JSON file to write
write_daily_percentiles <- function(daily_percentiles, sites, dates, file_out) {
  focal_wy <- year(dates[1]) + if_else(month(dates[1]) >= 10, 1, 0)
  water_days <- as.integer(dates - as.Date(sprintf("%s-10-01", focal_wy - 1))) + 1L

  by_site <- daily_percentiles |>
    filter(site_id %in% sites$site_id) |>
    mutate(pct = round(100 * ptile_swe, 1)) |>
    split(~site_id)

  percentiles <- sites$site_id |>
    purrr::set_names() |>
    purrr::map(function(id) {
      x <- by_site[[as.character(id)]]
      if (is.null(x)) return(rep(NA_integer_, length(dates)))
      x$pct[match(dates, x$date)]
    })

  jsonlite::write_json(list(days = water_days, percentiles = percentiles),
                       file_out, na = "null", auto_unbox = TRUE)
  file_out
}

#' Settings the site's text and charts depend on, as a one-row table
format_run_info <- function(water_year, percentile_date, data_end_date,
                            season_start, season_end, record_start_wy,
                            percentile_min_share, chart_min_years) {
  tibble(
    water_year,
    percentile_date,
    data_end_date,
    season_start,
    season_end = min(season_end, data_end_date),
    record_start_wy,
    percentile_min_share = round(percentile_min_share, 4),
    chart_min_years
  )
}
