# Process daily SNOTEL SWE into the site-level values shown on the map

#' Read the fetched daily SWE files and add water year and water day
#'
#' @param swe_csvs chr, paths of the daily SWE csvs
#' @return data frame of site_id, date, swe, water_year, water_day (1 = Oct 1)
read_sntl_swe <- function(swe_csvs) {
  swe_csvs |>
    purrr::map(read_csv, show_col_types = FALSE) |>
    list_rbind() |>
    mutate(
      water_year = year(date) + if_else(month(date) >= 10, 1, 0),
      water_day = as.integer(date - as.Date(sprintf("%s-10-01", water_year - 1))) + 1L
    )
}

#' Count complete water years of record for each site
#'
#' @param swe data frame from `read_sntl_swe()`
#' @param before_wy int, count water years before this one
#' @param complete_fraction num, share of a water year's days that must have SWE
count_record_years <- function(swe, before_wy, complete_fraction) {
  swe |>
    filter(water_year < before_wy) |>
    group_by(site_id, water_year) |>
    summarize(
      n_days = sum(!is.na(swe)),
      year_days = if_else(leap_year(first(water_year)), 366, 365),
      .groups = "drop"
    ) |>
    group_by(site_id) |>
    summarize(record_years = sum(n_days >= complete_fraction * year_days))
}

#' Annual SWE metrics for each site and water year
#'
#' Peak SWE is the water year maximum, dated to the last day it occurs. SM50 is
#' the first day on or after the peak when SWE has fallen to half the peak.
#' April 1st SWE is the value on April 1. In the focal water year, a peak on
#' the last day of data, or an SM50 not yet reached, is marked "TBD"; an
#' unreached SM50 takes the last day of data as its date, as in the 2021 site.
#'
#' @param swe data frame from `read_sntl_swe()`
#' @param focal_wy int, the water year shown on the site
#' @param data_end_date Date, last day of data
calc_annual_stats <- function(swe, focal_wy, data_end_date) {
  swe <- filter(swe, !is.na(swe))

  peaks <- swe |>
    group_by(site_id, water_year) |>
    filter(swe == max(swe)) |>
    slice_max(water_day, n = 1, with_ties = FALSE) |>
    ungroup() |>
    transmute(site_id, water_year, peak_swe = swe, peak_date = date,
              peak_day = water_day, sm50_swe = swe / 2)

  sm50 <- swe |>
    inner_join(select(peaks, site_id, water_year, peak_day, sm50_swe),
               by = c("site_id", "water_year")) |>
    filter(water_day >= peak_day, swe <= sm50_swe) |>
    group_by(site_id, water_year) |>
    slice_min(water_day, n = 1, with_ties = FALSE) |>
    ungroup() |>
    select(site_id, water_year, sm50_date = date, sm50_day = water_day)

  apr1 <- swe |>
    filter(month(date) == 4, day(date) == 1) |>
    select(site_id, water_year, apr1_swe = swe, apr1_day = water_day)

  last_day <- as.integer(data_end_date - as.Date(sprintf("%s-10-01", focal_wy - 1))) + 1L

  peaks |>
    left_join(sm50, by = c("site_id", "water_year")) |>
    left_join(apr1, by = c("site_id", "water_year")) |>
    mutate(
      focal = water_year == focal_wy,
      sm50_date = if_else(focal & is.na(sm50_date), data_end_date, sm50_date),
      sm50_day = if_else(focal & is.na(sm50_day), last_day, sm50_day),
      peak_met = if_else(focal & peak_date == data_end_date, "TBD", format(peak_date)),
      sm50_met = if_else(focal & sm50_date == data_end_date, "TBD", format(sm50_date))
    ) |>
    select(-focal)
}

#' Percentile of each site's SWE on a date, as the NRCS interactive map
#' calculates it
#'
#' The reference is the site's period of record for that day of the year,
#' including the current year. Percentile = 1 - (m - 1) / (n - 1), where m is
#' the rank of the current value with rank 1 the maximum (ties take the top
#' rank) and n the number of years with a value, so the record low is 0 and
#' the record high 1. A percentile is given only when n is at least
#' `min_share` of the years in the period of record, and it passes the NRCS
#' data variability rule: at least 10% of the values must be above zero, or
#' 80% if the current value is zero. See the NRCS iMap glossary:
#' https://www.nrcs.usda.gov/sites/default/files/2023-03/iMap_Glossary.pdf
#'
#' @param swe data frame from `read_sntl_swe()`
#' @param stations data frame of station metadata, for record start dates
#' @param percentile_date Date, the date to rank
#' @param min_share num, share of the period of record's years needed
#' @return data frame of site_id, wy_n (years with a value), ptile_swe
calc_swe_percentile <- function(swe, stations, percentile_date, min_share) {
  focal_wy <- year(percentile_date) + if_else(month(percentile_date) >= 10, 1, 0)

  same_day <- swe |>
    filter(!is.na(swe), water_year <= focal_wy,
           month(date) == month(percentile_date),
           day(date) == day(percentile_date))

  current <- filter(same_day, date == percentile_date) |> select(site_id, current = swe)

  same_day |>
    inner_join(current, by = "site_id") |>
    group_by(site_id) |>
    summarize(
      current = first(current),
      wy_n = n(),
      m = 1L + sum(swe > first(current)),
      share_positive = mean(swe > 0)
    ) |>
    left_join(select(stations, site_id, swe_begin), by = "site_id") |>
    mutate(
      por_start_wy = year(swe_begin) + if_else(month(swe_begin) >= 10, 1, 0),
      por_years = focal_wy - por_start_wy + 1,
      enough_years = wy_n >= min_share * por_years,
      variable = if_else(current > 0, share_positive >= 0.1, share_positive >= 0.8),
      ptile_swe = if_else(enough_years & variable & wy_n > 1,
                          1 - (m - 1) / (wy_n - 1), NA_real_)
    ) |>
    select(site_id, wy_n, ptile_swe)
}

#' One row per map site: metadata, focal year values, and display flags
#'
#' @param stations data frame of station metadata
#' @param swe data frame from `read_sntl_swe()`
#' @param annual_stats data frame from `calc_annual_stats()`
#' @param percentiles data frame from `calc_swe_percentile()`
#' @param record_years data frame from `count_record_years()`
#' @param focal_wy int, the water year shown on the site
#' @param percentile_date Date, the date the map shows; its active stations
#'   are the map sites
#' @param data_end_date Date, last day of data
#' @param chart_min_years int, complete years of record needed for charts
build_site_table <- function(stations, swe, annual_stats, percentiles,
                             record_years, focal_wy, percentile_date,
                             data_end_date, chart_min_years) {
  focal_days <- swe |>
    filter(water_year == focal_wy) |>
    group_by(site_id) |>
    summarize(focal_days = sum(!is.na(swe)))

  stations |>
    filter(station_begin <= percentile_date, station_end >= percentile_date) |>
    select(site_id, station_triplet, state, site_name, elev_ft, latitude, longitude) |>
    left_join(filter(swe, date == percentile_date) |> select(site_id, swe), by = "site_id") |>
    left_join(filter(annual_stats, water_year == focal_wy) |> select(-water_year), by = "site_id") |>
    left_join(percentiles, by = "site_id") |>
    left_join(record_years, by = "site_id") |>
    left_join(focal_days, by = "site_id") |>
    mutate(
      record_years = replace_na(record_years, 0L),
      has_charts = record_years >= chart_min_years & replace_na(focal_days, 0L) > 0
    ) |>
    select(-focal_days) |>
    arrange(site_id)
}
