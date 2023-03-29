source('2_process/src/prep_SNOTEL.R')

p2_targets_list <- list(
  # parse data
  tar_target(
    snotel_data,
    snotel_files |> purrr::map_dfr(read_csv) |>
      mutate(year = year(date),
             WY = dataRetrieval::calcWaterYear(date))

  ),

  # find magnitude of peak SWE, Apr 1st SWE, and SM50
  tar_target(
    snotel_swe,
    swe_magnitude(snotel_data)

  )

)
