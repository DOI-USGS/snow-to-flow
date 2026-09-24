# From Snow to Flow

**The data visualization website can be viewed at [https://water.usgs.gov/vizlab/snow-to-flow](https://water.usgs.gov/vizlab/snow-to-flow).**

A majority of the water in the western U.S. comes from snowmelt. This site explores the fundamentals of USGS snow hydrology research: the dynamics that determine how snow turns into flow, and the connection between snowpack (measured as snow water equivalent, SWE) and streamflow.

## To build pipeline and reproduce figures
The SNOTEL data shown on the site are fetched and processed by an R pipeline built with the `targets` package. Clone the repo. In R, from the repo root, run `library(targets)` and `tar_make()`. The first run downloads the full SNOTEL record, which takes about ten minutes.

The pipeline settings are in `0_config.R`: the water year shown on the site, the date its SWE percentile is calculated for, the last day of data, and the thresholds for which sites get percentiles and charts. The site currently shows April 1, 2026. To update the site for a new year, change these settings and `p0_fetch_date`, then run `tar_make()` again.

## Data processing
- `1_fetch`: SNOTEL station metadata and daily SWE (start-of-day values) come from the [NRCS Air and Water Database REST API](https://wcc.sc.egov.usda.gov/awdbRestApi/), and state boundaries from the U.S. Census Bureau.
- `2_process`: for every site and water year, peak SWE and its date, SM50 (the first day on or after the peak when SWE has fallen to half of it), and April 1st SWE. Each site's SWE on the percentile date is ranked against the same day in the site's period of record, as in the [NRCS interactive map](https://www.nrcs.usda.gov/sites/default/files/2023-03/iMap_Glossary.pdf): percentile = 1 - (m - 1)/(n - 1), where m is the rank from the top and n the number of years, for sites with data in at least two thirds of their record's years.
- `3_visualize`: writes the data the site reads to [`public/data`](https://github.com/DOI-USGS/snow-to-flow/tree/main/public/data): `snotel_sites.csv`, `snotel_annual.csv`, `snotel_swe_daily.csv`, `snotel_run_info.csv`, and `snotel_states.geojson`.

The map currently still reads `SNOTEL_conus_d_test.csv` and `SNOTEL_ak_d_test.csv`, made by the earlier scripts in `data_processing_pipeline`. That folder is being replaced by the pipeline above and will be removed once the map uses the new files.

The SWE and streamflow ridgelines use daily gridded SWE at 4-km resolution from the National Snow & Ice Data Center for the 2011 and 2012 water years, and streamflow from the USGS National Water Information System. Their data are `mmd_df_2011.csv`, `mmd_df_2012.csv`, `swe_df_2011.csv`, `swe_df_2012.csv`, and `gage_sp.csv` in [`public/data`](https://github.com/DOI-USGS/snow-to-flow/tree/main/public/data). They cover fixed years and are not yet part of the pipeline.

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
