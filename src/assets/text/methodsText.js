export default {
  referencesContent: {
    title: "Methods",
    references: [
      {
        id: "ref-methods",
        subTitle: "SWE and streamflow ridgelines",
        reference:
          "The ridgeline charts show data from a selection of USGS streamgage locations in the Upper Colorado River Basin that are part of NGWOS monitoring and modeling. Daily gridded SWE values at 4-km resolution were obtained for the 2011 and 2012 water years at each location from the <a href='https://nsidc.org/data/nsidc-0719/versions/1' target='_blank'>National Snow & Ice Data Center</a>. Streamflow was obtained from the <a href='https://waterdata.usgs.gov/' target='_blank'>USGS National Water Information System</a>.",
      },
      {
        id: "ref-april-1-map",
        subTitle: "Mapping SNOTEL sites",
        reference:
          "April 1st SWE, peak SWE, and SM50 are derived from snow telemetry (SNOTEL) data provided by the <a href='https://www.nrcs.usda.gov/resources/data-and-reports/snow-and-climate-monitoring-predefined-reports-and-maps' target='_blank'>USDA NRCS</a>. The map shows the SNOTEL sites active on the date shown, colored by SWE on that date as a percentile of the site's period of record for the same date, calculated as in the <a href='https://www.nrcs.usda.gov/sites/default/files/2023-03/iMap_Glossary.pdf' target='_blank'>NRCS interactive map</a>: the percentile is 1 - (m - 1)/(n - 1), where m is the rank of this year's value from the highest and n is the number of years with data, including this year. A site gets a percentile if it has data in at least two thirds of the years in its period of record, and a site with no snow on the date is ranked only if it usually has snow then. Sites without a percentile are shown in grey. Peak SWE is the highest daily SWE in a water year, and SM50 is the first day on or after the peak when SWE has fallen to half of it. On mouseover, the charts show SWE through the current water year, and peak SWE and SM50 for every year since 1981, for sites with at least 10 complete water years of record. <a href='https://github.com/DOI-USGS/snow-to-flow#to-build-pipeline-and-reproduce-figures' target='_blank'>See the code</a> behind this map.",
      }
    ],
  },
};
