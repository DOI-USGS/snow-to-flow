<template>
  <!---VizSection-->
  <VizSection
    id="intro"
    :figures="false"
    :fig-caption="false"
  >
    <!-- TAKEAWAY TITLE -->
    <template #takeAway>
      <div id="byline">
        <p>U.S. Geological Survey</p>
        <p>Water Resources Mission Area</p>
      </div>
      <h2>
        A majority of the water in the western U.S. comes from snowmelt.
      </h2>
    </template>
    <template #aboveExplanation>
      <p>
        Snow-capped mountains, where snow accumulates all winter and often well into spring, function as <span class="emph">frozen water towers</span> by storing water as snow into late spring and summer<sup class="citation"><a href="#ref-1">1</a></sup>. When spring weather arrives, and the snow melts, the high elevation areas produce a large pulse of streamflow that redistributes water downstream through the landscape. These seasonal dynamics are critical components of the surface water cycle in the Western U.S., for both humans and ecosystems<sup class="citation"><a href="#ref-2">2</a>,<a href="#ref-3">3</a></sup>.
      </p>
      <p>
        Changes in the <span class="emph">timing, magnitude</span> and <span class="emph">duration</span> of snowmelt may substantially alter downstream water availability<sup class="citation"><a href="#ref-2">2</a>,<a href="#ref-4">4</a></sup>. 
        Approximately 2 billion people are expected to experience diminished water supplies because of seasonal snowpack decline this century<sup class="citation"><a href="#ref-5">5</a>,<a href="#ref-6">6</a></sup>. Over the last half century, particularly in some regions of the Western U.S., annual snowpack levels have <span class="emph">declined</span><sup class="citation"><a href="#ref-7">7</a>–<a href="#ref-9">9</a></sup> and contributed to <span class="emph">reduced of streamflow</span>, a trend supported by both models and on-the-ground observations<sup class="citation"><a href="#ref-2">2</a>,<a href="#ref-4">4</a></sup>.
      </p>
    </template>
    <!-- EXPLANATION -->
    <template #belowExplanation>
      <p />
    </template>
  </VizSection>
</template>

<script setup>
  import { onMounted, nextTick } from "vue";
  import { gsap } from "gsap"
  import { ScrollTrigger } from "gsap/ScrollTrigger";

  import VizSection from '@/components/VizSection.vue';

  // Declare behavior on mounted
  // functions called here
  onMounted(() => {
    gsap.registerPlugin(ScrollTrigger)

    nextTick(() => {
      gsapOpacity();
    });
  });

  function gsapOpacity(){
    gsap.from("#intro", {
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
</script>

<style lang="scss" scoped>
  // clear the splash clouds, which extend below the splash
  #intro {
    padding-top: 5rem;
  }
  #byline {
    font-weight: 400;
    margin-bottom: 64px;
  }
</style>
