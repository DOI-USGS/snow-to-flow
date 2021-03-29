<template>
  <!---VizSection-->
  <VizSection id="swe-line-chart">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>Each year, scientists find relationships between a snowpack curve and discharge at a streamgage downstream.</h2>
    </template>
    <!-- FIGURES -->
    <template v-slot:aboveExplanation>
      <p>Hydrologists measure snowpack as the snow water equivalent, or the amount of liquid water contained in snowpack. That measurement normalizes between light, fluffy snow and heavy, wet snow – to the total amount of water. </p>
      <p>To understand how snow becomes flow we can look use streamflow measurements from the USGS streamgaging network. Some of the oldest (100-125 year old) gages derive their flow from seasonal snow, contributing to a long record of data. Read more about the <a
          href="https://labs.waterdata.usgs.gov/visualizations/gages-through-the-ages/index.html#/"
          target="_blank"
        >history of streamgaging</a></p>
      <Sidebar>
        <template v-slot:sidebarTitle>
          What is SWE?
        </template>
        <template v-slot:sidebarMessage>
          <p>Pork tenderloin turducken, tri-tip ribeye shoulder pancetta. T-bone kevin porchetta, shoulder sirloin boudin spare ribs filet mignon bresaola chicken corned beef frankfurter biltong. Jerky brisket pig, meatball beef flank bresaola landjaeger. Tenderloin beef pork loin andouille flank t-bone tri-tip chislic porchetta. Pork loin frankfurter spare ribs chuck short ribs.</p>
        </template>
      </Sidebar>
      <Sidebar>
        <template v-slot:sidebarTitle>
          What is Discharge?
        </template>
        <template v-slot:sidebarMessage>
          <p>Pork tenderloin turducken, tri-tip ribeye shoulder pancetta. T-bone kevin porchetta, shoulder sirloin boudin spare ribs filet mignon bresaola chicken corned beef frankfurter biltong. Jerky brisket pig, meatball beef flank bresaola landjaeger. Tenderloin beef pork loin andouille flank t-bone tri-tip chislic porchetta. Pork loin frankfurter spare ribs chuck short ribs.</p>
        </template>
      </Sidebar>
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
        The snowpack at the <a
          href="https://wcc.sc.egov.usda.gov/nwcc/site?sitenum=838"
          target="_blank"
        >University Camp SNOTEL Site 838</a> in Boulder Colorado shows a significant difference in snowpack from the winter of 2011 - a big year for snow.  2012 however was a very low snow year, with some early intermittent melting.
        While peak SWE gives us a snapshot of interannual variation in snow, intra-annual variation in the timing and magnitude is much more complex.
      </p>
    </template>
    <!-- EXPLANATION -->
    <template v-slot:belowExplanation>
      <p>Peak SWE and SM50 measure  the magnitude and timing of snowmelt, respectively. Peak snow water equivalent is the maximum daily snow water equivalent for the year, corresponding to the day when the greatest amount of water was contained in the snowpack. The date at which half of the year’s peak SWE has melted, provides a measure of the timing of snowmelt that can be compared across years or sites.</p>
    </template>
  </VizSection>
</template>

<script>
import VizSection from '@/components/VizSection';
import LineChart from '@/components/LineChart';
import Sidebar from '@/components/Sidebar';
import * as d3 from 'd3';

export default {
    name: "SWE",
    components:{
        VizSection,
        LineChart,
        Sidebar
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