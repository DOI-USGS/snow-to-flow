source("3_visualize/src/export_web_data.R")
source("3_visualize/src/build_map_layers.R")

# Map panels: CONUS and Alaska, each in its own Albers projection (the ones the
# 2021 map used), drawn at the same scale
p3_map_panels <- tibble::tibble(
  panel = c("conus", "ak"),
  proj = c(
    "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs",
    "+proj=aea +lat_1=55 +lat_2=65 +lat_0=50 +lon_0=-154 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"
  ),
  states = list(
    setdiff(c(state.abb, "DC"), c("AK", "HI")),
    "AK"
  )
)

p3_targets <- list(

  # Map layers for each panel, on one pixel grid per panel
  tar_map(
    values = p3_map_panels,
    names = panel,

    tar_target(p3_panel_states, prep_panel_states(p1_states_shp, states, proj)),
    tar_target(p3_panel_bbox, panel_bbox(p3_panel_states)),
    tar_target(p3_panel_width_px, panel_width_px(p3_panel_bbox, p3_map_m_per_px)),

    tar_target(
      p3_hillshade_png,
      build_hillshade_png(p3_panel_states, p3_panel_bbox, p3_panel_width_px,
                          out_png = sprintf("src/assets/maps/snotel_%s_hillshade.png", panel)),
      format = "file"
    ),
    tar_target(
      p3_states_svg,
      export_sf_layer_svg(p3_panel_states, p3_panel_bbox, p3_panel_width_px,
                          out_svg = sprintf("src/assets/maps/snotel_%s_states.svg", panel),
                          id_column = "state", simplify = "20%",
                          style = c("fill=none", "stroke=#ffffff", "stroke-width=2",
                                    "stroke-opacity=0.5")),
      format = "file"
    ),
    tar_target(
      p3_outline_svg,
      export_sf_layer_svg(st_union(p3_panel_states) |> st_as_sf(), p3_panel_bbox,
                          p3_panel_width_px,
                          out_svg = sprintf("src/assets/maps/snotel_%s_outline.svg", panel),
                          simplify = "20%",
                          style = c("fill=none", "stroke=#808080", "stroke-width=1")),
      format = "file"
    ),
    tar_target(
      p3_site_xy,
      site_panel_xy(filter(p2_sntl_sites, (state == "AK") == (panel == "ak")),
                    panel, proj, p3_panel_bbox, p3_panel_width_px)
    ),
    tar_target(
      p3_panel_info,
      tibble(panel = panel, width_px = p3_panel_width_px,
             height_px = panel_height_px(p3_panel_bbox, p3_panel_width_px))
    )
  ),

  # Map scale shared by both panels: the CONUS panel is 2400 pixels wide
  tar_target(
    p3_map_m_per_px,
    unname(diff(panel_bbox(prep_panel_states(p1_states_shp, p3_map_panels$states[[1]],
                                             p3_map_panels$proj[[1]]))[c("xmin", "xmax")])) / 2400
  ),

  # Panel sizes, for the front end's SVG viewBoxes
  tar_target(
    p3_map_panels_csv,
    bind_rows(p3_panel_info_conus, p3_panel_info_ak) |>
      write_web_csv("public/data/snotel_map_panels.csv"),
    format = "file"
  ),

  # Every site on the map, with its position on its map panel
  tar_target(
    p3_sites_csv,
    format_sites(p2_sntl_sites, bind_rows(p3_site_xy_conus, p3_site_xy_ak)) |>
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
