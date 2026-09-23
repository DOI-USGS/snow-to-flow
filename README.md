# From Snow to Flow

**The data visualization website can be viewed at [https://water.usgs.gov/vizlab/snow-to-flow](https://water.usgs.gov/vizlab/snow-to-flow).**

A majority of the water in the western U.S. comes from snowmelt. This site explores the fundamentals of USGS snow hydrology research: the dynamics that determine how snow turns into flow, and the connection between snowpack (measured as snow water equivalent, SWE) and streamflow.

## To build pipeline and reproduce figures
The data shown on the site are fetched and processed by an R pipeline built with the `targets` package, in the `data_processing_pipeline` subdirectory.

Clone the repo. In RStudio, open `data_processing_pipeline/data_processing_pipeline.Rproj`, then run `library(targets)` and `tar_make()`. To update the data to a new date, set `p1_today`, which `1_fetch.R` uses to filter recent sites.

## Data processing
Daily SWE values are pulled from all USDA NRCS snow telemetry (SNOTEL) sites since 1981 (`1_fetch/src/fetch_SNOTEL.R`). These are used to calculate peak SWE and SM50 at every site with at least 20 years in the historic record, 1981-2011 (`2_process/src/prep_SNOTEL.R`), and to find each site's April 1st SWE percentile. Hover curves and trendlines for the map are pre-computed in `6_visualize/src/trend_coords.R`, and the map itself in `6_visualize/src/make_map.R`. The resulting `SNOTEL_*.csv` files are in [`public/data`](https://github.com/DOI-USGS/snow-to-flow/tree/main/public/data).

The SWE and streamflow ridgelines use daily gridded SWE at 4-km resolution from the National Snow & Ice Data Center for the 2011 and 2012 water years, and streamflow from the USGS National Water Information System. Their data are `mmd_df_2011.csv`, `mmd_df_2012.csv`, `swe_df_2011.csv`, and `swe_df_2012.csv` in [`public/data`](https://github.com/DOI-USGS/snow-to-flow/tree/main/public/data).

## Building the website locally

Clone the repo. In the directory, run `npm install` to install the required modules. Once the dependencies have been installed, run `npm run dev` to run locally from your browser.

To build the website locally you'll need `node.js` `v22.14.0` and `npm` `v10.9.2` or higher installed. To manage multiple versions of `npm`, you may [try using `nvm`](https://betterprogramming.pub/how-to-change-node-js-version-between-projects-using-nvm-3ad2416bda7e).

## Citation

Nell, C., Wernimont, M., Corson-Dosch, H., and Platt, L. From Snow to Flow. U.S. Geological Survey website. Reston, VA. [https://water.usgs.gov/vizlab/snow-to-flow](https://water.usgs.gov/vizlab/snow-to-flow)

## Consulting subject matter experts
John Hammond and Jessica Driscoll consulted on the development of this website as subject matter experts.

## Additional information
* We welcome contributions from the community. See the [guidelines for contributing](https://github.com/DOI-USGS/snow-to-flow/) to this repository on GitHub.
* [Disclaimer](https://github.com/DOI-USGS/snow-to-flow/blob/main/DISCLAIMER.md)
* [License](https://github.com/DOI-USGS/snow-to-flow/blob/main/LICENSE.md)
