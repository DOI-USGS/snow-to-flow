<template>
  <!---VizSection-->
  <VizSection id="firstSection">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>Thick snowpack lasting long into the spring is good for flow</h2>
    </template>
    <!-- FIGURES -->
    <template v-slot:figures>
      <div class="group two maxWidth">
        <figure id="fire-before">
          <img src="@/assets/diagrams/Diagrams_snow-good.png">
        </figure>
        <figure id="fire-after">
          <img src="@/assets/diagrams/Diagrams_flow-good.png">
        </figure>
      </div>
    </template>
    <!-- FIGURE CAPTION -->
    <template v-slot:figureCaption>
      <p>
        Figs. Wildfires affect the timing and magnitude of runoff and groundwater recharge. We are going to build off these diagrams from the fire page to show specific processes relating to snowmelt.
      </p>
    </template>
    <!-- EXPLANATION -->
    <template v-slot:explanation>
      <p>Stuff to explain.</p>
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
#fire-before {
  max-width:  530px;
}
 #fire-after {
  max-width:  600px;
}

</style>