# Fetch SNOTEL station metadata and daily SWE from the NRCS Air and Water
# Database (AWDB) REST API: https://wcc.sc.egov.usda.gov/awdbRestApi/

awdb_url <- "https://wcc.sc.egov.usda.gov/awdbRestApi/services/v1"

#' Make an AWDB API GET request and return the parsed JSON
#'
#' @param endpoint chr, API endpoint, e.g. "stations" or "data"
#' @param ... query parameters
awdb_get <- function(endpoint, ...) {
  httr2::request(awdb_url) |>
    httr2::req_url_path_append(endpoint) |>
    httr2::req_url_query(...) |>
    # NRCS occasionally returns server errors under load; retry those too
    httr2::req_retry(
      max_tries = 5,
      is_transient = \(resp) httr2::resp_status(resp) %in% c(429, 500, 502, 503, 504)
    ) |>
    httr2::req_timeout(300) |>
    httr2::req_perform() |>
    httr2::resp_body_json(simplifyVector = FALSE)
}

#' Fetch metadata for all SNOTEL stations with daily SWE, active or not
#'
#' @param file_out chr, path of the csv to write
#' @param fetch_date chr, date used to force a re-fetch; not otherwise used
#' @return chr, `file_out`
fetch_sntl_stations <- function(file_out, fetch_date) {
  stations <- awdb_get(
    "stations",
    stationTriplets = "*:*:SNTL",
    elements = "WTEQ",
    durations = "DAILY",
    returnStationElements = "true",
    activeOnly = "false"
  )

  stations |>
    purrr::map(function(s) {
      swe <- purrr::keep(s$stationElements, ~ .x$elementCode == "WTEQ")[[1]]
      tibble(
        station_triplet = s$stationTriplet,
        site_id = as.integer(s$stationId),
        state = s$stateCode,
        site_name = s$name,
        elev_ft = s$elevation,
        latitude = s$latitude,
        longitude = s$longitude,
        station_begin = as.Date(s$beginDate),
        station_end = as.Date(s$endDate),
        swe_begin = as.Date(swe$beginDate),
        swe_end = as.Date(swe$endDate)
      )
    }) |>
    list_rbind() |>
    arrange(site_id) |>
    write_csv(file_out)

  return(file_out)
}

#' Fetch daily SWE for a set of SNOTEL stations
#'
#' SWE is the start-of-day value (`periodRef = START`), matching the NRCS
#' report generator's "Start of Day Values" that the 2021 site was built from.
#'
#' @param station_triplets chr, AWDB station triplets, e.g. "672:WA:SNTL"
#' @param begin_date,end_date Date, range of data to fetch
#' @param file_out chr, path of the csv to write
#' @param fetch_date chr, date used to force a re-fetch; not otherwise used
#' @param batch_size int, stations per API request
#' @return chr, `file_out`
fetch_sntl_swe <- function(station_triplets, begin_date, end_date, file_out,
                           fetch_date, batch_size = 25) {
  batches <- split(station_triplets, ceiling(seq_along(station_triplets) / batch_size))

  purrr::map(batches, function(batch) {
    awdb_get(
      "data",
      stationTriplets = paste(batch, collapse = ","),
      elements = "WTEQ",
      duration = "DAILY",
      periodRef = "START",
      beginDate = format(begin_date),
      endDate = format(end_date)
    ) |>
      purrr::map(function(s) {
        values <- s$data[[1]]$values
        tibble(
          site_id = as.integer(strsplit(s$stationTriplet, ":")[[1]][1]),
          date = as.Date(purrr::map_chr(values, "date")),
          swe = purrr::map_dbl(values, ~ .x$value %||% NA_real_)
        )
      }) |>
      list_rbind()
  }) |>
    list_rbind() |>
    arrange(site_id, date) |>
    write_csv(file_out)

  return(file_out)
}
