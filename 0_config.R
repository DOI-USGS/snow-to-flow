# Pipeline settings for the snapshot shown on the site. Update these to build a
# new year or a different date.

p0_targets <- list(

  # Water year shown on the site
  tar_target(p0_water_year, 2026),

  # Date the SWE percentile is calculated for (the map shows April 1st SWE as
  # a percentile of that date in each site's period of record)
  tar_target(p0_percentile_date, as.Date("2026-04-01")),

  # Last day of data: current-year data are pulled through this date, and
  # peak SWE / SM50 not yet reached by then are marked TBD. This can be later
  # than the percentile date, so the peak SWE and SM50 charts cover the whole
  # season while the map shows conditions on the percentile date.
  tar_target(p0_data_end_date, as.Date("2026-09-23")),

  # First water year shown in the peak SWE and SM50 trend charts
  tar_target(p0_record_start_wy, 1981),

  # Percentiles follow the NRCS interactive map: a site needs values in at
  # least this share of its period of record's years to get a percentile
  tar_target(p0_percentile_min_share, 2/3),

  # Water years for each site's normal peak SWE and SM50 (the NRCS normals
  # period), and the fewest of those years a site needs for a normal
  tar_target(p0_normal_wys, 1991:2020),
  tar_target(p0_normal_min_years, 20),

  # Sites get mini charts if they have at least this many complete water years
  # of record before the focal year, where a complete year has SWE on at
  # least this fraction of its days
  tar_target(p0_chart_min_years, 10),
  tar_target(p0_complete_wy_fraction, 0.9),

  # Date for re-fetching data. Change this to re-pull from NRCS
  tar_target(p0_fetch_date, "2026-09-24")

)
