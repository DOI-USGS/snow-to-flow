<template>
  <!---VizSection-->
  <VizSection id="diagrams-normal">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>From Winter Snow to Spring Flow</h2>
    </template>
    <template v-slot:aboveExplanation>
      <p>The magnitude of snowpack (how much snow?) and the timing and duration of melt (when does melting start and how long will it last?) determine how much snowmelt water will be available downstream. Estimating these snowmelt dynamics is critical to understanding how this water moves through the water cycle, contributes to streamflow, and ultimately becomes available for use downstream.</p>
      <p>Estimating how much and when snow turns into flow depends on a few dynamics.</p>
    </template>
    <!-- FIGURES -->
    <template v-slot:figures>
      <!-- <div class="group two maxWidth">
        <figure id="good-snow">
          <img 
            id="diagram-good-winter"
            v-img:group-good
            src="@/assets/diagrams/Diagrams_snow-good.png"
            alt="A diagram of a mountain hillside in a high-snow winter, where there's thick snowpack and saturated soils from good snow years previously."
            loading="lazy"
          >
        </figure>
        <figure id="good-flow">
          <img 
            id="diagram-good-spring"
            v-img:group-good
            src="@/assets/diagrams/Diagrams_flow-good.png"
            alt="A diagram of a mountain hillside in spring after a high-snow winter, where the snowpack melts all at once and makes lots of meltwater available for water supply."
            loading="lazy"
          >
        </figure>
      </div> -->
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
      <p>As a snow melts, the rate that liquid water is released from the snow and the type of surface the snowpack has been resting on will contribute to how the water moves into or over the surface. If lots of snow melts quickly on a hard or impermeable surface like bedrock or asphalt, the water will move across the surface and into drainages quickly, filling streams with a rush of water that can be captured in reservoirs downstream. If snowmelt is slower and over more permeable soils like gravel or sand, more of the liquid water will infiltrate into the subsurface, taking longer for water to reach the stream. Further, a steep slope is more likely to promote water movement across the surface rather than infiltrating.</p>
      <p>
        In addition to snowmelt water, snowpacks can also decrease in magnitude by evaporating directly back to the atmosphere, in a process called <a
          href="https://www.usgs.gov/centers/co-water/science/snowpack-sublimation-measurements-and-modeling-colorado-river-basin?qt-science_center_objects=0#qt-science_center_objects"
          target="_blank"
        >sublimation</a>, where solid water is transformed directly to water vapor. The longer snowpacks are exposed to high energy (sunny) but still cold environments, the more sublimation loss occurs. Similarly, the earlier a snowpack melts the more meltwater is used by plants via <a
          href="https://agupubs.onlinelibrary.wiley.com/doi/10.1029/2019WR026634"
          target="_blank"
        >transpiration.</a>
      </p>
      <p>Late-season precipitation that falls as rain on snow also accelerates snowmelt, resulting in rapid snowmelt that can lead to flooding.</p>
      <p>The dynamics of snowmelt not only influence streamflow, but are also both dependent on and influenced by vegetation and wind patterns. Snow fall can be intercepted by trees and then sublimated, reducing the on the ground total snowpack. Fallen snow can also be blown over ridges, scouring windward rises or trees, and accumulating on the leeward side of the ridge. These spatial differences in snowpack depth can result in different snowmelt timing and rates, in addition to other climatic factors.</p>
      <p>
        The distribution of snowmelt water at the ground surface and its path over the surface, or into and through the subsurface, affects the availability of this water to humans and plants. Drier soils can lead to less water for plants, which can set up conditions that increase the risk of <a
          href="https://labs.waterdata.usgs.gov/visualizations/fire-hydro/index.html#/"
          target="_blank"
        >sublimation</a>.
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