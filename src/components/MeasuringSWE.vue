<template>
  <!---VizSection-->
  <VizSection
    id="measuring-swe"
    :take-away="false"
  >
    <template v-slot:aboveExplanation>
      <p>Using high-quality manual and station observations of snowpack and streamflow, USGS scientists have conducted important studies on trends in snow chemistry, snowfall, snow cover, snow versus rain, snow water equivalent, snowmelt runoff , and snowmelt timing in the U.S. USGS science has also evaluated the influence of changing climate on hydrological processes and runoff in snowmelt dominated basins.</p>
      <p>Hydrologists measure snowpack as the <span class="emph">snow-water equivalent</span> or SWE, which is the amount of liquid water contained in snowpack. That measurement normalizes between light, fluffy snow and heavy, wet snow, all of which melts down to the same thing - liquid water. The <a href="https://www.nrcs.usda.gov/wps/portal/nrcs/site/national/home/" target="_blank">Natural Resources Conservation Service (NRCS)</a> operates a snow monitoring program that includes manual snow course measurements as well as over 800 automated <a href="https://www.wcc.nrcs.usda.gov/snow/" target="_blank">Snow Telemetry (SNOTEL)</a>  data collection sites that monitor SWE, snow depth, precipitation, temperature, and other climatic conditions.</p>
      <p>
        To understand how snow becomes flow we can use streamflow measurements from the <a href="https://labs.waterdata.usgs.gov/visualizations/gages-through-the-ages/index.html#/" target="_blank">USGS streamgaging network</a>. Some of the oldest (100-125 year old) gages derive their flow from seasonal snow, contributing to a long record of data.
      </p>
    </template>
    <!-- FIGURES -->
    <template v-slot:figures>
      <div class="group single maxWidth">
        <figure id="swe-chart-container">
          <!-- <img src="@/assets/diagrams/SWE-sketch.png"> -->
          <ImgCarousel />
        </figure>
      </div>
    </template>
    <!-- FIGURE CAPTION -->
    <template v-slot:figureCaption>
      <p>
        There are lots of ways to measure SWE! Click on any of the images to learn more.
      </p>
    </template>
    <!-- EXPLANATION -->
    <template v-slot:belowExplanation>
      <p />
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