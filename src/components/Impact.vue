<template>
  <!---VizSection-->
  <VizSection
    id="impact"
    :figures="false"
    :fig-caption="false"
  >
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>Changing snow in the west can have enormous impacts on water availability.</h2>
    </template>
    <!-- FIGURES -->
    <template v-slot:aboveExplanation>
      <p>Reiterate why this matters.</p>
      <p>The USGS is doing lots of research to track changing snow patterns across the country.</p> 
    </template>
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