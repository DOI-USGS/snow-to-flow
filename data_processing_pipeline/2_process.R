source('2_process/src/prep_SNOTEL.R')

p2_targets_list <- list(
  # parse data
  tar_target(
    p2_snotel_data,
    p1_snotel_files |> purrr::map_dfr(read_csv) |>
      mutate(year = year(date),
             WY = dataRetrieval::calcWaterYear(date))

  ),

  # find magnitude of peak SWE, Apr 1st SWE, and SM50
  tar_target(
    p2_snotel_swe,
    swe_magnitude(p2_snotel_data)

  )

)
