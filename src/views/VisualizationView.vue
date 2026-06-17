<template>
  <section id="visualization-container">
    <TitleSplash />
    <IntroSection
      v-if="checkIfSplashIsRendered"
    />
    <SectionTitle
      v-if="checkIfSplashIsRendered"
      id="chapter2"
      image="chapter5"
      alt="An image of a greenish-blue river winding through a snowy forest, faded into the background to serve as a backdrop for the section title."
      :height="50"
    >
      <template #chapterTitle>
        From Winter Snow to Spring Flow
      </template>
    </SectionTitle>
    <KeyDynamics />
    <!--DiagramsNormal 
      v-if="checkIfSplashIsRendered"
      id="diagrams-normal"
    /-->
    <SectionTitle
      v-if="checkIfSplashIsRendered"
      id="chapter1"
      image="chapter4"
      alt="An image of snowpack with wind-swept ripples on top, faded into the background to serve as a backdrop for the section title."
      :height="50"
    >
      <template #chapterTitle>
        Measuring Snowpack
      </template>
    </SectionTitle>
    <SWE v-if="checkIfSplashIsRendered" />
    <SectionTitle
      v-if="checkIfSplashIsRendered"
      id="chapterLast"
      image="chapter11"
      alt="An image of two bighorn sheep looking at each other standing in snow with a bright green lake of meltwater behind them.  The image is faded into the background to serve as a backdrop for the section title."
      :height="50"
    >
      <template #chapterTitle>
        Snowmelt season has already begun
      </template>
    </SectionTitle>
    <div>Gap</div>
    <SectionTitle
      v-if="checkIfSplashIsRendered"
      id="chapterLast"
      image="chapter15"
      alt="An image of a mossy mountaintop with fog rising over the peaks and small patches of snow melting into the green ground.  The image is faded into the background to serve as a backdrop for the section title."
      :height="50"
    >
      <template #chapterTitle>
        Learn More 
      </template>
    </SectionTitle>
    <div class="text-container">
      <ReferencesSection 
        v-if="checkIfSplashIsRendered"
      />
    </div>
  </section>
</template>

<script setup>
  import {computed} from 'vue'
  // import { ScrollToPlugin } from "gsap/ScrollToPlugin"; // to trigger scroll events
  // import { ScrollTrigger } from "gsap/ScrollTrigger"; // animated scroll events
  import { useSplashRenderStore } from '@/stores/SplashRenderStore';
  const splashRenderStore = useSplashRenderStore();
  
  import TitleSplash from '@/components/TitleSplash.vue';
  import IntroSection from '@/components/IntroSection.vue';
  import SectionTitle from '@/components/SectionTitle.vue';
  import KeyDynamics from '@/components/KeyDynamics.vue';
  // import DiagramsNormal from '@/components/DiagramsNormal.vue';
  import SWE from '@/components/SWE.vue';
  import ReferencesSection from '@/components/ReferencesSection.vue';

  // ADD CHECK IF SPLASH IS RENDERED
  const checkIfSplashIsRendered = computed(() => {
    return splashRenderStore.splashRenderedOnInitialLoad
  })
</script>

<style scoped>
</style>