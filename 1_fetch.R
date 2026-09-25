source("1_fetch/src/fetch_sntl.R")
source("1_fetch/src/fetch_census.R")

p1_targets <- list(

  # Metadata for every SNOTEL station with daily SWE, active or not
  tar_target(
    p1_sntl_stations_csv,
    fetch_sntl_stations(file_out = "1_fetch/out/sntl_stations.csv",
                        fetch_date = p0_fetch_date),
    format = "file"
  ),
  tar_target(
    p1_sntl_stations,
    read_csv(p1_sntl_stations_csv, show_col_types = FALSE)
  ),

  # Stations with a SWE record open at some point from the percentile date to
  # the last day of data. This is the superset fetched; which of them appear
  # on the map is decided in 2_process
  tar_target(
    p1_sntl_sites,
    p1_sntl_stations |>
      filter(swe_begin <= p0_data_end_date, swe_end >= p0_percentile_date)
  ),
  tar_target(
    p1_sntl_states,
    sort(unique(p1_sntl_sites$state))
  ),

  # Daily SWE for each state's stations, from the start of each station's
  # record (the NRCS period of record) through the last day of data
  tar_target(
    p1_sntl_swe_csv,
    fetch_sntl_swe(
      station_triplets = filter(p1_sntl_sites, state == p1_sntl_states)$station_triplet,
      begin_date = min(filter(p1_sntl_sites, state == p1_sntl_states)$swe_begin),
      end_date = p0_data_end_date,
      file_out = sprintf("1_fetch/out/sntl_swe_%s.csv", p1_sntl_states),
      fetch_date = p0_fetch_date
    ),
    pattern = map(p1_sntl_states),
    format = "file"
  ),

  # State boundaries for the basemap; the same Census file the 2021 map used
  tar_target(
    p1_states_shp,
    fetch_census_shp(layer = "cb_2018_us_state_5m", out_dir = "1_fetch/out",
                     fetch_date = p0_fetch_date),
    format = "file"
  )

)
