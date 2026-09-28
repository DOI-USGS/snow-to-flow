# Compare the new targets pipeline's 2021 values with this folder's outputs,
# the data behind the 2021 site. Run from the repo root after tar_make().
# Remove along with this folder once the new pipeline's outputs replace it.
#
# Every difference is classed as one of:
# - nrcs_changed: NRCS inserted or changed SWE values for that site and water
#   year after the old data were pulled (from 2021-03-01), usually QC edits
# - old_history_broken: the old historical pull returned near-zero SWE for
#   the site, so its old peaks are 0-1 inches in nearly every year
# - unexplained: anything else. One is known: site 979 in WY2017, whose old
#   peak came from late January values NRCS has since flagged as suspect and
#   withholds; flag changes don't show up in the insert/update check

library(tidyverse)
source("1_fetch/src/fetch_sntl.R")

old_sites <- bind_rows(read_csv("public/data/SNOTEL_conus_d_test.csv", show_col_types = FALSE),
                       read_csv("public/data/SNOTEL_ak_d_test.csv", show_col_types = FALSE))
old_stats <- read_csv("data_processing_pipeline/2_process/out/SNOTEL_stats_POR.csv",
                      show_col_types = FALSE) |>
  filter(water_year >= 1981)
new_sites <- targets::tar_read(p2_sntl_sites)
new_stats <- targets::tar_read(p2_sntl_annual_stats)
stations <- targets::tar_read(p1_sntl_stations)

same <- function(a, b) (is.na(a) & is.na(b)) | (!is.na(a) & !is.na(b) & abs(as.numeric(a) - as.numeric(b)) < 1e-9)

# Site-years where NRCS inserted or changed values after the old pulls
changed <- split(stations$station_triplet, ceiling(seq_len(nrow(stations)) / 25)) |>
  map(function(batch) {
    awdb_get("data", stationTriplets = paste(batch, collapse = ","), elements = "WTEQ",
             duration = "DAILY", periodRef = "START", beginDate = "1980-10-01",
             endDate = "2021-04-22", insertOrUpdateBeginDate = "2021-03-01") |>
      map(function(s) {
        v <- if (length(s$data)) s$data[[1]]$values else list()
        tibble(site_id = as.integer(strsplit(s$stationTriplet, ":")[[1]][1]),
               date = as.Date(map_chr(v, "date")))
      }) |>
      list_rbind()
  }) |>
  list_rbind() |>
  mutate(water_year = year(date) + if_else(month(date) >= 10, 1, 0))
changed_years <- distinct(changed, site_id, water_year) |> mutate(nrcs_changed = TRUE)
changed_apr1 <- changed |> filter(month(date) == 4, day(date) == 1) |> distinct(site_id) |> mutate(apr1_changed = TRUE)

# Sites whose old history is near zero in most years
broken_sites <- old_stats |>
  group_by(site_id) |>
  summarize(share_near_zero = mean(peak_swe <= 1, na.rm = TRUE)) |>
  filter(share_near_zero >= 0.5) |>
  pull(site_id)

classify <- function(df) {
  df |> mutate(cause = case_when(
    match ~ "match",
    site_id %in% broken_sites ~ "old_history_broken",
    nrcs_changed ~ "nrcs_changed",
    TRUE ~ "unexplained"
  ))
}

# Annual peak SWE, peak date, SM50 date, and April 1st SWE (the trend charts)
annual <- inner_join(old_stats, new_stats, by = c("site_id", "water_year"), suffix = c("_old", "_new")) |>
  left_join(changed_years, by = c("site_id", "water_year")) |>
  mutate(nrcs_changed = replace_na(nrcs_changed, FALSE),
         match = same(peak_swe_old, peak_swe_new) & same(peak_date_old, peak_date_new) &
           same(sm50_date_old, sm50_date_new) & same(apr1_swe_old, apr1_swe_new)) |>
  classify()
cat("Annual values, site-years in both:", nrow(annual), "\n")
print(count(annual, cause))

# 2021 percentile
ptile <- inner_join(select(old_sites, site_id, p_old = ptile_swe),
                    select(new_sites, site_id, p_new = ptile_swe), by = "site_id") |>
  filter(!is.na(p_old) | !is.na(p_new)) |>
  left_join(changed_apr1, by = "site_id") |>
  mutate(nrcs_changed = replace_na(apr1_changed, FALSE), match = same(p_old, p_new)) |>
  classify()
cat("\n2021 percentile, sites with one in either version:", nrow(ptile), "\n")
print(count(ptile, cause, old_has = !is.na(p_old), new_has = !is.na(p_new)))

unexplained <- bind_rows(filter(annual, cause == "unexplained"), filter(ptile, cause == "unexplained"))
cat("\nUnexplained differences:", nrow(unexplained), "\n")
if (nrow(unexplained)) print(select(unexplained, site_id, water_year, any_of(c(
  "peak_swe_old", "peak_swe_new", "peak_date_old", "peak_date_new",
  "sm50_date_old", "sm50_date_new", "apr1_swe_old", "apr1_swe_new", "p_old", "p_new"))))
