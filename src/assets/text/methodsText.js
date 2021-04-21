export default {
  referencesContent: {
    title: "Methods",
    references: [
      {
        id: "ref-methods",
        subTitle: "SWE and streamflow ridgelines",
        reference:
          "o	The ridgeline charts show data from a selection of USGS streamgage locations in the Upper Colorado River Basin that are part of NGWOS monitoring and modeling. Daily gridded SWE values at 4-km resolution were obtained for the 2011 and 2012 water years at each location from the <a href='https://nsidc.org/data/NSIDC-0719/versions/1' target='_blank'>National Snow & Ice Data Center</a>. Streamflow was obtained from the <a href='https://waterdata.usgs.gov/nwis?' target='_blank'>USGS National Water Information System</a>.",
      },
      {
        id: "ref-april-1-map",
        subTitle: "Mapping SNOTEL sites",
        reference:
          "April 1st SWE, peak SWE, and SM50 measurements are derived from snow telemetry (SNOTEL) data provided by the <a href='https://www.wcc.nrcs.usda.gov/snow/' target='_blank'>USDA NRCS</a>. This map shows all SNOTEL sites that were active as of 04/05/2021 (n = 835) with site color indicating April 1st SWE as the percentile of the historic record (from 1981 to 2010 ) for the subset of sites with a minimum of 20 years of data in the historical record (n = 533). Unfilled circles indicate currently active sites that lack this historic record for comparison. On mouseover, the site-level line charts that appear show peak SWE and SM50 for every year with available data starting with 1981 <a href='https://github.com/USGS-VIZLAB/snow-to-flow/blob/main/data_processing_pipeline/6_visualize/src/make_map.R' target='_blank'>See the code</a> behind this map.",
      }
    ],
  },
};
