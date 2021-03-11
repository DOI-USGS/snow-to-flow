<template>
  <!---VizSection-->
  <VizSection id="firstSection">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>But warmer winters mean less snow and earlier melt, which means low spring flows.</h2>
    </template>
    <template v-slot:aboveExplanation>
      <p>Stuff to explain.</p>
    </template>
    <!-- FIGURES -->
    <template v-slot:figures>
      <div class="group two maxWidth diagram">
        <figure id="bad-snow">
          <img 
            id="diagram-bad-winter"
            v-img:group-bad
            src="@/assets/diagrams/Diagrams_snow-bad.png"
            alt="A diagram of a mountain hillside in a low-snow winter, where there's not much snowpack and warm weather is melting the snow intermittently."
            loading="lazy"
          >
        </figure>
        <figure id="bad-flow">
          <img 
            id="diagram-bad-spring"
            v-img:group-design
            src="@/assets/diagrams/Diagrams_flow-bad.png"
            alt="A diagram of a mountain hillside in spring after a low-snow winter, where there is little snow left and little water in streams."
            loading="lazy"
          >
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
    <template v-slot:belowExplanation>
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
.diagram figure img { 
    width: 100%;
  }
</style>