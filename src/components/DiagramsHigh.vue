<template>
  <!---VizSection-->
  <VizSection id="diagrams-high">
    <!-- TAKEAWAY TITLE -->
    <template #takeAway>
      <h2>High snow + late melt = lots of flow</h2>
    </template>
    <template #aboveExplanation>
      <p>
        High snow conditions are often accompanied by later snowmelt timing because of the high SWE. When high SWE is accompanied by a faster rate of melting over a shorter time period, large streamflow can also occur. This is because as peak snowpack remains frozen later into the year, the more likely it is that the snow will melt all at once when temperatures warm.
      </p>
    </template>
    <!-- FIGURES -->
    <template #figures>
      <CarouselGallery :items="diagrams.high" />
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
