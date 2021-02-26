<template>
  <!---VizSection-->
  <VizSection id="firstSection">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>Timing and Magnitude of Peak SWE help cue scientists as to whether it's a "good" or "bad" snow year.</h2>
    </template>
    <!-- FIGURES -->
    <template v-slot:figures>
      <div class="group single maxWidth">
        <figure id="swe-chart-container">
          <!-- <img src="@/assets/diagrams/SWE-sketch.png"> -->
          <svg
            id="swe-chart"
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 750 400"
          >   
            <g
              id="group">
            </g>           
          </svg>
        </figure>
      </div>
    </template>
    <!-- FIGURE CAPTION -->
    <template v-slot:figureCaption>
      <p>
        Figs. Wildfires affect the timing and magnitude of runoff and groundwater recharge.
      </p>
    </template>
    <!-- EXPLANATION -->
    <template v-slot:explanation>
      <p>Stuff to explain.</p>
    </template>
  </VizSection>
</template>

<script>
import VizSection from '@/components/VizSection';
import * as d3 from 'd3';

export default {
    name: "SWE",
    components:{
        VizSection
    },
    data() {
      return {
         publicPath: process.env.BASE_URL,
         message: "hey"
      }      
    },
    mounted() {
      
    },
    methods: {
      
    }
}
</script>

<style lang="scss" scoped>
    #swe-chart {
      width: 100%;
      background-color: coral;
    }
</style>