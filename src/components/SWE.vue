<template>
  <!---VizSection-->
  <VizSection id="firstSection">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>Snow-water equivalent (SWE)</h2>
    </template>
    <!-- FIGURES -->
    <template v-slot:figures>
      <div class="group single maxWidth">
        <figure id="swe-chart-container">
          <img src="@/assets/diagrams/SWE-sketch.png">
          <!-- <svg
            id="swe-chart"
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 700 400"
          >              
          </svg> -->
        </figure>
      </div>
    </template>
    <!-- FIGURE CAPTION -->
    <template v-slot:figureCaption>
      <p>
        The snow-water equivalent (SWE) include both snow depth and snow density to approximate the amount of water stored in snowpack. 
        
        While peak SWE gives us a snapshot of interannual variation in snow, intra-annual variation in the timing and magnitude is much more complex.
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
    name: "SWE",
    components:{
        VizSection
    }
}
</script>
<style lang="scss" scoped>
    // #timing-chart {
    //     background-color: aqua;
    //     width: 100%;
    //     height: 100%;
    // }

    #swe-chart-container img {
      width: 100%;
    }
</style>