<template>
  <!---VizSection-->
  <VizSection id="diagrams-normal">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>A typical year</h2>
    </template>
    <template v-slot:aboveExplanation>
      <p>Studying these snowmelt dynamics is critical to understanding how water moves through the watershed, contributes to streamflow, and ultimately becomes available for use.</p>
 
    </template>
    <!-- FIGURES -->
    <template v-slot:figures>
      <DiagramCarouselNormal />
    </template>
    <!-- FIGURE CAPTION -->
    <template v-slot:figureCaption>
      <p>
        Click each diagram to enlarge it and learn more.
      </p>
    </template>
    <!-- EXPLANATION -->
    <template v-slot:belowExplanation>
      <p>
        But there's lots of variability from year to year, even in a single place. Changes in these dynamics deeply impacts water availability.
      </p>
    </template>
  </VizSection>
</template>
<script>
import VizSection from '@/components/VizSection';
// import Sidebar from '@/components/Sidebar';
import DiagramCarouselNormal from '@/components/DiagramCarouselNormal';
export default {
    name: "DiagramsNormal",
    components:{
        VizSection,
        // Sidebar,
        DiagramCarouselNormal
    }
}
</script>
<style lang="scss" scoped>


</style>
