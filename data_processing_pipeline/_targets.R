library(targets)

options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("tidyverse","lubridate",
                            "scico", "colorspace",
                            "sf", "terra", "ncdf4","rmapshaper",
                            "dataRetrieval","nhdplusTools", "snotelr"
                            ))

source("1_fetch.R")
source("2_process.R")
#source("3_visualize.R")

# Targets to build
c(p1_targets_list, p2_targets_list)
