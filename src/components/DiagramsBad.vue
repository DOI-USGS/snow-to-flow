<template>
  <!---VizSection-->
  <VizSection id="firstSection">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>But warmer winters mean less snow and earlier melt, which means low spring flows.</h2>
    </template>
    <!-- FIGURES -->
    <template v-slot:figures>
      <div class="group two maxWidth">
        <figure id="fire-before">
          <img src="@/assets/diagrams/Diagrams_snow-bad.png">
        </figure>
        <figure id="fire-after">
          <img src="@/assets/diagrams/Diagrams_flow-bad.png">
        </figure>
      </div>
    </template>
    <!-- FIGURE CAPTION -->
    <template v-slot:figureCaption>
      <p>
      With global changes in precipitation and temperature, snowmelt and sublimintation can occur at accelerated rates leading to lower levels of streamflow.
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
export default {
    name: "DiagramsBad",
    components:{
        VizSection
    }
}
</script>
<style lang="scss" scoped>

</style>