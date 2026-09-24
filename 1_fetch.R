source("1_fetch/src/fetch_sntl.R")

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

  # Stations with a SWE record open on the last day of data. This is the
  # superset fetched; which of them appear on the map is decided in 2_process
  tar_target(
    p1_sntl_sites,
    p1_sntl_stations |>
      filter(swe_begin <= p0_data_end_date, swe_end >= p0_data_end_date)
  ),
  tar_target(
    p1_sntl_states,
    sort(unique(p1_sntl_sites$state))
  ),

  # Daily SWE for each state's stations, from the start of the record through
  # the last day of data
  tar_target(
    p1_sntl_swe_csv,
    fetch_sntl_swe(
      station_triplets = filter(p1_sntl_sites, state == p1_sntl_states)$station_triplet,
      begin_date = as.Date(sprintf("%s-10-01", p0_record_start_wy - 1)),
      end_date = p0_data_end_date,
      file_out = sprintf("1_fetch/out/sntl_swe_%s.csv", p1_sntl_states),
      fetch_date = p0_fetch_date
    ),
    pattern = map(p1_sntl_states),
    format = "file"
  )

)
