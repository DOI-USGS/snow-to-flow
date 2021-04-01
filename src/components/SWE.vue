<template>
  <!---VizSection-->
  <VizSection id="swe-line-chart">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>What does snow and flow data look like?</h2>
    </template>
    <!-- FIGURES -->
    <template v-slot:aboveExplanation>
      <p>
        Peak SWE is an important measurement – it tells us the magnitude of the maximum snowpack that year, as well as the timing of when snow accumulation tips towards snow melt. Peak SWE is the maximum daily snow water equivalent for the year, corresponding to the day when the greatest amount of water was contained in the snowpack.
      </p>
      <p>
        Other points, like the date at which half of the year’s peak SWE has melted (“SM50”), provides a measure of the how quickly snowmelt is happening, which can be compared across years or sites.
      </p>
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
      <p>
        Notice X Y and Z.
      </p>
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
    margin-bottom: 0;
  }
</style>