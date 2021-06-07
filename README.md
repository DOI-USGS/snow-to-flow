# From Snow to Flow Visualization

![A screencapture of the Snow to Flow header, which shows an abstract collage of snowy mountains and a frozen lake under a series of snow and discharge line charts.](https://github.com/USGS-VIZLAB/snow-to-flow/blob/main/public/SnowToFlowCover.jpg)

See the page live: https://labs.waterdata.usgs.gov/visualizations/snow-to-flow/index.html#/

A majority of the water in the Western United States comes from snowmelt. Winter snow accumulation, as well as spring snowmelt, affect streamflow and water availability for the rest of the year. Changes in the timing, magnitude, and duration of snowmelt may substantially alter downstream water availability. In fact, approximately 2 billion people are expected to experience diminished water supplies because of seasonal snowpack decline this century.

This data visualization explores the fundamentals of USGS snow hydrology research. The graphics describe important dynamics that determine how snow turns into flow, and the charts show the connection between snowpack (measured as snow water equivalent) and streamflow (measured as discharge). A reproducible datapipline has pulled data for the 2021 water year to display the snow conditions as of April 1st, 2021.

All charts, data, and diagrams are free and open to the public. Take screencaptures of what you need, or browse through some extra images at: https://github.com/USGS-VIZLAB/snow-to-flow/tree/main/public/public_images

## The Code

The project is Open Source and uses the Vue JavaScript framework in conjunction with animated Scalable Vector Graphics (SVG) and raster graphics. The build process uses the Jenkins task runner and Docker containerisation.

## Project Setup

- Clone the project to your local system
- `cd` to the cloned directory
- Download the Node Package Manager(NPM) dependencies by running `npm install` in your terminal window
- Start the project by running `npm run serve` -- the address of the project will show on completion usually `localhost:8080`
- Start your browser, enter the address found above
- And that's it, easy peasie

### Notes on Setup

- You will need 'node.js' installed on your system
- If you run into trouble starting the project, it is usually fixed by running `npm rebuild node-sass`
- The Windows operating system does not like our environment variables and messes up the local build.

To fix that, do the following:

- Open the 'package.json' at the root of the project
- Go to the 'scripts' name value pair
- Go to the 'serve' name value pair
- Delete `NODE_ENV=development` from that value
- That value should now look like `"serve": "vue-cli-service serve --mode test_tier",`
- Run `npm run serve` again, and the project should start
  On Windows -
  You might get this error when running `npm run serve`

`'vue-cli-service' is not recognized as an internal or external command, operable program or batch file.`

- To fix, run `npm install @vue/cli-service -g` to install the Vue CLI-Service globally.

## Data processing

The data processing steps behind the charts and maps on the Snow-to-flow page are documented in the `data_processing_pipeline` subdirectory of this repo. Briefly, daily snow water equivalent values were pulled from all USDA NRCS snow telemetry sites since 1981 in `1_fetch/src/fetch_SNOTEL.R`. This data was used to calculate peak SWE and SM50 at all sites with a minimum of 20 years of data in the historic record (1981-2011) in `2_process/src/prep_SNOTEL.R`. In addition, April 1st SWE was accessed through time for each site and used to find the percentile in WY2021. These metrics were used to draw mouseover SWE curves and trendlines, that were pre-defined in R `6_visualize/src/trend_coords.R`. The trendline charts are displayed with an svg map of the Western U.S., that was also first pre-processed in R `6_visualize/src/make_map.R` and brought to life using D3.js and Vue.js. The final data files used to draw these charts are labelled `SNOTEL_...csv` here:https://github.com/USGS-VIZLAB/snow-to-flow/tree/main/public/data

The SWE and streamflow ridgelines are drawn using daily gridded SWE values at 4-km resolution were obtained for the 2011 and 2012 water years at each location from the National Snow & Ice Data Center. Streamflow was obtained from the USGS National Water Information System. The data generating these charts is available here: https://github.com/USGS-VIZLAB/snow-to-flow/tree/main/public/data (`mmd_df_2011.csv`, `mmd_df_2012.csv`, `swe_df_2011.csv`, `swe_df_2012.csv`).
