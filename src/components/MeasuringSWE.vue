<template>
  <!---VizSection-->
  <VizSection id="firstSection">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>How the USGS Measures Snowpack</h2>
    </template>
    <template v-slot:aboveExplanation>
      <p>Cheese and wine roquefort when the cheese comes out everybody's happy. Cow red leicester the big cheese paneer cut the cheese red leicester boursin halloumi. Cheese and wine cheddar mozzarella boursin mozzarella cheese and wine taleggio cheese slices. Stilton fromage say cheese mozzarella cheeseburger dolcelatte pepper jack manchego. Who moved my cheese feta.</p>
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
      <p>St. agur blue cheese emmental goat. Port-salut babybel cheese strings airedale everyone loves boursin cheesy feet queso. Boursin goat caerphilly st. agur blue cheese squirty cheese rubber cheese cow halloumi. Danish fontina cheese and biscuits say cheese swiss croque monsieur.</p>
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