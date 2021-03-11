<template>
  <div id="visualization">
    <Splash />
    <SNTLMap />
    <Chapter
      id="chapter1"
      image="chapter1"
      :height="50"
    >
      <template v-slot:chapterTitle>
        It Starts with Snowpack
      </template>
    </Chapter>
    <MeasuringSWE />
    <SWE />
    <SWEtoDischarge />
    <Chapter
      id="chapter2"
      image="chapter3"
      :height="50"
    >
      <template v-slot:chapterTitle>
        From Winter Snow to Spring Flow
      </template>
    </Chapter>
    <DiagramsGood 
      id="diagrams-good"
    />
    <DiagramsBad 
      id="diagrams-bad"
    />
    <Chapter
      id="chapterLast"
      image="chapter4"
      :height="50"
    >
      <template v-slot:chapterTitle>
        What Spring Flow Means for Water Supply
      </template>
    </Chapter>
    <Impact />
    <References />
  </div>
</template>

<script>
import Chapter from "@/components/SectionTitle";
import { ScrollToPlugin } from "gsap/ScrollToPlugin"; // to trigger scroll events
import { ScrollTrigger } from "gsap/ScrollTrigger"; // animated scroll events
export default {
    name: 'Visualization',
    components: {
      Splash: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "section"*/ "./../components/TestSplash"),
      SNTLMap: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "SNTLMap"*/ "./../components/SNTLmap"),
      SWE: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "SWE"*/ "./../components/SWE"),
      MeasuringSWE: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "SWE"*/ "./../components/MeasuringSWE"),
      SWEtoDischarge: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "SWE"*/ "./../components/SWEtoDischarge"),
      DiagramsGood: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "diagramsgood"*/ "./../components/DiagramsGood"),
      DiagramsBad: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "diagramsbad"*/ "./../components/DiagramsBad"),
      Impact: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "impact"*/ "./../components/Impact"),
      References: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "References"*/ "./../components/References"),
      Chapter
    },
    mounted(){
      //Waits until the first DOM paint is complete
      //Allows us to only run the functionality when we know the DOM elements are loaded
      this.$gsap.registerPlugin(ScrollToPlugin, ScrollTrigger); // register gsap plugins for scrollTrigger
      this.$nextTick(() => {
        this.parallaxScroll();
      })
    },
    methods:{
      parallaxScroll(){
        this.$gsap.utils.toArray(".parallax").forEach((chapter, i) => {
          chapter.bg = chapter.querySelector(".bg");
          this.$gsap.to(chapter.bg, {
            ease: "none",
            scrollTrigger: {
              trigger: chapter,
              start: "bottom bottom",
              scrub: true,
              toggleActions: "restart pause reverse pause"
            },
            yPercent: 50,
          })
        })
      },
    }
} 
</script>

<style lang="scss">
SNTLmap {
  z-index: 1;
}
</style>
