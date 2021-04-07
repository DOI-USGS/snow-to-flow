<template>
  <!---VizSection-->
  <VizSection id="diagrams-high">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>High snow + late melt = lots of flow</h2>
    </template>
    <template v-slot:aboveExplanation>
      <p>
        High snow conditions are often accompanied by later snowmelt timing and a faster rate of melting over a shorter time period. This is because as peak snowpack remains frozen later into the year, the more likely it is that the snow will melt all at once in a rapid surge.
      </p>
    </template>
    <!-- FIGURES -->
    <template v-slot:figures>
      <DiagramCarouselHigh />
    </template>
    <!-- FIGURE CAPTION -->
    <template v-slot:figureCaption>
      <p>
        Click each diagram to enlarge it and learn more.
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