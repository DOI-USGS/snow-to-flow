<template>
  <div class="splash">
    <div class="splashTitle">
      <h1 id="title">
        From Snow to Flow
      </h1>
      <h2 id="subtitle">
        What changing snowmelt means for Water in the Western U.S.
      </h2>
      <!--  <p>U.S. Geological Survey, Water Mission Area</p> -->
    </div>
    <!-- <div class="splashOverlay" /> -->
    <div
      id="mountains"
      class="element"
      data-depth="0.10"
    >
      <picture>
        <!--         <source srcset="@/assets/titleImages/splash/mountainMG.png"> -->
        <!-- Most compressed -->
        <source
          type="image/webp"
          srcset="@/assets/titleImages/splash/mountainMG.webp"
        > 
        <!-- Smallest Screen -->
        <source
          media="(min-width: 350px) and (max-width: 499px)"
          srcset="@/assets/titleImages/splash/mountainMG-sm.png"
        >
        <!-- Medium Screen -->
        <source
          media="(min-width: 500px) and (max-width: 799px)"
          srcset="@/assets/titleImages/splash/mountainMG-m.png"
        >
        <!-- Large screen -->
        <source
          media="(min-width: 800px) and (max-width: 1199px)"
          srcset="@/assets/titleImages/splash/mountainMG-l.png"
        >
        <!-- X Large Screen -->
        <source
          media="(min-width: 1200px)"
          srcset="@/assets/titleImages/splash/mountainMG-xl.png"
        >
        <img 
          src="@/assets/titleImages/splash/mountainMG-xl.png"
          href="@/assets/titleImages/splash/mountainMG-xl.png"
          alt="A scene of snowy mountains topped with clouds"
        >
      </picture>
    </div>
    <div
      id="water"
      class="element"
      data-depth="0.30"
    >
      <picture>
        <!-- Not sure what the browser wants to do with this first one, but it's the largest original -->
        <!--         <source srcset="@/assets/titleImages/splash/frozen-lakeFG.png"> -->
        <!-- Smallest Screen -->
        <source
          media="(min-width: 350px) and (max-width: 499px)"
          srcset="@/assets/titleImages/splash/frozen-lakeFG-sm.png"
        >
        <!-- Medium Screen -->
        <source
          media="(min-width: 500px) and (max-width: 799px)"
          srcset="@/assets/titleImages/splash/frozen-lakeFG-m.png"
        >
        <!-- Large screen -->
        <source
          media="(min-width: 800px) and (max-width: 1199px)"
          srcset="@/assets/titleImages/splash/frozen-lakeFG-l.png"
        >
        <!-- X Large Screen -->
        <source
          media="(min-width: 1200px)"
          srcset="@/assets/titleImages/splash/frozen-lakeFG-xl.png"
        >
        <!-- Most compressed -->
        <source
          type="image/webp"
          srcset="@/assets/titleImages/splash/frozen-lakeFG.webp"
        > 
        <img 
          src="@/assets/titleImages/splash/frozen-lakeFG-xl.png"
          href="@/assets/titleImages/splash/frozen-lakeFG.png"
          alt="A frozen lake in front of rocky, snow-covered mountains."
        >
      </picture>
    </div>

    <div
      id="clouds"
      class="element"
      data-depth="0.80"
    >
      <picture>
        <!-- Most compressed -->
        <source
          type="image/webp"
          srcset="@/assets/titleImages/splash/cloud.webp"
        > 
        <!-- Smallest Screen -->
        <source
          media="(max-width: 499px)"
          srcset="@/assets/titleImages/splash/cloud-sm.png"
        >
        <!-- Medium Screen -->
        <source
          media="(min-width: 500px) and (max-width: 799px)"
          srcset="@/assets/titleImages/splash/cloud-m.png"
        >
        <!-- Large screen -->
        <source
          media="(min-width: 800px) and (max-width: 1199px)"
          srcset="@/assets/titleImages/splash/cloud-l.png"
        >
        <!-- X Large Screen -->
        <source
          media="(min-width: 1200px)"
          srcset="@/assets/titleImages/splash/cloud-l.png"
        >
        <img 
          src="@/assets/titleImages/splash/cloud-l.png"
          href="@/assets/titleImages/splash/cloud-l.png"
          alt="Clouds liftng over the snowy mountain"
        >
      </picture>
    </div>
    <div
      id="more-clouds"
      class="element"
      data-depth="0.90"
    >
      <picture>
        <!-- Not sure what the browser wants to do with this first one, but it's the largest original -->
        <!--    <source srcset="@/assets/titleImages/splash/more-clouds.png"> -->
        <!-- Most compressed -->
        <source
          type="image/webp"
          srcset="@/assets/titleImages/splash/more-clouds.webp"
        > 
        <!-- Smallest Screen -->
        <source
          media="(max-width: 499px)"
          srcset="@/assets/titleImages/splash/more-clouds-sm.png"
        >
        <!-- Medium Screen -->
        <source
          media="(min-width: 500px) and (max-width: 799px)"
          srcset="@/assets/titleImages/splash/more-clouds-m.png"
        >
        <!-- Large screen -->
        <source
          media="(min-width: 800px) and (max-width: 1199px)"
          srcset="@/assets/titleImages/splash/more-clouds.png"
        >
        <!-- X Large Screen -->
        <source
          media="(min-width: 1200px)"
          srcset="@/assets/titleImages/splash/more-clouds.png"
        >
        <img 
          src="@/assets/titleImages/splash/more-clouds.png"
          href="@/assets/titleImages/splash/more-clouds.png"
          alt="Clouds rising over the snowy mountain"
        >
      </picture>
    </div>
  </div>
