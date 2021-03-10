<template>
  <!---VizSection-->
  <VizSection id="firstSection">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>Snowpack is measured as "snow-water equivalent" or SWE</h2>
    </template>
    <!-- FIGURES -->
    
    <template v-slot:figures>
      <div class="group single maxWidth">
        <figure id="swe-chart-container">
          <!-- <img src="@/assets/diagrams/SWE-sketch.png"> -->
          <LineChart />
        </figure>
      </div>
    </template>
    <!-- FIGURE CAPTION -->
    <template v-slot:figureCaption>
      <p>
        The snow-water equivalent (SWE) include both snow depth and snow density to approximate the amount of water stored in snowpack. 
        
        While peak SWE gives us a snapshot of interannual variation in snow, intra-annual variation in the timing and magnitude is much more complex.
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
import LineChart from '@/components/LineChart';
import * as d3 from 'd3';

export default {
    name: "SWE",
    components:{
        VizSection,
        LineChart
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