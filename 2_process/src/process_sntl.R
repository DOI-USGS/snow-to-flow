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

#' Percentile of each site's SWE on each of a set of dates, as the NRCS
#' interactive map calculates it
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
#' @param dates Date, the dates to rank, all in one water year
#' @param min_share num, share of the period of record's years needed
#' @return data frame of site_id, date, wy_n (years with a value), ptile_swe
calc_swe_percentiles <- function(swe, stations, dates, min_share) {
  focal_wy <- year(dates[1]) + if_else(month(dates[1]) >= 10, 1, 0)
  days <- tibble(date = dates, md = format(dates, "%m-%d"))

  same_day <- swe |>
    filter(!is.na(swe), water_year <= focal_wy) |>
    mutate(md = format(date, "%m-%d")) |>
    filter(md %in% days$md)

  current <- same_day |>
    filter(water_year == focal_wy) |>
    select(site_id, md, current = swe)

  same_day |>
    inner_join(current, by = c("site_id", "md")) |>
    group_by(site_id, md) |>
    summarize(
      current = first(current),
      wy_n = n(),
      m = 1L + sum(swe > first(current)),
      share_positive = mean(swe > 0),
      .groups = "drop"
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
    inner_join(days, by = "md") |>
    select(site_id, date, wy_n, ptile_swe)
}

#' Each site's normal peak SWE, peak day, and SM50 day: medians over the
#' normals water years
#'
#' @param annual_stats data frame from `calc_annual_stats()`
#' @param wys int, normals water years
#' @param min_years int, fewest years with a value needed for a normal
calc_site_normals <- function(annual_stats, wys, min_years) {
  normal <- function(x) if (sum(!is.na(x)) >= min_years) median(x, na.rm = TRUE) else NA_real_
  annual_stats |>
    filter(water_year %in% wys) |>
    group_by(site_id) |>
    summarize(
      normal_peak_swe = normal(peak_swe),
      normal_peak_day = normal(peak_day),
      normal_sm50_day = normal(sm50_day)
    )
}

#' SWE percentile bands for each day of the water year, for each site's chart
#'
#' Quantiles of SWE on each water day across the site's earlier water years
#' (quantile type 7, which ranks as the NRCS percentile does), at the map's
#' percentile breaks plus the minimum and maximum.
#'
#' @param swe data frame from `read_sntl_swe()`
#' @param site_ids int, sites to calculate bands for
#' @param focal_wy int, the water year shown; only earlier years are used
#' @param step int, calculate every `step` days of the water year
#' @param min_years int, fewest years with a value needed on a day
calc_daily_bands <- function(swe, site_ids, focal_wy, step, min_years) {
  swe |>
    filter(site_id %in% site_ids, water_year < focal_wy, !is.na(swe),
           (water_day - 1) %% step == 0) |>
    group_by(site_id, water_day) |>
    filter(n() >= min_years) |>
    summarize(
      min = min(swe),
      p10 = quantile(swe, 0.1),
      p30 = quantile(swe, 0.3),
      p50 = quantile(swe, 0.5),
      p70 = quantile(swe, 0.7),
      p90 = quantile(swe, 0.9),
      max = max(swe),
      .groups = "drop"
    )
}

#' One row per map site: metadata, focal year values, and display flags
#'
#' @param stations data frame of station metadata
#' @param swe data frame from `read_sntl_swe()`
#' @param annual_stats data frame from `calc_annual_stats()`
#' @param percentiles data frame from `calc_swe_percentile()`
#' @param record_years data frame from `count_record_years()`
#' @param normals data frame from `calc_site_normals()`
#' @param focal_wy int, the water year shown on the site
#' @param percentile_date Date, the date the map shows; its active stations
#'   are the map sites
#' @param data_end_date Date, last day of data
#' @param chart_min_years int, complete years of record needed for charts
build_site_table <- function(stations, swe, annual_stats, percentiles,
                             record_years, normals, focal_wy, percentile_date,
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
    left_join(normals, by = "site_id") |>
    left_join(focal_days, by = "site_id") |>
    mutate(
      record_years = replace_na(record_years, 0L),
      has_charts = record_years >= chart_min_years & replace_na(focal_days, 0L) > 0
    ) |>
    select(-focal_days) |>
    arrange(site_id)
}
