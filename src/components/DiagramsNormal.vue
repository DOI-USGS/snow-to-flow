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
      <CarouselGallery :items="diagrams.typical" />
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
  import CarouselGallery from '@/components/CarouselGallery.vue';
  import diagrams from '@/assets/text/diagrams.js';
</script>
