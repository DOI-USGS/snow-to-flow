source('1_fetch/src/fetch_SNOTEL_data.R')

p1_targets_list <- list(

  # date last updated
  tar_target(
    p1_today,
    as.Date('2023-04-11')
  ),
  # get site metadata for currently active sites
  tar_target(
    p1_site_meta_data,
    snotel_info() |>
      filter(end >= p1_today - 7)
  ),
  # all snotel sites
  tar_target(
    p1_snotel_sites,
    p1_site_meta_data |>
      filter(year(start) <= 1981)
  ),
  tar_target(
    p1_snotel_states,
    unique(p1_snotel_sites$state)
  ),

  # fetch SNOTEL data - takes an hour for full fetch
  tar_target(
    p1_snotel_files,
    fetch_SNOTEL_data(p1_snotel_sites, p1_snotel_states),
    format = 'file',
    pattern = map(p1_snotel_states)
  )


)

