<template>
  <!---VizSection-->
  <VizSection
    id="intro"
    :figures="false"
    :fig-caption="false"
  >
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>
        A majority of the water in the western U.S. comes from snowmelt<sup>1</sup>.
      </h2>
    </template>
    <template v-slot:aboveExplanation>
      <p>
        Snow-capped mountains, where snow accumulates all winter, function as frozen water towers by storing water as frozen snow late into the spring<sup>2</sup>. When snow finally melts, the high elevation areas produce a large pulse of streamflow that redistributes water downstream through the landscape.
        These seasonal dynamics are critical components of the surface water cycle in the western U.S., for both humans and the ecosystems that depend on it<sup>3</sup>
      </p>
      <p>
       Changes in the timing, magnitude and duration of snowmelt may substantially alter water availability downstream<sup>3,4</sup>. Approximately 2 billion people are expected to experience diminished water supplies due to seasonal snowpack decline this century<sup>5,6</sup>. In some regions of the western U.S., snowpack levels have declined<sup>7–9</sup> and contributed to reduced of streamflow, a trend supported by both models and on-the-ground observations<sup>3,4</sup>.
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
import { ScrollToPlugin } from "gsap/ScrollToPlugin"; // to trigger scroll events
import { ScrollTrigger } from "gsap/ScrollTrigger"; // animated scroll events
export default {
    name: "Intro",
    components:{
        VizSection
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
</style>