# Pipeline settings. These reproduce the 2021 version of the site; update them
# to build a new year.

p0_targets <- list(

  # Water year shown on the site
  tar_target(p0_water_year, 2021),

  # Date the site's snapshot is taken: current-year data are pulled through
  # this date, the SWE percentile is calculated for this day of the year, and
  # peak SWE / SM50 not yet reached by this date are marked TBD
  tar_target(p0_reference_date, as.Date("2021-04-26")),

  # First water year of the record used for the peak SWE and SM50 trends
  tar_target(p0_record_start_wy, 1981),

  # Baseline water years the percentile is calculated against, and the
  # minimum number of those years a site needs to be given a percentile
  tar_target(p0_baseline_wys, 1981:2010),
  tar_target(p0_baseline_min_years, 20),

  # Date for re-fetching data. Change this to re-pull from NRCS
  tar_target(p0_fetch_date, "2026-09-23")

)
