<template>
  <!---VizSection-->
  <VizSection id="firstSection">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>There are enormous impacts of a changing snow pattern.</h2>
    </template>
    <!-- FIGURES -->
    <template v-slot:aboveExplanation>
      <p>Here's all about it</p>
    </template>
    <template v-slot:figures>
      <div class="group single maxWidth">
        <figure id="swe-chart-container">
          <img src="@/assets/diagrams/SWE-sketch.png">
        </figure>
      </div>
    </template>
    <!-- FIGURE CAPTION -->
    <template v-slot:figureCaption>
      <p>
        Captionsldkfjsldfja;kdfja;lkfja;ldskfjalskfjal;dkfja;lsdkfj
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
    name: "Impact",
    components:{
        VizSection
    },
    data() {
      return {
         publicPath: process.env.BASE_URL
      }      
    },
    mounted() {
      
    },
    methods: {
      
    }
}
</script>

<style lang="scss" scoped>

</style>