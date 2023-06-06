<template>
  <!---VizSection-->
  <VizSection id="diagrams-low">
    <!-- TAKEAWAY TITLE -->
    <template #takeAway>
      <h2>Low snow + early melting = less flow</h2>
    </template>
    <template #aboveExplanation>
      <p>
        In some years, a combination of low SWE accumulation, warmer and earlier spring weather, and dry soils can lead to a greatly reduced streamflow and water availability.
      </p>
    </template>
    <!-- FIGURES -->
    <template #figures>
      <DiagramCarouselLow />
    </template>
    <!-- FIGURE CAPTION -->
    <template #figureCaption>
      <p>
        Click to enlarge.
      </p>
    </template>
    <!-- EXPLANATION -->
    <template #belowExplanation>      
      <p>
        Quantifying snow dynamics across multiple ecosystems in the west is a huge undertaking. In addition to soil saturation, SWE depth, and melt timing, there are numerous other factors that affect how snow turns into streamflow, such as:  
      </p>
      <Sidebar>
        <template #sidebarTitle>
          Sublimation
        </template>
        <template #sidebarMessage>
          <p>
            Some snow evaporates directly back into the atmosphere in a process called <a
              href="https://www.usgs.gov/centers/co-water/science/snowpack-sublimation-measurements-and-modeling-colorado-river-basin?qt-science_center_objects=0#qt-science_center_objects"
              target="_blank"
            >sublimation</a>. Cold sunny weather contributes to the amount of snow vaporized directly back into the atmosphere<sup>11</sup> and higher wind speeds can accelerate sublimation.
          </p>
        </template>
      </Sidebar>
      <Sidebar>
        <template #sidebarTitle>
          Warmer Temperatures and Rain
        </template>
        <template #sidebarMessage>
          <p>Warmer temperatures have an added effect if winter precipitation falls as rain instead of snow. Late-season precipitation that falls as rain on snow also accelerates snowmelt, resulting in rapid snowmelt that can lead to flooding.</p>
        </template>
      </Sidebar>
      <Sidebar>
        <template #sidebarTitle>
          Permeability
        </template>
        <template #sidebarMessage>
          <p>Water moves quickly across impermeable surfaces like bedrock or asphalt, into drainages, through streams, and filling reservoirs downstream. Permeable surfaces like soil, gravel, and sand allow more water to infiltrate into the ground and reach streams more slowly, which increases soil saturation.</p>
        </template>
      </Sidebar>
      <Sidebar>
        <template #sidebarTitle>
          Slope
        </template>
        <template #sidebarMessage>
          <p>A steep slope is more likely to promote water movement across the surface rather than soil infiltration. If snowmelt is slower and over more permeable soils like gravel or sand, more of the water will infiltrate into the subsurface, taking longer for water to reach the stream.</p>
        </template>
      </Sidebar>
      <Sidebar>
        <template #sidebarTitle>
          Wind
        </template>
        <template #sidebarMessage>
          <p>Wind patterns can also affect snow accumulation and melt. Snow fall can be intercepted by trees and then sublimated, reducing the total snow accumulation on the ground. Fallen snow can also be blown over ridges, scouring windward rises or trees and accumulating on the leeward side of the ridge. This spatial variation in snowpack depth can result in different snowmelt timing and rates, in addition to other climatic factors<sup>12</sup>.</p>
        </template>
      </Sidebar>
      <Sidebar>
        <template #sidebarTitle>
          Vegetation
        </template>
        <template #sidebarMessage>
          <p>
            Snow fall can be intercepted by trees and then sublimated, reducing the on the ground total snowpack. Lower, slower, and earlier snowmelt can also mean that more meltwater is lost to plant uptake and soil absorption<sup>10</sup>. Drier soils can lead to less water for plants, which can set up conditions that increase the risk of <a
              href="https://labs.waterdata.usgs.gov/visualizations/fire-hydro/index.html#/"
              target="_blank"
            >wildfire</a>.
          </p>
        </template>
      </Sidebar>
    </template>
  </VizSection>
</template>
<script>
import VizSection from '@/components/VizSection';
import DiagramCarouselLow from '@/components/DiagramCarouselLow';
import Sidebar from '@/components/Sidebar';
export default {
    name: "DiagramsLow",
    components:{
        VizSection,
        DiagramCarouselLow,
        Sidebar
    }
}
</script>
<style lang="scss" scoped>
.diagram figure img { 
    width: 100%;
  }
</style>