</template>
<script>
import { ScrollToPlugin } from "gsap/ScrollToPlugin"; // to trigger scroll events
import { ScrollTrigger } from "gsap/ScrollTrigger"; // animated scroll events
export default {
    name: "Splash",
    mounted(){
        this.$nextTick(() => {
          this.$store.commit('changeBooleanStateOnSplashRender');
          this.splashParallax()
        });
    },
    methods:{
        splashParallax(){
            const self = this;
            this.$gsap.registerPlugin(ScrollToPlugin, ScrollTrigger); // register gsap plugins for scrollTrigger 
                ScrollTrigger.matchMedia({
                    // mobile
                    "(max-width: 799px)": function(){
                        self.$gsap.timeline({
                            scrollTrigger:{
                                trigger: ".splash",
                                start: "top top",
                                end:`bottom center`,
                                scrub: true
                            }
                        })
                        .fromTo("#more-clouds", {yPercent: 50}, {yPercent: -40}, 0)
                        .fromTo("#clouds", {yPercent: 30}, {yPercent: -10}, 0)
                        //.fromTo("#people", {yPercent: 17}, {yPercent: -11}, 0)
                        .fromTo("#water", {yPercent: 25}, {yPercent: -10}, 0)
                        .fromTo("#mountains", {yPercent: 30}, {yPercent: 0}, 0)
                    },
                    //desktop 
                    "(min-width: 700px) and (max-width: 2619px)": function(){
                        self.$gsap.timeline({
                            scrollTrigger:{
                                trigger: ".splash",
                                start: "top top",
                                end:`bottom center`,
                                scrub: true
                            }
                        })
                        .fromTo("#more-clouds", {yPercent: 50}, {yPercent: -40}, 0)
                        .fromTo("#clouds", {yPercent: 30}, {yPercent: -10}, 0)
                        //.fromTo("#people", {yPercent: 17}, {yPercent: -11}, 0)
                        .fromTo("#water", {yPercent: 15}, {yPercent: -10}, 0)
                        .fromTo("#mountains", {yPercent: 25}, {yPercent:-10}, 0)
                    },
                    // giant screens
                    "(min-width: 2620px)": function(){
                        self.$gsap.timeline({
                            scrollTrigger:{
                                trigger: ".splash",
                                start: "top top",
                                end:`bottom center`,
                                scrub: true
                            }
                        })
                        .fromTo("#more-clouds", {yPercent: 2}, {yPercent: -40}, 0)
                        .fromTo("#clouds", {yPercent: 20}, {yPercent: -10}, 0)
                        //.fromTo("#people", {yPercent: 17}, {yPercent: -11}, 0)
                        .fromTo("#water", {yPercent: 15}, {yPercent: -10}, 0)
                        .fromTo("#mountains", {yPercent: 0}, {yPercent: 0}, 0)
                    }
                })
        }
    }
}
</script>
<style lang="scss" scoped>
$familySerif:  'Noto Serif', serif;

.splash{
    position: relative;
    height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    background-image: linear-gradient(#00478F 0%, #fff 70%);
}
.splashTitle{
    position: absolute;
    top: 10%;
    z-index: 22;
    margin-bottom: 20px;
    padding: 0 15px;
    h1{
        font-size:clamp(4em, 20vw, 2em);
        font-weight: 800;
    }
    h2 {
      font-family: $familySerif;
      font-size:1.4em;
      line-height: 1.4em;
      // font-weight: 400;
    }
    h1, h2, p{
        color: #fff;
        margin: 10px auto;
    } 
    p{
        padding-top: 10px;
        font-weight: 400;
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
    height: 110%;
}
.element img{
    object-fit: cover;
    object-position: 50% 0%;
    width: 100%;
    height: 100%;
    image-rendering: auto;
    overflow-y: visible;
}
#mountains{
    overflow-y: visible;
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
}
#more-clouds {
  z-index: 30;
  height: 125%;
}
</style>