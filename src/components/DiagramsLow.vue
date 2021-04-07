<template>
  <!---VizSection-->
  <VizSection id="diagrams-low">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>Low snow + early melting = less flow</h2>
    </template>
    <template v-slot:aboveExplanation>
      <p>
        But in some years, a combination of low SWE accumulation, warmer and earlier spring, and dry soils can lead to a greatly reduced flow and water availability.
      </p>
    </template>
    <!-- FIGURES -->
    <template v-slot:figures>
      <DiagramCarouselLow />
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
        Studying all these dynamics across multiple ecosystems in the west is a huge task, but even that list isn’t complete.  In addition to soil saturation, snowpack thickness, and melt timing, there are lots of other factors that impact how snow turns into flow, such as:  
      </p>
      <Sidebar>
        <template v-slot:sidebarTitle>
          Sublimation
        </template>
        <template v-slot:sidebarMessage>
          <p>
            Some snow never creates meltwater because it evaporates directly back into the atmosphere in a process called <a
              href="https://www.usgs.gov/centers/co-water/science/snowpack-sublimation-measurements-and-modeling-colorado-river-basin?qt-science_center_objects=0#qt-science_center_objects"
              target="_blank"
            >sublimation</a>. The longer snow is exposed to weather that is sunny but still cold, the more snow vaporizes directly back into the atmosphere<sup>11</sup>.
          </p>
        </template>
      </Sidebar>
      <Sidebar>
        <template v-slot:sidebarTitle>
          Warmer Temperatures and Rain
        </template>
        <template v-slot:sidebarMessage>
          <p>Warmer temperatures have an added effect if winter precipitation falls as rain instead of snow. Late-season precipitation that falls as rain on snow also accelerates snowmelt, resulting in rapid snowmelt that can lead to flooding.</p>
        </template>
      </Sidebar>
      <Sidebar>
        <template v-slot:sidebarTitle>
          Permeability
        </template>
        <template v-slot:sidebarMessage>
          <p>Water moves quickly across impermeable surfaces like bedrock or asphalt, into drainages, through streams, and filling reservoirs downstream. Permeable surfaces like soil, gravel, and sand allowing more water to infiltrate into the ground and reach streams more slowly, which also increases soil saturation.</p>
        </template>
      </Sidebar>
      <Sidebar>
        <template v-slot:sidebarTitle>
          Slope Steepness
        </template>
        <template v-slot:sidebarMessage>
          <p>A steep slope is more likely to promote water movement across the surface rather than infiltrating. If snowmelt is slower and over more permeable soils like gravel or sand, more of the liquid water will infiltrate into the subsurface, taking longer for water to reach the stream. Further, a steep slope is more likely to promote water movement across the surface rather than infiltrating.</p>
        </template>
      </Sidebar>
      <Sidebar>
        <template v-slot:sidebarTitle>
          Wind
        </template>
        <template v-slot:sidebarMessage>
          <p>Vegetation and wind patterns matter too. Snow fall can be intercepted by trees and then sublimated, reducing the on the ground total snowpack. Fallen snow can also be blown over ridges, scouring windward rises or trees, and accumulating on the leeward side of the ridge. These spatial differences in snowpack depth can result in different snowmelt timing and rates, in addition to other climatic factors<sup>12</sup>.</p>
        </template>
      </Sidebar>
      <Sidebar>
        <template v-slot:sidebarTitle>
          Vegetation
        </template>
        <template v-slot:sidebarMessage>
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