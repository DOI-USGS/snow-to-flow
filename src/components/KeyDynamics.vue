<template>
  <!---VizSection-->
  <VizSection id="diagrams-normal">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>Key Dynamics</h2>
    </template>
    <template v-slot:aboveExplanation>
      <p>For people and ecosystems in the western U.S., most of the water that will be available for the entire year will be generated in the spring melt. There are few important dynamics that largely determine how much snow turns into flow:</p>
      <Sidebar>
        <template v-slot:sidebarTitle>
          Snow Water Equivalent
        </template>
        <template v-slot:sidebarMessage>
          <p><span class="emph">Snow water equivalent</span> is a measure of how much snow there is by calculating the amount of liquid water contained in snowpack. That measurement normalizes between light, fluffy snow and heavy, wet snow, all of which melts down to the same thing - liquid water.</p>
          <p>Intuitively, more snow means more meltwater in the spring.</p>
          <p>Units are <span class="emph">inches (in).</span></p>
        </template>
      </Sidebar>
      <Sidebar>
        <template v-slot:sidebarTitle>
          Melt Timing
        </template>
        <template v-slot:sidebarMessage>
          <p><span class="emph">Timing</span> is a measure of when the snow begins to melt, marked by the date that the location stops accumulating SWE and begins losing it instead.</p>
          <p>An melt earlier timing usually means that there's less SWE accumulated overall.  It also means that the melt will happen slowly.</p>
          <p>Units are in <span class="emph">days since beginning of year</span></p>
        </template>
      </Sidebar>
      <Sidebar>
        <template v-slot:sidebarTitle>
          Melt Duration
        </template>
        <template v-slot:sidebarMessage>
          <p><span class="emph">Duration</span> is a measure of how long it takes for all the snow to melt, measured from peak SWE to zero SWE.</p>
          <p>A slow melt means a slow trickle of meltwater. A rapid melt means a big rush of streamflow that can be captured for water use.</p>
          <p>Units are in <span class="emph">days since beginning of year</span></p>
        </template>
      </Sidebar>
      <p>Two more dynamics impact how much of that meltwater actually becomes available for humans and ecosystems to use:</p>
      <Sidebar>
        <template v-slot:sidebarTitle>
          Soil Saturation
        </template>
        <template v-slot:sidebarMessage>
          <p><span class="emph">Soil saturation</span> is a measure of how dry the soil is.  It depends on whether it was wet or dry the year before, and sets the stage for the coming melt season.</p>
          <!-- <p>Units are <span class="emph">UNITS</span></p> -->
        </template>
      </Sidebar>
      <Sidebar>
        <template v-slot:sidebarTitle>
          Flow
        </template>
        <template v-slot:sidebarMessage>
          <p><span class="emph">Flow</span> is a measurement of stream discharge, or how much water is flowing in a stream.  Streamflow can be captured downstream in water intakes or reservoirs and directly contributes to water availability.</p>
          <p>Units are <span class="emph">cubic feet per second (cfs)</span></p>
        </template>
      </Sidebar>
    </template>
    <!-- FIGURES -->
    <template v-slot:figures>
      <p class="hide" />
    </template>
    <!-- FIGURE CAPTION -->
    <template v-slot:figureCaption>
      <p class="hide" />
    </template>
    <!-- EXPLANATION -->
    <template v-slot:belowExplanation>
      <p class="hide" />
    </template>
  </VizSection>
</template>
<script>
import VizSection from '@/components/VizSection';
import Sidebar from '@/components/Sidebar';
// import Fig from '@/components/Figure';

export default {
    name: "KeyDynamics",
    components:{
        VizSection,
    
        Sidebar
    }
}
</script>
<style lang="scss" scoped>

    .hide {
        display: none;
        margin: 0;
    }
</style>