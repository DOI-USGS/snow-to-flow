<template>
  <!---VizSection-->
  <VizSection
    id="measuring-swe"
    :take-away="false"
  >
    <template v-slot:aboveExplanation>
      <p>Using high-quality manual and station observations of snowpack and streamflow, USGS scientists have conducted important studies on trends in snow chemistry, snowfall, snow cover, snow versus rain, snow water equivalent, snowmelt runoff , and snowmelt timing in the U.S. USGS science has also evaluated the influence of changing climate on hydrological processes and runoff in snowmelt dominated basins.</p>
      <p>Hydrologists measure snowpack as the snow water equivalent (SWE), or the amount of liquid water contained in snowpack. That measurement normalizes between light, fluffy snow and heavy, wet snow – to the total amount of water. The Natural Resources Conservation Service (NRCS) operates a snow monitoring program that includes manual snow course measurements as well as over 800 automated Snow Telemetry (SNOTEL) data collection sites that monitor SWE, snow depth, precipitation, temperature, and other climatic conditions.</p>
      <p>
        To understand how snow becomes flow we can use streamflow measurements from the USGS streamgaging network. Some of the oldest (100-125 year old) gages derive their flow from seasonal snow, contributing to a long record of data. Read more about the <a href="https://labs.waterdata.usgs.gov/visualizations/gages-through-the-ages/index.html#/" target="_blank">history of USGS streamgaging</a>.  
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
      <p>The USGS is undertaking new efforts to advance snow science through both measuring and modeling snowpack and linking these results to streamflow. As a part of the USGS Next Generation Water Observing System (NGWOS) new spatial and temporal snow and streamflow observations in unmonitored environments are being planned.  Those observations will provide valuable data which will inform modeling of water-cycle components in the Upper Colorado River Basin. New snow monitoring will include continuous snowpack and soil moisture stations, remotely sensed mapping of snow conditions, and manual snow surveys.</p>
      <p>
        The USGS has also been contributing to snow science research through modeling snowpack and snowmelt dynamics from local to National extents. These models use measured data of snow, landscape and vegetation as well as meteorologic variables to understand how snowpack evolves from accumulation through melt, as well as how these changes influence streamflow. 
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