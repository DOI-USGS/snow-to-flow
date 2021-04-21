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
        The snowpack at the University Camp SNOTEL Site 838 in near Boulder, Colorado shows a significant difference in snowpack from the winter of 2011 to 2012. The winter of 2011 experienced a large snowpack and subsequent spring melt. However, 2012 was a very low snow year, with some early intermittent melting and small spring melt.
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
        Water years 2011 (high snow) and 2012 (low snow) comparing snow (as SWE) and flow (as discharge, mm per day). SWE measurements are from the <a
          href="https://wcc.sc.egov.usda.gov/nwcc/site?sitenum=1031"
          target="_blank"
        >Never Summer SNOTEL Site 1031</a> and discharge measurements are from <a
          href="https://waterdata.usgs.gov/monitoring-location/06614800/#parameterCode=00065&period=P7D"
          targe="_blank"
        >USGS streamgage 06614800</a> on the Michigan River near Cameron Pass, CO.
      </p>
    </template>
          <Sidebar>
        <template v-slot:sidebarTitle>
          What is a "water year"?
        </template>
        <template v-slot:sidebarMessage>
          <p>A water year is the 12-month period from October 1st to September 30th of the following year. Water Year 2021 (WY2021) began on October 1st, 2020 and will end on September 30th, 2021.</p>
          <p>Hydrologists use the concept of a water year because hydrologic activity in the fall and winter sets the stage for the streamflow in the following spring and summer.</p>
        </template>
      </Sidebar>
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