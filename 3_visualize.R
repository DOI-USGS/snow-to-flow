source("3_visualize/src/export_web_data.R")

p3_targets <- list(

  # Every site on the map
  tar_target(
    p3_sites_csv,
    format_sites(p2_sntl_sites) |>
      write_web_csv("public/data/snotel_sites.csv"),
    format = "file"
  ),

  # Annual values behind the peak SWE and SM50 trend charts
  tar_target(
    p3_annual_csv,
    format_annual(p2_sntl_annual_stats, p2_sntl_sites) |>
      write_web_csv("public/data/snotel_annual.csv"),
    format = "file"
  ),

  # Daily SWE behind the current water year chart
  tar_target(
    p3_swe_daily_csv,
    format_daily_swe(p2_sntl_swe, p2_sntl_sites, focal_wy = p0_water_year) |>
      write_web_csv("public/data/snotel_swe_daily.csv"),
    format = "file"
  ),

  # Settings the site's text and charts depend on
  tar_target(
    p3_run_info_csv,
    format_run_info(
      water_year = p0_water_year,
      percentile_date = p0_percentile_date,
      data_end_date = p0_data_end_date,
      record_start_wy = p0_record_start_wy,
      baseline_wys = p0_baseline_wys,
      baseline_min_years = p0_baseline_min_years,
      chart_min_years = p0_chart_min_years
    ) |>
      write_web_csv("public/data/snotel_run_info.csv"),
    format = "file"
  ),

  # State boundaries for the basemap
  tar_target(
    p3_states_sf,
    prep_states(p1_states_shp, keep = 0.2)
  ),
  tar_target(
    p3_states_geojson,
    write_web_geojson(p3_states_sf, "public/data/snotel_states.geojson"),
    format = "file"
  )

)
