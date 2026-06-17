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

<script setup>
  import VizSection from '@/components/VizSection.vue';
  import DiagramCarouselNormal from '@/components/DiagramCarouselNormal.vue';
</script>

<style lang="scss" scoped>
</style>
