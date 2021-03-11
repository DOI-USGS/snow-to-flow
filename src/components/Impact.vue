<template>
  <!---VizSection-->
  <VizSection id="firstSection">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>There are enormous impacts of a changing snow pattern.</h2>
    </template>
    <!-- FIGURES -->
    <template v-slot:aboveExplanation>
      <p>Here's all about it. One final diagram to hit home the fact that snowpack is measurably changing  in the places where it matters.</p>
    </template>
    <template v-slot:figures>
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
    </template>
    <!-- FIGURE CAPTION -->
    <template v-slot:figureCaption>
      <p>
        Cottage cheese mascarpone cut the cheese. Cheeseburger cauliflower cheese babybel cheese slices camembert de normandie stinking bishop chalk and cheese cottage cheese. Who moved my cheese edam chalk and cheese croque monsieur hard cheese macaroni cheese monterey jack cheddar.
      </p>
    </template>
    <!-- EXPLANATION -->
    <template v-slot:belowExplanation>
      <p>Reiterate what we said at the very beginning.  April 1st used to mark peak snowpack. But that's changing because of climate change.  And it has lots of impacts on water supply.</p>
      <p>Specifically, a smaller snowpack that melts earlier will mean less water available for supply.  It also means drier soils, and potentially more wildfires. List all the impacts and cite sources that support these claims.</p>
      <p>Halloumi boursin cut the cheese. Who moved my cheese dolcelatte cheesecake squirty cheese babybel fromage everyone loves goat. Airedale cream cheese edam parmesan port-salut manchego stinking bishop stilton. Cut the cheese hard cheese pepper jack swiss brie paneer the big cheese cow. Fondue.</p>
      <h2>Follow the Story</h2>
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
  max-width: 80vw;
}
</style>