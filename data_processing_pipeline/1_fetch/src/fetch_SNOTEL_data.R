#' Fetch SNOTEL data
#'
#' Download SNOTEL data and return output file path
#'
#' @param snotel_sites `data.frame`, table of SNOTEL sites and metadata returned by `snotelr::snotel_info()`
#' @param snotel_states chr, vector of two letter state abbreviations for states of interest
#' @param file_out_template chr, output file path template for SNOTEL data that combines `file_out_template` and `snotel_states`
#'
fetch_SNOTEL_data <- function(snotel_sites, snotel_states, file_out_template = '1_fetch/out/snotel_%s.csv') {

  file_out <- sprintf(file_out_template, snotel_states)
  state_sites <- snotel_sites |> filter(state == snotel_states) |> pull(site_id) |> unique()
  snotel_data <- snotel_download(site_id = state_sites, internal = TRUE)
  write_csv(snotel_data, file_out)
  return(file_out)
}
