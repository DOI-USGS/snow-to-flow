<template>
  <!---VizSection-->
  <VizSection id="diagrams-high">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>High Snow + Late Melt = Lots of Flow</h2>
    </template>
    <template v-slot:aboveExplanation>
      <p>In a year with lots of snow accumulation and a cold spring where the snowpack persists longer, snowmelt occurs late and the melt rate is rapid. This can result in greater annual water availability.</p>
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
      <DiagramCarouselHigh />
    </template>
    <!-- FIGURE CAPTION -->
    <template v-slot:figureCaption>
      <p>
        Click to enlarge. Typical snow accumulation during winter months forms snowpack, which acts as water storage until warmer temperatures in the spring and summer months lead to snowmeltand ultimately streamflow that flow through the landscape.
      </p>
    </template>
    <!-- EXPLANATION -->
    <template v-slot:belowExplanation>
      <p></p>
    </template>
  </VizSection>
</template>
<script>
import VizSection from '@/components/VizSection';
import DiagramCarouselHigh from '@/components/DiagramCarouselHigh';
// import Fig from '@/components/Figure';

export default {
    name: "DiagramsHigh",
    components:{
        VizSection,
        DiagramCarouselHigh
    }
}
</script>
<style lang="scss" scoped>


</style>