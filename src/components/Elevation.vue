<template>
  <!---VizSection-->
  <VizSection id="firstSection">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>Snow persistence predicts streamflow</h2>
    </template>
    <!-- FIGURES -->
    <template v-slot:figures>
      <div class="group maxWidth center">
        <figure class="elevation">
          <img src="@/assets/maps/rayrender.png">
        </figure>
        <!--       <figure>Figure 6</figure>
        <figure>Figure 7</figure>
        <figure>Figure 8</figure> -->
      </div>
    </template>
    <!-- FIGURE CAPTION -->
    <template v-slot:figureCaption>
      <p>
        Mountains act as "water towers" and play a critical role in water storage in the western U.S. At high elevations, snow persistence - the amount of time snow remains on the ground - snowmelt occurs later and acts like a reservoir, whereas at lower elevations with low snow persistence sthe translation of snow to flow occurs earlier and is more readily available to streams. With changing climates, changes in snow persistence can have implciations for the amount of water stored in these high elevation "water towers".  
      </p>
    </template>
    <!-- EXPLANATION -->
    <template v-slot:explanation>
      <p />
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
<style lang="scss" scoped>
.elevation{
  max-width: 730px;
}
</style>