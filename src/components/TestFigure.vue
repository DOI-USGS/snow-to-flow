<template>
  <!---VizSection-->
  <VizSection id="firstSection">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h1>Take Away Title</h1>
    </template>
    <!-- FIGURES -->
    <template v-slot:figures>
      <div class="single maxWidth">
        <figure>Large Figure 1</figure>
      </div>
      <div class="group three">
        <figure>Figure 1</figure>
        <figure>Figure 2</figure>
        <figure>Figure 3</figure>
        <figure>Figure 4</figure>
      </div>
      <div class="group two maxWidth">
        <figure>Figure 5</figure>
        <figure>Figure 6</figure>
        <figure>Figure 7</figure>
        <figure>Figure 8</figure>
      </div>
      <div class="single">
        <figure>Large Figure 2</figure>
      </div>
    </template>
    <!-- FIGURE CAPTION -->
    <template v-slot:figureCaption>
      <p>
        Figure 1. Mean weight of two species of ground squirrels prior to and following hibernation
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
    name: "Test",
    components:{
        VizSection
    }
}
</script>
<style lang="sass" scoped>

</style>