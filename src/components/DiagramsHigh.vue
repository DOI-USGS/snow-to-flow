<template>
  <!---VizSection-->
  <VizSection id="diagrams-high">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>High Snow + Late Melt = Lots of Flow</h2>
    </template>
    <template v-slot:aboveExplanation>
      <p>
        Scientists have observed that in years with lots of water availability, the snow dynamics line up to produce a huge surge of flow during the spring melt.
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