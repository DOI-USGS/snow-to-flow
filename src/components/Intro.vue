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
        A <a
          href="https://agupubs.onlinelibrary.wiley.com/doi/full/10.1002/2017GL073551"
          target="_blank"
        >majority</a> of the water in the western U.S. comes from snowmelt.
      </h2>
    </template>
    <template v-slot:aboveExplanation>
      <p>
        Snow-capped mountains, where snow accumulates all winter, function as <a
          href="https://onlinelibrary.wiley.com/doi/full/10.1002/hyp.13735#hyp13735-bib-0018"
          target="_blank"
        >frozen water towers</a> by storing water as frozen snow late into the spring.  When snow finally melts, the high elevation areas produce a large pulse of streamflow that redistributes water downstream through the landscape.
      </p>
      <p>
        The seasonal dynamics of snowmelt are critical components of the surface water cycle in these areas, for the humans and ecosystems that rely on the water. <a
          href="https://onlinelibrary.wiley.com/doi/full/10.1002/hyp.13735#hyp13735-bib-0052"
          target="_blank"
        >Cite</a>, <a
          href="https://onlinelibrary.wiley.com/doi/full/10.1002/hyp.13735#hyp13735-bib-0101"
          target="_blank"
        >cite.</a>
        But with warmer, shorter winters and less snow accumulation, how will water availability change?
      </p>
      <p>
        Changes to snowmelt duration, timing and magnitude in these areas may substantially alter water availability downstream. In some regions of the western U.S., snowpack has <a
          href="https://onlinelibrary.wiley.com/doi/full/10.1002/hyp.13735#hyp13735-bib-0020"
          target="_blank"
        >declined</a> and contributed to <a
          href="https://onlinelibrary.wiley.com/doi/full/10.1002/hyp.13735#hyp13735-bib-0020"
          target="_blank"
        >lower levels of streamflow</a>, a trend supported by both models and on-the-ground observations.
      </p>
      <p>
        In fact, approximately
        <a
          href="https://onlinelibrary.wiley.com/doi/full/10.1002/hyp.13735#hyp13735-bib-0020"
          target="_blank"
        >2 billion</a> people are expected to experience diminished water supplies due to seasonal snowpack decline this century.
      </p>
      <p>This spring, as temperatures are warming and snow is starting to melt, the western U.S. is entering an important phase in their water cycle.  Looking at this year's snow - and how it turns into flow - can tell us a lot about water availability in the coming summer and fall.</p>
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