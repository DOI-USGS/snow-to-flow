source("3_visualize/src/export_web_data.R")
source("3_visualize/src/build_map_layers.R")

# Map panels: the western states, and Alaska, each in the Albers projection
# the 2021 map used. `focus` states set each panel's extent (with its sites);
# `states` are drawn, clipped to it. Each panel has its own scale.
p3_map_panels <- tibble::tibble(
  panel = c("west", "ak"),
  proj = c(
    "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs",
    "+proj=aea +lat_1=55 +lat_2=65 +lat_0=50 +lon_0=-154 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"
  ),
  states = list(
    setdiff(c(state.abb, "DC"), c("AK", "HI")),
    "AK"
  ),
  focus = list(
    c("WA", "OR", "CA", "ID", "NV", "MT", "WY", "UT", "CO", "AZ", "NM"),
    "AK"
  ),
  # westernmost longitude shown (-180 shows all of the state)
  lon_min = c(-180, -180),
  width_px = c(2400L, 1200L)
)

p3_targets <- list(

  # Map layers for each panel, on one pixel grid per panel
  tar_map(
    values = p3_map_panels,
    names = panel,

    tar_target(
      p3_panel_sites,
      filter(p2_sntl_sites, (state == "AK") == (panel == "ak"))
    ),
    tar_target(
      p3_panel_bbox,
      panel_extent(p1_states_shp, focus, proj, lon_min, p3_panel_sites)
    ),
    tar_target(p3_panel_states_full, prep_panel_states(p1_states_shp, states, proj)),
    tar_target(p3_panel_states, clip_to_bbox(p3_panel_states_full, p3_panel_bbox)),

    tar_target(
      p3_hillshade_png,
      build_hillshade_png(p3_panel_states, p3_panel_bbox, width_px,
                          out_png = sprintf("src/assets/maps/snotel_%s_hillshade.png", panel)),
      format = "file"
    ),
    tar_target(
      p3_outline_svg,
      # the border is taken as lines before clipping, so the panel edge is not
      # drawn as part of it
      export_sf_layer_svg(st_union(p3_panel_states_full) |> st_boundary() |> st_as_sf() |>
                            clip_to_bbox(p3_panel_bbox),
                          p3_panel_bbox, width_px,
                          out_svg = sprintf("src/assets/maps/snotel_%s_outline.svg", panel),
                          simplify = "20%",
                          style = c("fill=none", "stroke=#808080", "stroke-width=1")),
      format = "file"
    ),
    tar_target(
      p3_site_xy,
      site_panel_xy(p3_panel_sites, panel, proj, p3_panel_bbox, width_px)
    ),
    tar_target(
      p3_panel_info,
      tibble(panel = panel, width_px = width_px,
             height_px = panel_height_px(p3_panel_bbox, width_px))
    )
  ),

  # State lines, for the western panel only (Alaska is drawn by its outline)
  tar_target(
    p3_states_svg_west,
    export_sf_layer_svg(st_boundary(p3_panel_states_full_west) |> clip_to_bbox(p3_panel_bbox_west),
                        p3_panel_bbox_west, 2400L,
                        out_svg = "src/assets/maps/snotel_west_states.svg",
                        id_column = "state", simplify = "20%",
                        style = c("fill=none", "stroke=#9e9e9e", "stroke-width=1")),
    format = "file"
  ),

  # Panel sizes, for the front end's SVG viewBoxes
  tar_target(
    p3_map_panels_csv,
    bind_rows(p3_panel_info_west, p3_panel_info_ak) |>
      write_web_csv("public/data/snotel_map_panels.csv"),
    format = "file"
  ),

  # Every site on the map, with its position on its map panel
  tar_target(
    p3_sites_csv,
    format_sites(p2_sntl_sites, bind_rows(p3_site_xy_west, p3_site_xy_ak)) |>
      write_web_csv("public/data/snotel_sites.csv"),
    format = "file"
  ),

  # Annual values behind the peak SWE and SM50 trend charts
  tar_target(
    p3_annual_csv,
    format_annual(p2_sntl_annual_stats, p2_sntl_sites,
                  record_start_wy = p0_record_start_wy) |>
      write_web_csv("public/data/snotel_annual.csv"),
    format = "file"
  ),

  # Each site's percentile for every day of the snow season, for the slider
  tar_target(
    p3_daily_percentiles_json,
    write_daily_percentiles(p2_sntl_daily_percentiles, p2_sntl_sites,
                            dates = seq(p0_season_start, min(p0_season_end, p0_data_end_date), by = "day"),
                            file_out = "public/data/snotel_daily_percentiles.json"),
    format = "file"
  ),

  # Chart data for each site in the site panel
  tar_target(
    p3_site_chart_json,
    write_site_chart_json(p2_sntl_daily_bands, p2_sntl_swe, p2_sntl_sites,
                          focal_wy = p0_water_year,
                          out_dir = "public/data/snotel_sites"),
    format = "file"
  ),

  # Settings the site's text and charts depend on
  tar_target(
    p3_run_info_csv,
    format_run_info(
      water_year = p0_water_year,
      percentile_date = p0_percentile_date,
      data_end_date = p0_data_end_date,
      season_start = p0_season_start,
      season_end = p0_season_end,
      record_start_wy = p0_record_start_wy,
      percentile_min_share = p0_percentile_min_share,
      chart_min_years = p0_chart_min_years
    ) |>
      write_web_csv("public/data/snotel_run_info.csv"),
    format = "file"
  )

)
