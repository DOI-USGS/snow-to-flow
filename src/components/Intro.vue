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
        A majority of the water in the western U.S. comes from snowmelt<sup>1</sup>.
      </h2>
    </template>
    <template v-slot:aboveExplanation>
      <p>
        On snow-capped mountains, snow accumulates all winter and often well into spring.  The snowpack functions as a <span class="emph">frozen water tower</span> by storing water as snow throughout much of the spring and into summer<sup>2</sup>. When snow finally melts, the high elevation areas produce a large pulse of streamflow that redistributes water downstream through the landscape.
        The dynamics happening in each season of the water year are critical components of the hydrologic cycle in the western U.S., and have consequences for both humans and the ecosystems that depend on it<sup>3</sup>.
      </p>
      <Sidebar>
        <template v-slot:sidebarTitle>
          What is a "water year"?
        </template>
        <template v-slot:sidebarMessage>
          <p>Similar to a fiscal year, a water year is the 12-month period from October 1st to September 30th of the following year.  For example, Water Year 2021 (WY2021) began on October 1st, 2020 and will end on September 30th, 2021.</p>
          <p>Hydrologists use the concept of a water year because hydrologic activity in the fall and winter sets the stage for the streamflow in the following spring and summer.</p>
        </template>
      </Sidebar>
      <p>
        But, research shows that changes in the <span class="emph">timing, magnitude</span> and <span class="emph">duration</span> of snowmelt may substantially alter water availability downstream<sup>3,4</sup>.
      </p>
      <p>
        Approximately 2 billion people are expected to experience diminished water supplies due to seasonal snowpack decline this century<sup>5,6</sup>.  Over the last half century, particularly in some regions of the western U.S., <span class="emph">snowpack levels have declined</span><sup>7–9</sup> and contributed to <span class="emph">reduced of streamflow</span>, a trend supported by both models and on-the-ground observations<sup>3,4</sup>.
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
        Sidebar
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
