<template>
  <!---VizSection-->
  <VizSection
    id="measuring-swe"
    :take-away="false"
  >
    <template #aboveExplanation>
      <p>Using high-quality manual and station observations of snowpack and streamflow, USGS scientists are conducting research on trends in snowfall, snow cover, snow versus rain<sup>10</sup>, snow water equivalent, snowmelt runoff<sup>11</sup>, snowmelt timing<sup>12</sup> and snow chemistry in the U.S. USGS scientists are also evaluating the influence of changing climate on hydrological processes and runoff in snowmelt dominated basins<sup>13</sup>.</p>
    </template>
    <!-- FIGURES -->
    <template #figures>
      <div class="group single maxWidth">
        <figure id="swe-chart-container">
          <!-- <img src="@/assets/diagrams/SWE-sketch.png"> -->
          <ImgCarousel />
        </figure>
      </div>
    </template>
    <!-- FIGURE CAPTION -->
    <template #figureCaption>
      <p>
        Click on the images to learn more about how USGS snow hydrologists measure SWE in the field. 
      </p>
    </template>
    <!-- EXPLANATION -->
    <template #belowExplanation>
      <p>
        The <a
          href="https://www.nrcs.usda.gov/wps/portal/nrcs/site/national/home/"
          target="_blank"
        >Natural Resources Conservation Service (NRCS)</a> operates a snow monitoring program that includes over 800 automated <a
          href="https://www.wcc.nrcs.usda.gov/snow/"
          target="_blank"
        >Snow Telemetry (SNOTEL)</a> data collection sites that monitor SWE, snow depth, precipitation, temperature, and other related meteorological variables.
      </p>
      <p>
        Streamflow measurements from the <a
          href="https://labs.waterdata.usgs.gov/visualizations/gages-through-the-ages/index.html#/"
          target="_blank"
        >USGS streamgaging network</a> are used to further our understanding of snowmelt processes. Some of the oldest USGS streamgages in the Western U.S. (100-125 year records) derive their streamflow from seasonal snowmelt, contributing to a long record of data to analyze seasonal and historical runoff patterns.
      </p>
    </template>
  </VizSection>
</template>

<script>
import VizSection from '@/components/VizSection';
import ImgCarousel from '@/components/ImgCarousel';
import * as d3 from 'd3';

export default {
    name: "MeasuringSWE",
    components:{
        VizSection,
        ImgCarousel
    },
    data() {
      return {
         publicPath: process.env.BASE_URL,
        //  message: "hey"
      }      
    },
    mounted() {
      
    },
    methods: {
      
    }
}
</script>

<style lang="scss" scoped>
  #swe-chart-container {
    width: 100%;
    height: auto;
  }
</style>
