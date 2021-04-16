<template>
  <!---VizSection-->
  <VizSection id="swe-line-chart">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>Peak SWE and snowmelt timing</h2>
    </template>
    <!-- FIGURES -->
    <template v-slot:aboveExplanation>
      <p>
        The snowpack at the Upper Colorado Basin shows a significant difference in snowpack from the winter of 2011 - a big year for snow.  However, 2012 was a very low snow year, with some early intermittent melting.
      </p>
    </template>
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
        Water years 2011 (high snow) and 2012 (low snow) comparing snow (as SWE) and flow (as discharge, mm per day).  SWE measurements are from the <a
          href="https://wcc.sc.egov.usda.gov/nwcc/site?sitenum=1031"
          target="_blank"
        >Never Summer SNOTEL Site 1031</a> and discharge measurements are from <a
          href="https://waterdata.usgs.gov/monitoring-location/06614800/#parameterCode=00065&period=P7D"
          targe="_blank"
        >USGS streamgage 06614800</a> on the Michigan River near Cameron Pass, CO.
      </p>
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
    width: 90vw;
    max-width: 1100px;
    height: auto;
    margin: auto;
  }
</style>