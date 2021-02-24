  
<template>
  <section id="srubbable">
    <div id="container">
      <div class="scrollDist mtn">
        <div class="main mtn">
          <svg
            viewBox="0 0 1200 800"
            xmlns="http://www.w3.org/2000/svg"
          >
            <mask id="m">
              <g class="cloud1">
                <rect
                  fill="#fff"
                  width="100%"
                  height="801"
                  y="799"
                />
                <image
                  xlink:href="@/assets/videos/cloudMask-01-01.png"
                  width="1200"
                  height="800"
                />
              </g>
            </mask>
                    
            <image
              class="sky"
              xlink:href="@/assets/videos/sky_blue.png"
              width="100%"
              height="74%"
            />
            <!-- this grabbed from codepen and need to be replaced with our own images -->
            <!-- <image class="mountBg" xlink:href="https://assets.codepen.io/721952/mountBg.png" width="100%" height="100%"/>   -->
            <!-- <image class="mountBg" xlink:href="https://assets.codepen.io/721952/mountBg.png" width="100%" height="100%"/>   -->  
            <image
              class="mountMg"
              xlink:href="https://assets.codepen.io/721952/mountMg.png"
              width="100%"
              height="100%"
            />    
            <image
              class="cloud2"
              xlink:href="https://assets.codepen.io/721952/cloud2.png"
              width="100%"
              height="100%"
            />    
            <image
              class="mountFg"
              xlink:href="@/assets/videos/mtn_fg2-01.png"
              width="100%"
              height="100%"
            />
            <!-- <image class="mountFg" xlink:href="https://assets.codepen.io/721952/mountFg.png" width="100%" height="100%"/> -->
            <image
              class="cloud1"
              xlink:href="https://assets.codepen.io/721952/cloud1.png"
              width="100%"
              height="100%"
            />
            <image
              class="cloud3"
              xlink:href="https://assets.codepen.io/721952/cloud3.png"
              width="100%"
              height="100%"
            />
            <text
              class="overall-title"
              fill="#fff"
              x="600"
              y="200"
              text-anchor="middle"
            >From Snow to Flow</text>
            <text
              class="byline"
              x="280"
              y="250"
              fill="#fff"
              text-anchor="left"
            >U.S. Geological Survey<tspan
              dx="-145"
              dy="20"
            >Water Resources Mission Area</tspan></text>

                    
            <g mask="url(#m)">
              <rect
                fill="#fff"
                width="100%"
                height="80%"
              />      

            </g>
                    
          </svg>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import { ScrollToPlugin } from "gsap/ScrollToPlugin"; // to trigger scroll events
import { ScrollTrigger } from "gsap/ScrollTrigger"; // animated scroll events
    export default {
        name: 'Splash',
        data() {
            return {
                myVar: 50,
            }
        },
        computed: {
            windowHeight: function () {
                const usgsBannerHeight = 85;
                return Number(this.$store.state.windowHeight - this.$store.state.warningHeight - usgsBannerHeight) + 'px';
            }
        },
        mounted() { 
            const gsap = this.$gsap;
            gsap.registerPlugin(ScrollToPlugin, ScrollTrigger); // register gsap plugins for scrollTrigger
            // define timeline of events
            gsap.set('.main', {position:'absolute', background:'#fff', width:'100%', maxWidth:'1800px', height:'70%', top:0, left:'50%', x:'-50%'})
            gsap.set('.scrollDist', {width:'100%', height:'80%'})
            gsap.timeline({scrollTrigger:{trigger:'.scrollDist', start:'top top', end:'bottom bottom', scrub:1}})
                .fromTo('.sky', {y:0},{y:-200}, 0)
                .fromTo('.cloud1', {y:100},{y:-800}, 0)
                .fromTo('.cloud2', {y:-150},{y:-500}, 0)
                .fromTo('.cloud3', {y:-50},{y:-650}, 0)
                //.fromTo('.mountBg', {y:-10},{y:-100}, 0)
                .fromTo('.mountMg', {y:-30},{y:-250}, 0)
                .fromTo('.mountFg', {y:-50},{y:-600}, 0)
/* 
            $('#arrowBtn').on('mouseenter', (e)=>{ gsap.to('.arrow', {y:10, duration:0.8, ease:'back.inOut(3)', overwrite:'auto'}); })
            $('#arrowBtn').on('mouseleave', (e)=>{ gsap.to('.arrow', {y:0, duration:0.5, ease:'power3.out', overwrite:'auto'}); })
            $('#arrowBtn').on('click', (e)=>{ gsap.to(window, {scrollTo:innerHeight, duration:1.5, ease:'power1.inOut'}); }) // scrollTo requires the ScrollTo plugin (not to be confused w/ ScrollTrigger)
       */  }
    }
</script>

<style scoped lang="scss">
.mtn {
  position:relative;
}
#container {
    position: relative;
    height: 120vh;
    width: 100%;
}
#cheese {
    position: fixed;
    width: 80%;
    top: 62%;
    left: 25%;
    margin:auto;
}
</style>