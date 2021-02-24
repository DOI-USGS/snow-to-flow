<template>
  <!---VizSection-->
  <VizSection id="firstSection">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>Timing and Magnitude of Peak SWE help cue scientists as to whether it's a "good" or "bad" snow year.</h2>
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
        Figs. Wildfires affect the timing and magnitude of runoff and groundwater recharge.
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