<template>
  <!---VizSection-->
  <VizSection id="firstSection">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>Differences in snow persistence mediate snowmelt</h2>
    </template>
    <!-- FIGURES -->
    <template v-slot:figures>
      <div class="group two maxWidth">
        <figure><img src="@/assets/maps/rayrender.png" />
         </figure>
  <!--       <figure>Figure 6</figure>
        <figure>Figure 7</figure>
        <figure>Figure 8</figure> -->
      </div>

    </template>
    <!-- FIGURE CAPTION -->
    <template v-slot:figureCaption>
      <p>
        Figure. 3d model of elevational range in study in Upper Colorado showing gage locations, and corresponding data with the interaction of snow persistence and discharge. In this section we highlight the work being done in the Upper Colorado to expand the SNOTEL network.
      </p>
    </template>
    <!-- EXPLANATION -->
    <template v-slot:explanation>
      <p></p>
    </template>
  </VizSection>
</template>
<script>
import VizSection from '@/components/VizSection';
export default {
    name: "Elevation",
    components:{
        VizSection
    }
}
</script>
<style lang="sass" scoped>

</style>