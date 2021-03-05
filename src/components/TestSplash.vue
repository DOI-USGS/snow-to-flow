<template>
  <div class="splash">
    <div class="splashTitle">
      <h1>From Snow to Flow</h1>
      <p>U.S. Geological Survey</p>
      <p>Water Resources Mission Area</p>
    </div>
    <!-- <div class="splashOverlay" /> -->
    <div
      id="mountains"
      class="element"
      data-depth="0.10"
    >
      <picture>
        <source srcset="@/assets/images/splash/1x/mountains-1x.png">
        <source srcset="@/assets/images/splash/2x/mountains-2x.png">
        <img src="@/assets/images/splash/2x/mountains-2x.png">
      </picture>
    </div>
    <div
      id="water"
      class="element"
      data-depth="0.30"
    >
      <picture>
        <source srcset="@/assets/images/splash/1x/water-1x.png">
        <source srcset="@/assets/images/splash/2x/water-2x.png">
        <img src="@/assets/images/splash/2x/water-2x.png">
      </picture>
    </div>
    <div
      id="people"
      class="element"
      data-depth="0.20"
    >
      <picture>
        <source srcset="@/assets/images/splash/1x/people-1x.png">
        <source srcset="@/assets/images/splash/2x/people-2x.png">
        <img src="@/assets/images/splash/2x/people-2x.png">
      </picture>
    </div>
    <div
      id="clouds"
      class="element"
      data-depth="0.80"
    >
      <img src="@/assets/images/splash/clouds.png">
    </div>
  </div>
</template>
<script>
import { ScrollToPlugin } from "gsap/ScrollToPlugin"; // to trigger scroll events
import { ScrollTrigger } from "gsap/ScrollTrigger"; // animated scroll events
export default {
    name: "TestSplash",
    mounted(){
        this.$nextTick(() => this.splashParallax());
    },
    methods:{
        splashParallax(){
            const self = this;
            this.$gsap.registerPlugin(ScrollToPlugin, ScrollTrigger); // register gsap plugins for scrollTrigger 
                ScrollTrigger.matchMedia({
                    //desktop 
                    "(min-width: 800px)": function(){
                        self.$gsap.timeline({
                            scrollTrigger:{
                                trigger: ".splash",
                                start: "top top",
                                end:`bottom center`,
                                scrub: true
                            }
                        })
                        .fromTo("#clouds", {yPercent: 40}, {yPercent: -28}, 0)
                        .fromTo("#people", {yPercent: 0}, {yPercent: -10}, 0)
                        .fromTo("#water", {yPercent: 0}, {yPercent: -25}, 0)
                        .fromTo("#mountains", {yPercent: 0}, {yPercent: -10}, 0)
                    }
                })
        }
    }
}
</script>
<style lang="scss" scoped>
.splash{
    position: relative;
    height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
}
.splashTitle{
    position: relative;
    z-index: 22;
    margin-bottom: 20px;
    padding: 0 15px;
    h1{
        font-size:clamp(5em, 10vw, 2em)
    }
    h1, p{
        color: #fff;
    } 
    p{
        padding-top: 10px;
        font-weight: bold;
    }
}
.splashOverlay{
    position: absolute;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,.3);
    z-index: 21
}
.element{
    position: absolute;
    width: 100%;
    height: 100%;
}
.element img{
    object-fit: cover;
    object-position: center;
    width: 100%;
    height: 100%;
}
#mountains{
    z-index: 10;
}
#water{
    z-index: 15;
}
#people{
    z-index: 20;
}
#clouds{
    z-index: 25;
    height: 125%;
    display: none;
}
@media screen and (min-width:800px){
    #clouds{
        display: block;
    }
}
</style>