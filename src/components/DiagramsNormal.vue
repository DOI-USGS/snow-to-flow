<template>
  <!---VizSection-->
  <VizSection id="diagrams-normal">
    <!-- TAKEAWAY TITLE -->
    <template #takeAway>
      <h2>A typical year</h2>
    </template>
    <template #aboveExplanation>
      <p>Studying these snowmelt dynamics is critical to understanding how water moves through the watershed, contributes to streamflow, and ultimately becomes available for use.</p>
    </template>
    <!-- FIGURES -->
    <template #figures>
      <DiagramCarouselNormal />
    </template>
    <!-- FIGURE CAPTION -->
    <template #figureCaption>
      <p>
        Click to enlarge.
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
