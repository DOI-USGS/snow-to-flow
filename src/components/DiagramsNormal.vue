<template>
  <!---VizSection-->
  <VizSection id="diagrams-normal">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>From Winter Snow to Spring Flow</h2>
    </template>
    <template v-slot:aboveExplanation>
      <p>Snowpack in high elevation areas functions like frozen water towers by storing water into the spring. When that snow finally melts, these high elevation areas produce a large pulse of meltwater that flows downstream through the landscape.</p>
      <p>For people and ecosystems below, that huge pulse of streamflow is critical for water supply.  Most of the water that will be available for the entire year will be generated in that rush of meltwater.  Therefore, the seasonal dynamics of snowmelt are critical components of the energy balance and water cycle in mountainous areas.</p>
      <p>Factors that impact snowmelt can tell us a lot about the water that will be produced in the spring melt. Three dynamics largely determine how much snow turns into flow:</p>
      <ul>
        <li>How much snow there is (snowpack magnitude)</li>
        <li>When it begins to melt (melt timing), and </li>
        <li>How late into the spring/summer melting lasts (melt duration).</li>
      </ul>
      <p>Two more dynamics impact how much of that meltwater actually becomes available for humans and ecosystems to use:</p>
      <ul>
        <li>How much water the soil absorbs during melting (soil saturation), and </li>
        <li>How much of the remaining water gets carried down by streams into reservoirs below (flow).</li>
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
        Click to enlarge.  Typical snow accumulation during winter months forms snowpack, which acts as water storage until warmer temperatures in the spring and summer months lead to snowmeltand ultimately streamflow that flow through the landscape.
      </p>
    </template>
    <!-- EXPLANATION -->
    <template v-slot:belowExplanation>
      <p>
        It all starts with a baseline of how the previous water year went – the soil saturation depends on whether it was a wet or a dry year.  Then around October, snow begins to accumulate. Snow in high elevations store enormous amounts of water in thick snowpacks.  In normal years, the snow stays frozen all winter leading up to a “peak snowpack” day, historically marked around April 1st.
      </p>
      <p>
        Then, it all begins to melt - slowly at first, and then faster, and then in a huge rush. The soil soaks up some of the meltwater, but not all of it. The rest moves quickly over and through the soil, filling streams with a surge of water that can be captured in reservoirs downstream.
      </p>
      <p>
        There’s lots of variability from year to year, so let’s see how changing snowpack magnitude and melt timing impacts water availability.
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