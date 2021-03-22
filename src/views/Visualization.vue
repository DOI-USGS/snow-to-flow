<template>
  <div id="visualization">
    <Splash />
    <Intro
      v-if="checkIfSplashIsRendered"
    />
    <Chapter
      v-if="checkIfSplashIsRendered"
      id="chapter2"
      image="chapter5"
      alt="An image of a greenish-blue river winding through a snowy forest, faded into the background to serve as a backdrop for the section title."
      :height="50"
    >
      <template v-slot:chapterTitle>
        From Winter Snow to Spring Flow
      </template>
    </Chapter>
    <DiagramsNormal 
      v-if="checkIfSplashIsRendered"
      id="diagrams-normal"
    />
    <DiagramsHigh 
      v-if="checkIfSplashIsRendered"
      id="diagrams-good"
    />
    <DiagramsLow 
      v-if="checkIfSplashIsRendered"
      id="diagrams-bad"
    />
    
    <Chapter
      v-if="checkIfSplashIsRendered"
      id="chapter1"
      image="chapter6"
      alt="An image of snowpack with wind-swept ripples on top, faded into the background to serve as a backdrop for the section title."
      :height="50"
    >
      <template v-slot:chapterTitle>
        It Starts with Snowpack
      </template>
    </Chapter>
    <MeasuringSWE v-if="checkIfSplashIsRendered" /> 
    <SWE v-if="checkIfSplashIsRendered" />
    <Chapter
      v-if="checkIfSplashIsRendered"
      id="chapter2-3"
      image="chapter9"
      alt="An landscape of snowy mountain tops with pine trees in the valley and a bright blue sky overhead, faded into the background to serve as a backdrop for the section title."
      :height="50"
    >
      <template v-slot:chapterTitle>
        Changes in snow have downstream consequences
      </template>    
    </Chapter>
    <SNTLMap v-if="checkIfSplashIsRendered" />
    <SWEanim v-if="checkIfSplashIsRendered" />
    <Chapter
      v-if="checkIfSplashIsRendered"
      id="chapterLast"
      image="chapter11"
      alt="An image of two bighorn sheep looking at each other standing in snow with a bright green lake of meltwater behind them.  The image is faded into the background to serve as a backdrop for the section title."
      :height="50"
    >
      <template v-slot:chapterTitle>
        What Spring Flow Means for Water Supply
      </template>
    </Chapter>
    <Impact v-if="checkIfSplashIsRendered" />
    <Chapter
      v-if="checkIfSplashIsRendered"
      id="chapterLast"
      image="chapter15"
      alt="An image of a mossy mountaintop with fog rising over the peaks and small patches of snow melting into the green ground.  The image is faded into the background to serve as a backdrop for the section title."
      :height="50"
    >
      <template v-slot:chapterTitle>
        Learn More 
      </template>
    </Chapter>
    <References v-if="checkIfSplashIsRendered" />
  </div>
</template>

<script>
import { ScrollToPlugin } from "gsap/ScrollToPlugin"; // to trigger scroll events
import { ScrollTrigger } from "gsap/ScrollTrigger"; // animated scroll events
export default {
    name: 'Visualization',
    components: {
      Splash: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "section"*/ "./../components/Splash"),
      Intro: () => import( /*webpackChunkName: "Intro"*/ "./../components/Intro"),
      SNTLMap: () => import( /*webpackChunkName: "SNTLMap"*/ "./../components/SNTLmap"),
      SWE: () => import( /*webpackChunkName: "SWE"*/ "./../components/SWE"),
      SWEanim: () => import( /*webpackChunkName: "SWE"*/ "./../components/SWEanim"),
      MeasuringSWE: () => import( /*webpackChunkName: "SWE"*/ "./../components/MeasuringSWE"),
      // SWEtoDischarge: () => import( /*webpackChunkName: "SWE"*/ "./../components/SWEtoDischarge"),
      DiagramsNormal: () => import( /*webpackChunkName: "diagramsnormal"*/ "./../components/DiagramsNormal"),
      DiagramsHigh: () => import( /*webpackChunkName: "diagramshigh"*/ "./../components/DiagramsHigh"),
      DiagramsLow: () => import( /*webpackChunkName: "diagramslow"*/ "./../components/DiagramsLow"),
      Impact: () => import( /*webpackChunkName: "impact"*/ "./../components/Impact"),
      References: () => import( /*webpackChunkName: "References"*/ "./../components/References"),
      Chapter: () => import( /*webpackChunkName: "ChapterTitles"*/ "./../components/SectionTitle"),
    },
    computed: {
      checkIfSplashIsRendered() {
          return this.$store.state.splashRenderedOnInitialLoad;
      }
    },
    mounted(){
      //Waits until the first DOM paint is complete
      //Allows us to only run the functionality when we know the DOM elements are loaded
      this.$gsap.registerPlugin(ScrollToPlugin, ScrollTrigger); // register gsap plugins for scrollTrigger
      this.$nextTick(() => {
        this.parallaxScroll();
      })
    },
    updated(){
      this.lazyLoadImages();
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
      lazyLoadImages(){
        const loadImg = function(entries, observer){
          entries.forEach(entry => {
            if(entry.isIntersecting){
              //Get first source element
              entry.target.srcset = entry.target.dataset.srcset; 
              //Get second source element
              entry.target.nextElementSibling.srcset = entry.target.dataset.srcset; 
              const findImg = entry.target.parentElement.querySelector("img");
              findImg.addEventListener('load', function () {
                entry.target.parentElement.classList.remove('lazy');
              });
              observer.unobserve(entry.target);
            }
          });
        }
        const imgTargets = document.querySelectorAll(".lazy > source");
        const imgObserver = new window.IntersectionObserver(loadImg, {
          //Watch entire viewport
          root: null,
          threshold: 0,
          rootMargin: "300px"
        })
        imgTargets.forEach(img => {
          imgObserver.observe(img)
        });
      }
    }
} 
</script>

<style lang="scss">

</style>
