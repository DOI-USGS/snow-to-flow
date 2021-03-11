<template>
  <!---VizSection-->
  <VizSection id="firstSection">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>What is "SWE"</h2>
    </template>
    <!-- FIGURES -->
    <template v-slot:aboveExplanation>
      <p>Hydrologists measure snowpack as the <span class="italics">snow water equivalent</span>.  That measurement normalizes between light, fluffy snow and heavy, wet snow - ultimately because it will all melt into water anyway.  The USGS wants to know - how much water is contained in this snowpack?</p>
      <p>Cheese strings cheese and biscuits bavarian bergkase. Halloumi queso when the cheese comes out everybody's happy ricotta babybel cream cheese port-salut boursin. Fromage cow when the cheese comes out everybody's happy hard cheese blue castello stilton mozzarella dolcelatte. Melted cheese croque monsieur smelly cheese swiss blue castello gouda halloumi paneer. Airedale everyone loves.</p>
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
        The snowpack at SNOTEL Site 838 in (Location) shows a significant difference in snowpack from the winter of 2011 - a big year for snow.  2012 however was a very low snow year, with some early intermittent melting.
        While peak SWE gives us a snapshot of interannual variation in snow, intra-annual variation in the timing and magnitude is much more complex.
      </p>
    </template>
    <!-- EXPLANATION -->
    <template v-slot:belowExplanation>
      <p>April 1st is here, but there are other ways to assess these snowpack accumulation curves. We can ask - when was peak snowpack? Earlier or later than the traditional April 1st?</p>
      <p>Or - how big was the peak? Did all the snow accumulate and stay there? Or did it intermittently melt during some early warmer days?</p>
      <p>Dolcelatte pepper jack goat. Melted cheese parmesan danish fontina swiss monterey jack babybel stinking bishop caerphilly. Mascarpone halloumi danish fontina everyone loves feta cut the cheese cheese triangles chalk and cheese. Ricotta cheddar cheese strings cottage cheese cheeseburger halloumi mascarpone say cheese. Macaroni cheese cheese strings smelly cheese cut the cheese.</p>
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