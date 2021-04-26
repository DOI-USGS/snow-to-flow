<template>
  <!---VizSection-->
  <VizSection
    id="diagrams-normal"
    :take-away="false"
  >
    <template v-slot:aboveExplanation>
      <p>Winter snow accumulation as well as spring snowmelt affect streamflow and water availability for the rest of the year. Consider the following dynamics that are critical to understanding how water moves through the watershed, contributes to streamflow, and ultimately becomes available for use:</p>
      <Sidebar>
        <template v-slot:sidebarTitle>
          Soil Saturation
        </template>
        <template v-slot:sidebarMessage>
          <p><span class="emph">Soil saturation</span> saturation is a measure of soil water content and is an indicator of soil moisture. Soil moisture can depend on whether it was wet or dry the year before, and the level of soil moisture at the onset of snowmelt can affect infiltration and runoff for the next snow and melt season.</p>
          <!-- <p>Units are <span class="emph">UNITS</span></p> -->
        </template>
      </Sidebar>
      <Sidebar>
        <template v-slot:sidebarTitle>
          Snow Water Equivalent (SWE)
        </template>
        <template v-slot:sidebarMessage>
          <p><span class="emph">Snow water equivalent</span> is a measure of the liquid water contained in snowpack.  It is more useful than snow depth for estimate the volume of meltwater flow.  This is because 3 feet of fresh, dry, fluffy snow may represent only 4-5 inches of SWE, but 3 feet of compacted, wet, spring snow may contain 12 inches or more of SWE.  Using SWE helps scientists measure snowpack in a standardized way. Units are inches (in).</p>
        </template>
      </Sidebar>
      <Sidebar>
        <template v-slot:sidebarTitle>
          Melt Timing (SM50)
        </template>
        <template v-slot:sidebarMessage>
          <p>
            <span class="emph">Melt timing</span> is a measure of how when snowmelt occurs, and is marked by the date at which the maximum SWE accumulated during the winter is half gone<sup>7</sup>.
            Melt timing is measured as days since October 1st (beginning of the water year) at which one-half of the annual maximum SWE has melted.
          </p>
        </template>
      </Sidebar>
      <Sidebar>
        <template v-slot:sidebarTitle>
          Streamflow
        </template>
        <template v-slot:sidebarMessage>
          <p><span class="emph">Streamflow</span> is the volume of water moving down a stream or river. Streamflow can be captured downstream via water intakes or reservoirs and directly contributes to water availability. Units are in millimeters per day (mmd) or cubic feet per second (cfs).</p>
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
