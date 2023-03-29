# determine magnitude to SWE
swe_magnitude <- function(data){

  # find SWE on Apr 1
  swe_apr1 <- data |>
    filter(date == as.Date(sprintf('%s-04-01', year))) |>
    # group_by(site_id, WY) |>
    distinct(site_id, WY, snow_water_equivalent) |>
    rename(swe_apr1 = snow_water_equivalent)

  # Find peak SWE and SM50 SWE
  swe_peak <- data |>
    dplyr::select(WY, year, site_id, snow_water_equivalent) |>
    group_by(site_id, WY) |>
    slice(which.max(snow_water_equivalent)) |>
    rename(swe_peak = snow_water_equivalent) |>
    mutate(swe_sm50 = swe_peak/2) |>
    select(-year)

  # expand to every year for every site
  expand_grid(
    site_id = unique(data$site_id),
    WY = seq(1980, max(data$WY))
  ) |>
    left_join(swe_apr1) |>
    left_join(swe_peak)

}
