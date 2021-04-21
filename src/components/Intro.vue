<template>
  <!---VizSection-->
  <VizSection
    id="intro"
    :figures="false"
    :fig-caption="false"
  >
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <div id="byline">
        <p>U.S. Geological Survey</p>
        <p>Water Resources Mission Area</p>
      </div>
      <h2>
        A majority of the water in the western U.S. comes from snowmelt.
      </h2>
    </template>
    <template v-slot:aboveExplanation>
      <p>
        Snow-capped mountains, where snow accumulates all winter and often well into spring, function as <span class="emph">frozen water towers</span> by storing water as snow into late spring and summer<sup>1</sup>. When spring weather arrives, and the snow melts, the high elevation areas produce a large pulse of streamflow that redistributes water downstream through the landscape. These seasonal dynamics are critical components of the surface water cycle in the Western U.S., for both humans and <sup>2,3</sup>.
      </p>
      <p>
        Changes in the <span class="emph">timing, magnitude</span> and <span class="emph">duration</span> of snowmelt may substantially alter downstream water availability<sup>2,4</sup>. 
        Approximately 2 billion people are expected to experience diminished water supplies because of seasonal snowpack decline this century<sup>5,6</sup>. Over the last half century, particularly in some regions of the Western U.S., annual snowpack levels have <span class="emph">declined</span><sup>7–9</sup> and contributed to <span class="emph">reduced of streamflow</span>, a trend supported by both models and on-the-ground observations<sup>2,4</sup>.
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
import Sidebar from '@/components/Sidebar';

export default {
    name: "Intro",
    components:{
        VizSection,
    },
     mounted() {
          this.$nextTick(() => {
            this.gsapOpacity();
          });
        },
     methods: {
      gsapOpacity(){
        this.$gsap.from("#intro", {
          scrollTrigger:{
            trigger: "#intro",
            start: "-200px center",
            end: "top center",
            scrub: true,
            toggleOptions: "restart pause reverse pause"
          },
          opacity: 0
        });
      }
     }
}
</script>
<style lang="scss" scoped>
  #byline {
    font-weight: 400;
    margin-bottom: 64px;
  }
</style>
