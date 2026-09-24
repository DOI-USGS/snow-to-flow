# Map layers the site stacks in the browser: for each map panel (the western
# states and an Alaska inset), a hillshade PNG and state and outline SVGs on one shared pixel
# grid, plus the site positions on that grid. The pattern follows
# gulf-hypoxia's map layers.

#' Project states for a map panel
#'
#' @param states_shp chr, path of the Census states shapefile
#' @param states chr, state abbreviations to keep
#' @param proj chr, proj4 string for the panel
prep_panel_states <- function(states_shp, states, proj) {
  st_read(states_shp, quiet = TRUE) |>
    filter(STUSPS %in% states) |>
    select(state = STUSPS, name = NAME) |>
    st_transform(proj)
}

#' Map panel extent: the focus states and the panel's sites, padded
#'
#' @param states_shp chr, path of the Census states shapefile
#' @param focus chr, state abbreviations that set the extent
#' @param proj chr, proj4 string for the panel
#' @param lon_min num, westernmost longitude of the focus area
#' @param sites data frame with longitude and latitude
#' @param pad num, padding as a share of the larger side
panel_extent <- function(states_shp, focus, proj, lon_min, sites, pad = 0.02) {
  focus_sf <- st_read(states_shp, quiet = TRUE) |>
    filter(STUSPS %in% focus) |>
    st_transform(4326) |>
    st_crop(xmin = lon_min, xmax = 180, ymin = -90, ymax = 90) |>
    st_transform(proj)
  site_sf <- st_as_sf(sites, coords = c("longitude", "latitude"), crs = 4326) |>
    st_transform(proj)
  bbox <- st_bbox(c(st_geometry(focus_sf), st_geometry(site_sf)))
  margin <- pad * max(bbox["xmax"] - bbox["xmin"], bbox["ymax"] - bbox["ymin"])
  bbox + c(-margin, -margin, margin, margin)
}

#' Clip projected features to a panel's extent
clip_to_bbox <- function(sf_obj, bbox) {
  suppressWarnings(st_crop(st_make_valid(sf_obj), bbox))
}

#' Pixels per metre in a panel's SVGs
#'
#' mapshaper's SVG export maps the bbox onto the canvas with a 1-pixel margin
#' on each side: xmin lands at x = 1 and xmax at x = width - 1, and ymax at
#' y = 1. The hillshade and site positions use the same transform so every
#' layer lines up.
panel_scale <- function(bbox, width_px) {
  unname((width_px - 2) / (bbox["xmax"] - bbox["xmin"]))
}

#' Pixel height of a panel's SVGs, as mapshaper sets it
panel_height_px <- function(bbox, width_px) {
  as.integer(ceiling(unname(bbox["ymax"] - bbox["ymin"]) * panel_scale(bbox, width_px) + 2))
}

#' Build a hillshade PNG for a map panel
#'
#' Elevation comes from the AWS Terrain Tiles via elevatr. Flat ground is
#' white and only slopes facing away from the light darken, so the relief
#' fades into the page; everything outside the panel's states is transparent.
#'
#' @param panel_states sf, projected states; also the land mask
#' @param bbox bbox of the panel
#' @param width_px int, output width in pixels
#' @param out_png chr, path of the PNG to write
#' @param z int, elevatr zoom level
#' @param z_factor num, vertical exaggeration so gentle relief reads
#' @param flat_grey,shadow_floor,highlight_ceiling num, tone of flat ground
#'   (0-255) and the darkest and lightest shading relative to it
build_hillshade_png <- function(panel_states, bbox, width_px, out_png, z = 5,
                                z_factor = 8, flat_grey = 255,
                                shadow_floor = 0.6, highlight_ceiling = 1) {
  # One raster cell per SVG pixel, covering the whole SVG canvas
  height_px <- panel_height_px(bbox, width_px)
  px <- 1 / panel_scale(bbox, width_px) # metres per pixel
  xmin <- unname(bbox["xmin"]) - px
  ymax <- unname(bbox["ymax"]) + px
  template <- terra::rast(
    terra::ext(xmin, xmin + width_px * px, ymax - height_px * px, ymax),
    ncol = width_px, nrow = height_px, crs = st_crs(panel_states)$wkt
  )

  dem <- fetch_panel_dem(template, z)
  dem[dem < 0] <- 0 # ocean and bathymetry read as flat

  dem <- dem * z_factor
  hs <- terra::shade(terra::terrain(dem, v = "slope", unit = "radians"),
                     terra::terrain(dem, v = "aspect", unit = "radians"),
                     angle = 45, direction = 315)
  ref <- median(terra::values(hs), na.rm = TRUE) # shading of flat ground
  grey <- terra::clamp(hs / ref, shadow_floor, highlight_ceiling) * flat_grey
  grey <- terra::clamp(grey, 0, 255)

  land <- terra::rasterize(terra::vect(panel_states), template, field = 1, touches = TRUE)
  alpha <- terra::ifel(is.na(land), 0, 255)
  grey <- terra::ifel(is.na(grey), flat_grey, grey)

  terra::writeRaster(c(grey, grey, grey, alpha), out_png, datatype = "INT1U",
                     overwrite = TRUE, NAflag = NA, gdal = "ZLEVEL=9")
  unlink(paste0(out_png, ".aux.xml"))
  out_png
}

