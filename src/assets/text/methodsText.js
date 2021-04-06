export default {
  referencesContent: {
    title: "Methods",
    references: [
      {
        id: "ref-methods",
        subTitle: "SWE and streamflow ridgelines",
        reference:
          "The ridgeline charts show data from a selection of USGS GAGES-2 locations in the Upper Colorado River Basin that are part of NGWOS monitoring and modeling efforts in the region. For each location, SWE values are sourced from [CN needs to ask John about these details] and discharge data came from  NWIS instantaneous streamflow measurements at each site, multiplied by drainage area. See the code that pulls this data here: [CN still needs to add this to the github repo] <a href='https://www.google.com' target='_blank'>Test Link</a>",
      },
      {
        id: "ref-april-1-map",
        subTitle: "Mapping SNOTEL sites",
        reference:
          "April 1st SWE, peak SWE, and SM50 measurements are derived from snow telemetry (SNOTEL) data provided by the USDA NRCS. This map shows all SNOTEL sites that were active as of 03/22/2021 (n = 835) with site color indicating April 1st SWE as the percentile of the historic record (from 1981 to 2010 ) for the subset of sites with a minimum of 20 years of data in the historical record (n = 533). Unfilled circles indicate currently active sites that lack this historic record for comparison (n = ). 	On mouseover, the site-level line charts that appear show peak SWE and SM50 for every year that had data available starting with 1981. <a href='https://www.google.com' target='_blank'>See the code</a> behind this map.",
      }
    ],
  },
};
