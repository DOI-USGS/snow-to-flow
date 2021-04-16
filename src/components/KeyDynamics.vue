<template>
  <!---VizSection-->
  <VizSection
    id="diagrams-normal"
    :take-away="false"
  >
    <template v-slot:aboveExplanation>
      <p>Spring snowmelt affects water availability and streamflow for the rest of the year. Consider the following dynamics that are critical to understanding how water moves through the watershed, contributes to streamflow, and ultimately becomes available for use:</p>
      <Sidebar>
        <template v-slot:sidebarTitle>
          Soil Saturation
        </template>
        <template v-slot:sidebarMessage>
          <p><span class="emph">Soil saturation</span> is a measure of how dry the soil is.  It depends on whether it was wet or dry the year before, and sets the stage for the next snow and melt season. This measurement ranges from 0 to 1.</p>
          <!-- <p>Units are <span class="emph">UNITS</span></p> -->
        </template>
      </Sidebar>
      <Sidebar>
        <template v-slot:sidebarTitle>
          Snow Water Equivalent (SWE)
        </template>
        <template v-slot:sidebarMessage>
          <p><span class="emph">Snow water equivalent</span> is a measure of the liquid water contained in snowpack.  It is more useful than snow depth for estimate the volume of meltwater flow.  This is because 3 feet of fresh, dry, fluffy snow may represent only 4-5 inches of SWE, but 3 feet of compacted, wet, spring snow may contain 12 inches or more of SWE.  Using SWE helps scientists measure snowpack in a standardized way.</p>
          <p>Units are <span class="emph">inches (in).</span></p>
        </template>
      </Sidebar>
      <Sidebar>
        <template v-slot:sidebarTitle>
          Melt Timing (SM50)
        </template>
        <template v-slot:sidebarMessage>
          <p><span class="emph">Timing</span> is a measure of when snowmelt is happening, marked by the date at which the maximum SWE accumulated during the winter is half gone<sup>7</sup>.</p>
          <p>A late melt timing often means that there has been a long winter during which SWE can accumulate, and that the snow will melt all at once. An early melt timing often means that it was a short winter, and that snow will melt gradually.</p>
          <p>Units are in <span class="emph">days since October 1</span>, which is the beginning of the water year.</p>
        </template>
      </Sidebar>
      <Sidebar>
        <template v-slot:sidebarTitle>
          Flow
        </template>
        <template v-slot:sidebarMessage>
          <p><span class="emph">Flow</span> is a measurement of stream discharge, i.e. how much water is flowing in a stream.  Streamflow can be captured downstream in water intakes or reservoirs and directly contributes to water availability.</p>
          <p>Units are <span class="emph">cubic feet per second (cfs)</span> or <span class="emph">millimeters per day (mm/d).</span></p>
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