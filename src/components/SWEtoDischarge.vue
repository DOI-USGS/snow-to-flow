<template>
  <!---VizSection-->
  <VizSection id="SWEtoDischarge">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>Snow-water equivalent (SWE)</h2>
    </template>
    <!-- FIGURES -->
    <template v-slot:figures>
      <div class="group single maxWidth">
        <figure id="swe-chart-container">
          <!-- <img src="@/assets/diagrams/SWE-sketch.png"> -->
          <LineChartCompare />
        </figure>
      </div>
    </template>
    <!-- FIGURE CAPTION -->
    <template v-slot:figureCaption>
      <p>
        A second line chart using the original SWE line, but adding discharge.
      </p>
    </template>
    <!-- EXPLANATION -->
    <template v-slot:explanation>
      <p>Look! We're layering on information</p>
    </template>
  </VizSection>
</template>

<script>
import VizSection from '@/components/VizSection';
import LineChartCompare from '@/components/LineChartCompare';
import * as d3 from 'd3';

export default {
    name: "SWEtoDischarge",
    components:{
        VizSection,
        LineChartCompare
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