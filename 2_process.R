source("2_process/src/process_sntl.R")

p2_targets <- list(

  # Daily SWE for all fetched sites, with water year and water day
  tar_target(
    p2_sntl_swe,
    read_sntl_swe(p1_sntl_swe_csv)
  ),

  # Complete water years of record before the focal year, for the chart rule
  tar_target(
    p2_sntl_record_years,
    count_record_years(p2_sntl_swe, before_wy = p0_water_year,
                       complete_fraction = p0_complete_wy_fraction)
  ),

  # Peak SWE, SM50, and April 1st SWE for every site and water year
  tar_target(
    p2_sntl_annual_stats,
    calc_annual_stats(p2_sntl_swe, focal_wy = p0_water_year,
                      data_end_date = p0_data_end_date)
  ),

  # SWE percentile on the percentile date against each site's period of
  # record, as the NRCS interactive map calculates it
  tar_target(
    p2_sntl_percentiles,
    calc_swe_percentile(p2_sntl_swe, stations = p1_sntl_stations,
                        percentile_date = p0_percentile_date,
                        min_share = p0_percentile_min_share)
  ),

  # Each site's normal peak SWE and SM50, for comparing the focal year
  tar_target(
    p2_sntl_normals,
    calc_site_normals(p2_sntl_annual_stats, wys = p0_normal_wys,
                      min_years = p0_normal_min_years)
  ),

  # SWE percentile bands through the water year, for the site charts
  tar_target(
    p2_sntl_daily_bands,
    calc_daily_bands(p2_sntl_swe,
                     site_ids = p2_sntl_sites$site_id[p2_sntl_sites$has_charts],
                     focal_wy = p0_water_year, step = 5,
                     min_years = p0_chart_min_years)
  ),

  # Every site on the map: stations active on the percentile date, with
  # their focal year values and whether they get mini charts
  tar_target(
    p2_sntl_sites,
    build_site_table(
      stations = p1_sntl_stations,
      swe = p2_sntl_swe,
      annual_stats = p2_sntl_annual_stats,
      percentiles = p2_sntl_percentiles,
      record_years = p2_sntl_record_years,
      normals = p2_sntl_normals,
      focal_wy = p0_water_year,
      percentile_date = p0_percentile_date,
      data_end_date = p0_data_end_date,
      chart_min_years = p0_chart_min_years
    )
  )

)
