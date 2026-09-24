# Pipeline settings. These reproduce the 2021 version of the site; update them
# to build a new year.

p0_targets <- list(

  # Water year shown on the site
  tar_target(p0_water_year, 2021),

  # Date the SWE percentile is calculated for (the map shows April 1st SWE
  # as a percentile of that date in the baseline years)
  tar_target(p0_percentile_date, as.Date("2021-04-01")),

  # Last day of data: current-year data are pulled through this date, and
  # peak SWE / SM50 not yet reached by then are marked TBD
  tar_target(p0_data_end_date, as.Date("2021-04-22")),

  # First water year of the record used for the peak SWE and SM50 trends
  tar_target(p0_record_start_wy, 1981),

  # Baseline water years the percentile is calculated against, and the
  # minimum number of those years a site needs to be given a percentile
  tar_target(p0_baseline_wys, 1981:2010),
  tar_target(p0_baseline_min_years, 20),

  # Date for re-fetching data. Change this to re-pull from NRCS
  tar_target(p0_fetch_date, "2026-09-23")

)
