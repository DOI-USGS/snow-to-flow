library(targets)

options(tidyverse.quiet = TRUE)

tar_option_set(packages = c(
  # global
  "tidyverse",
  "lubridate"
))

# Phase target makefiles
source("0_config.R")
source("1_fetch.R")
source("2_process.R")
source("3_visualize.R")

# Combined list of target outputs
c(p0_targets, p1_targets, p2_targets, p3_targets)
