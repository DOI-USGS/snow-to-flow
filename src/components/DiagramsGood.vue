<template>
  <!---VizSection-->
  <VizSection id="firstSection">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>A Good Snow Year</h2>
    </template>
    <template v-slot:aboveExplanation>
      <p>In a good snow year, there's lots of snow and it doesn't melt at all until the spring when it melts all at once.</p>
    </template>
    <!-- FIGURES -->
    <template v-slot:figures>
      <div class="group two maxWidth">
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
      </div>
    </template>
    <!-- FIGURE CAPTION -->
    <template v-slot:figureCaption>
      <p>
        Typical snow accumulation during winter months forms snowpack, which acts as water storage until warmer temperatures in the spring and summer months lead to snowmeltand ultimately streamflow that flow through the landscape.
      </p>
    </template>
    <!-- EXPLANATION -->
    <template v-slot:belowExplanation>
      <p>Goat fondue cheese and wine. Caerphilly feta goat cheese triangles taleggio ricotta queso caerphilly. Jarlsberg say cheese boursin monterey jack cauliflower cheese blue castello roquefort chalk and cheese. Brie dolcelatte bavarian bergkase chalk and cheese cottage cheese port-salut cottage cheese lancashire. Pepper jack swiss.</p>
    </template>
  </VizSection>
</template>
<script>
import VizSection from '@/components/VizSection';
import Fig from '@/components/Figure';

export default {
    name: "DiagramsGood",
    components:{
        VizSection
    }
}
</script>
<style lang="scss" scoped>


</style>