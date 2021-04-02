<template>
  <!---VizSection-->
  <VizSection id="diagrams-normal">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>From Winter Snow to Spring Flow</h2>
    </template>
    <template v-slot:aboveExplanation>
      <p>For people and ecosystems in the western U.S., most of the water that will be available for the entire year will be generated in the spring melt. There are few important dynamics that largely determine how much snow turns into flow:</p>
      <ul>
        <li><span class="emph">Snowpack Thickness</span> ie, how much snow there is,</li>
        <li><span class="emph">Melt Timing</span> ie, when the snow begins to melt,</li>
        <li><span class="emph">Melt Duration</span> ie, how long it takes to all melt.</li>
      </ul>
      <p>Two more dynamics impact how much of that meltwater actually becomes available for humans and ecosystems to use:</p>
      <ul>
        <li><span class="emph">Soil Saturation</span> ie, how much the soil soaks up meltwater, </li>
        <li><span class="emph">Flow</span> ie, much meltwater is left for streams and reservoirs.</li>
      </ul>
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
// import Fig from '@/components/Figure';

export default {
    name: "DiagramsNormal",
    components:{
        VizSection,
        DiagramCarouselNormal
    }
}
</script>
<style lang="scss" scoped>


</style>