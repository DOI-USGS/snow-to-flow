<template>
  <div id="visualization">
    <Chapter
      id="chapter1"
      class="parallax"
    >
      <template v-slot:chapterTitle>
        The timing and magnitude of snowmelt is changing across the western U.S.
      </template>
    </Chapter>
    <SNTLMap
      id="section1"
    />
    
    <Chapter
      id="chapter2"
      image="chapter2"
      :height="50"
    >
      <template v-slot:chapterTitle>
        The Critical Measurement: Peak SWE
      </template>
    </Chapter>
    <SWE />
    <ImgCarousel />
    <Chapter
      id="chapter2-5"
      image="chapter4"
      :height="50"
    >
      <template v-slot:chapterTitle>
        From Snow to Flow to Water Supply
      </template>
    </Chapter>
    <DiagramsGood 
      id="diagrams-good"
    />
    <DiagramsBad 
      id="diagrams-bad"
    />
    <Chapter
      id="chapter3"
      class="parallax"
      image="chapter3"
      :height="70"
    >
      <template v-slot:chapterTitle>
        The Third Chapter Title
      </template>
    </Chapter>
    <SWEanim
      id="section3"
    />
    <Chapter
      id="chapter4"
      image="chapter4"
      :height="50"
    >
      <template v-slot:chapterTitle>
        Elevation
      </template>
    </Chapter>
    <Elevation
      id="section4"
    />
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
      // Splash: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "section"*/ "./../components/Splash"),
      SNTLMap: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "section"*/ "./../components/SNTLmap"),
      SWE: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "SWE"*/ "./../components/SWE"),
      ImgCarousel: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "imgcarousel"*/ "./../components/ImgCarousel"),
      DiagramsGood: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "diagramsgood"*/ "./../components/DiagramsGood"),
      DiagramsBad: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "diagramsbad"*/ "./../components/DiagramsBad"),
      SWEanim: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "section"*/ "./../components/SWEanim"),
      Elevation: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "section"*/ "./../components/Elevation"),
      References: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "References"*/ "./../components/References"),
      Chapter
    },
    mounted(){
      //Waits until the first DOM paint is complete
      //Allows us to only run the functionality when we know the DOM elements are loaded
      this.$nextTick(() => {
        this.parallaxScroll();
      })
    },
    methods:{
      parallaxScroll(){
        const gsap = this.$gsap;
        gsap.registerPlugin(ScrollToPlugin, ScrollTrigger); // register gsap plugins for scrollTrigger
        gsap.utils.toArray(".parallax").forEach((chapter, i) => {
          chapter.bg = chapter.querySelector(".bg");
          gsap.to(chapter.bg, {
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
