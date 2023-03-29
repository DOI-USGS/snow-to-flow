source('1_fetch/src/fetch_SNOTEL_data.R')

p1_targets_list <- list(

  # date last updated
  tar_target(
    today,
    as.Date('2023-03-29')
  ),
  # get site metadata for currently active sites
  tar_target(
    site_meta_data,
    snotel_info() |>
      filter(end >= today - 7)
  ),
  # all snotel sites
  tar_target(
    snotel_sites,
    site_meta_data |>
      filter(year(start) <= 1981)
  ),
  tar_target(
    snotel_states,
    unique(snotel_sites$state)
  ),

  # fetch SNOTEL data - takes an hour for full fetch
  tar_target(
    snotel_files,
    {
      file_out <- sprintf('1_fetch/out/snotel_%s.csv', snotel_states)
      state_sites <- snotel_sites |> filter(state == snotel_states) |> pull(site_id) |> unique()
      snotel_data <- snotel_download(site_id = state_sites, internal = TRUE)
      write_csv(snotel_data, file_out)
      return(file_out)
    },
    format = 'file',
    pattern = map(snotel_states)
  )


)

