<template>
  <!---VizSection-->
  <VizSection id="diagrams-normal">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>A Normal Year</h2>
    </template>
    <template v-slot:aboveExplanation>
      <p>Studying these snowmelt dynamics is critical to understanding how water moves through the watershed, contributes to streamflow, and ultimately becomes available for use.</p>
      <p class="italic pseudo-caption">Click each diagram below to see the dynamics at play in the winter, spring, and summer.</p>
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
        The <span class="emph">soil saturation</span> depends on whether it was wet or dry the year before, and sets the stage for the coming melt season.  Around October, snow begins to fall, adding bit by bit to the <span class="emph">snowpack magnitude</span>. Especially in high elevations, snowpacks can be several feet thick and store several inches worth of water.  In the spring - historically around April 1st - the snowpacks reach their peak thickness.  Then it all begins to melt.  The start of <span class="emph">melt timing</span> is marked by that day of peak snowpack, and from that point until all the snow is gone marks the <span class="emph">melt duration</span>.
      </p>
      <p>
        In normal years, most of the meltwater rushes into streams to generate <span class="emph">flow</span> which is the source of water availability. The soil soaks up some of the meltwater, but not all of it. The rest moves quickly over and through the soil, filling streams with a surge of water that can be captured in reservoirs downstream.
      </p>
      <p>
        But there's lots of variability from year to year even in a single place. So let’s see how changing these dynamics impacts water availability.
      </p>
    </template>
  </VizSection>
</template>
<script>
import VizSection from '@/components/VizSection';
import DiagramCarouselNormal from '@/components/DiagramCarouselNormal';
export default {
    name: "DiagramsNormal",
    components:{
        VizSection,
        DiagramCarouselNormal,
    }
}
</script>
<style lang="scss" scoped>


</style>