#' Fetch elevation for a panel's grid from the AWS Terrain Tiles
#'
#' The tiles are requested by longitude and latitude, so the panel's extent is
#' split at the 180th meridian first; otherwise a panel spanning it (Alaska's
#' Aleutians) requests the wrong side of the globe.
#'
#' @param template SpatRaster, the panel grid
#' @param z int, elevatr zoom level
fetch_panel_dem <- function(template, z) {
  parts <- st_as_sfc(st_bbox(template)) |>
    st_segmentize(dfMaxLength = 5e4) |>
    st_transform(4326) |>
    st_wrap_dateline() |>
    st_cast("POLYGON")

  purrr::map(seq_along(parts), function(i) {
    bb <- st_bbox(parts[i])
    # keep edges on the meridian inside the range elevatr accepts
    bb[c("xmin", "xmax")] <- pmin(pmax(bb[c("xmin", "xmax")], -179.99), 179.99)
    elevatr::get_elev_raster(st_as_sf(st_as_sfc(bb)), z = z,
                             clip = "bbox", verbose = FALSE) |>
      terra::rast() |>
      terra::project(template)
  }) |>
    purrr::reduce(terra::cover)
}

#' Export an sf layer to SVG on the panel's pixel grid with mapshaper
#'
#' @param sf_obj sf, projected layer
#' @param bbox bbox of the panel
#' @param width_px int, SVG width in pixels
#' @param out_svg chr, path of the SVG to write
#' @param id_column chr, column used for element ids
#' @param simplify chr, mapshaper simplify amount, e.g. "20%"
#' @param style chr, mapshaper -style options, e.g. c("fill=none", "stroke=white")
export_sf_layer_svg <- function(sf_obj, bbox, width_px, out_svg,
                                id_column = NULL, simplify = NULL, style = NULL) {
  temp_gj <- tempfile(fileext = ".geojson")
  on.exit(unlink(temp_gj), add = TRUE)
  st_write(sf_obj, temp_gj, quiet = TRUE)

  args <- shQuote(temp_gj)
  if (!is.null(simplify)) args <- c(args, "-simplify", simplify, "keep-shapes")
  if (!is.null(style)) args <- c(args, "-style", style)
  args <- c(args, "-o", "format=svg",
            sprintf("svg-bbox=%.3f,%.3f,%.3f,%.3f",
                    bbox["xmin"], bbox["ymin"], bbox["xmax"], bbox["ymax"]),
            paste0("width=", width_px))
  if (!is.null(id_column)) args <- c(args, paste0("id-field=", id_column))
  args <- c(args, shQuote(out_svg))

  log <- system2("mapshaper", args = args, stdout = TRUE, stderr = TRUE)
  status <- attr(log, "status")
  if (!is.null(status) && status != 0) {
    stop("mapshaper SVG export failed:\n", paste(log, collapse = "\n"))
  }
  out_svg
}

#' Site positions in panel pixels, matching the layer SVGs (y down)
#'
#' @param sites data frame with site_id, longitude, latitude
#' @param panel chr, panel name
#' @param proj chr, proj4 string for the panel
#' @param bbox bbox of the panel
#' @param width_px int, panel width in pixels
site_panel_xy <- function(sites, panel, proj, bbox, width_px) {
  scale <- panel_scale(bbox, width_px)
  xy <- sites |>
    st_as_sf(coords = c("longitude", "latitude"), crs = 4326) |>
    st_transform(proj) |>
    st_coordinates()
  tibble(
    site_id = sites$site_id,
    panel = panel,
    x = round(1 + (xy[, "X"] - bbox["xmin"]) * scale, 2),
    y = round(1 + (bbox["ymax"] - xy[, "Y"]) * scale, 2)
  )
}
