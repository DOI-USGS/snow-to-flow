<template>
  <!---VizSection-->
  <VizSection id="impact">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>Changing snow in the west can have enormous impacts on water availability.</h2>
    </template>
    <!-- FIGURES -->
    <template v-slot:aboveExplanation>
      <p>Reiterate why this matters.</p>
      <p>The USGS is doing lots of research to track changing snow patterns across the country.</p> 
    </template>
    <!-- <template v-slot:figures>
      <div class="single maxWidth">
        <figure id="swe-chart-container">
          <img 
            v-img:final
            src="@/assets/images/rio_peak.png"
            alt="A placeholder diagram"
            loading="lazy"
          >
        </figure>
        <figure id="swe-chart-container">
          <img 
            v-img:final
            src="@/assets/images/rio_sm50.png"
            alt="A placeholder diagram"
            loading="lazy"
          >
        </figure>

        <figure id="change">
          <img 
            v-img:final
            src="@/assets/images/rio_change.png"
            alt="A placeholder diagram"
            loading="lazy"
          >
        </figure>
      </div>
    </template> -->
    <!-- FIGURE CAPTION -->
    <!-- <template v-slot:figureCaption>
      <p>
        Cottage cheese mascarpone cut the cheese. Cheeseburger cauliflower cheese babybel cheese slices camembert de normandie stinking bishop chalk and cheese cottage cheese. Who moved my cheese edam chalk and cheese croque monsieur hard cheese macaroni cheese monterey jack cheddar.
      </p>
    </template> -->
    <!-- EXPLANATION -->
    <template v-slot:belowExplanation>
      <p>Check back in with the snow hydrology group and usgs vizlab this summer when we look back at what the water availability driven by today's snowpack looks like over the spring and summer.</p>
    </template>
  </VizSection>
</template>

<script>
import VizSection from '@/components/VizSection';

export default {
    name: "Impact",
    components:{
        VizSection
    },
    data() {
      return {
         publicPath: process.env.BASE_URL
      }      
    },
    mounted() {
      
    },
    methods: {
      
    }
}
</script>

<style lang="scss" scoped>
#change {
  max-width: 500px;
 margin:auto;
}
.maxWidth {
  max-width: 70vw;
}
</style>