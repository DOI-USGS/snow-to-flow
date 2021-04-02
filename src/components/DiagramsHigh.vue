<template>
  <!---VizSection-->
  <VizSection id="diagrams-high">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>High Snow + Late Melt = Lots of Flow</h2>
    </template>
    <template v-slot:aboveExplanation>
      <p>
        When scientists observe a large <span class="emph">snowpack magnitude</span>, a late <span class="emph">melt timing</span> 
        and short <span class="emph">melt duration</span>, they mark that as a high snow year.  The later the peak snowpack day occurs, 
        the more likely it is that the snow will melt all at once in a rapid surge. When these dynamics line up, it's a good 
        estimation that there will be a good amount of <span class="emph">flow</span> to provide good water available for the 
        rest of the year, even if the <span class="emph">soil saturation</span> soaks up some of the water. Even dry soils aren’t 
        able to absorb all the meltwater, and there can even be spring flooding.  
      </p>
    </template>
    <!-- FIGURES -->
    <template v-slot:figures>
      <DiagramCarouselHigh />
    </template>
    <!-- FIGURE CAPTION -->
    <template v-slot:figureCaption>
      <p>
        Click each diagram to enlarge it and learn more.
      </p>
    </template>
    <!-- EXPLANATION -->
    <template v-slot:belowExplanation>
      <p />
    </template>
  </VizSection>
</template>
<script>
import VizSection from '@/components/VizSection';
import DiagramCarouselHigh from '@/components/DiagramCarouselHigh';
// import Fig from '@/components/Figure';

export default {
    name: "DiagramsHigh",
    components:{
        VizSection,
        DiagramCarouselHigh
    }
}
</script>
<style lang="scss" scoped>


</style>