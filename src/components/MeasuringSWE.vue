<template>
  <!---VizSection-->
  <VizSection
    id="measuring-swe"
    :take-away="false"
  >
    <template v-slot:aboveExplanation>
      <p>The USGS has been advancing snow science through both measuring and modeling snowpack, and linking these results to streamflow.  Explain what SNOTEL sites are here, as well as the other field data collection techniques here.</p>
      <p>Measuring - Snow monitoring stations with meteorological data – NGWOS. NRCS and SnoTEL. Remote sensing – snow persistence.</p>
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
        There are lots of ways to measure SWE! Drones, shovels, and SNOTEL sites oh my!
      </p>
    </template>
    <!-- EXPLANATION -->
    <template v-slot:belowExplanation>
      <p>Modeling - The USGS has also been contributing to snow science research through modeling snowpack and snowmelt dynamics from local to National extents. These models use measured data of snow, landscape and vegetation as well as meteorologic variables to understand how snowpack evolves from accumulation through melt, as well as how these changes influence streamflow.</p>
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