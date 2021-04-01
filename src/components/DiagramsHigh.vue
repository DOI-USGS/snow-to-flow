<template>
  <!---VizSection-->
  <VizSection id="diagrams-high">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>High Snow + Late Melt = Lots of Flow</h2>
    </template>
    <template v-slot:aboveExplanation>
      <p>
        In a high snow year, lots of snow accumulates and stays frozen late into the spring.  The later the peak snowpack day occurs, the more likely it is that the snow will melt all at once in a rapid surge.  Even dry soils aren’t able to absorb all the meltwater, and a huge among of water becomes available downstream, sometimes so much so that there’s downstream flooding.  
      </p>
    </template>
    <!-- FIGURES -->
    <template v-slot:figures>
      <DiagramCarouselHigh />
    </template>
    <!-- FIGURE CAPTION -->
    <template v-slot:figureCaption>
      <p>
        Click to enlarge. Typical snow accumulation during winter months forms snowpack, which acts as water storage until warmer temperatures in the spring and summer months lead to snowmeltand ultimately streamflow that flow through the landscape.
      </p>
    </template>
    <!-- EXPLANATION -->
    <template v-slot:belowExplanation>
      <p />
    </template>
  </VizSection>
</template>
<script>
import VizSection from '@/components/VizSection';
import DiagramCarouselHigh from '@/components/DiagramCarouselHigh';
// import Fig from '@/components/Figure';

export default {
    name: "DiagramsHigh",
    components:{
        VizSection,
        DiagramCarouselHigh
    }
}
</script>
<style lang="scss" scoped>


</style>