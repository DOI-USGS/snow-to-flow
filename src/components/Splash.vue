<template>
  <div class="splash">
    <div class="splashTitle">
      <h1 id="title">From Snow to Flow</h1>
      <h2 id="subtitle">What changing snowmelt means for western water</h2>
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
          media="(min-width: 350px)"
          srcset="@/assets/titleImages/splash/mountainMG-sm.png"
        >
        <!-- Medium Screen -->
        <source
          media="(min-width: 500px)"
          srcset="@/assets/titleImages/splash/mountainMG-m.png"
        >
        <!-- Large screen -->
        <source
          media="(min-width: 800px)"
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
        <!-- Most compressed -->
        <source
          type="image/webp"
          srcset="@/assets/titleImages/splash/frozen-lakeFG.webp"
        > 
        <!-- Smallest Screen -->
        <source
          media="(min-width: 350px)"
          srcset="@/assets/titleImages/splash/frozen-lakeFG-sm.png"
        >
        <!-- Medium Screen -->
        <source
          media="(min-width: 500px)"
          srcset="@/assets/titleImages/splash/frozen-lakeFG-m.png"
        >
        <!-- Large screen -->
        <source
          media="(min-width: 800px)"
          srcset="@/assets/titleImages/splash/frozen-lakeFG-l.png"
        >
        <!-- X Large Screen -->
        <source
          media="(min-width: 1200px)"
          srcset="@/assets/titleImages/splash/frozen-lakeFG-xl.png"
        >
        <img 
          src="@/assets/titleImages/splash/frozen-lakeFG-xl.png"
          href="@/assets/titleImages/splash/frozen-lakeFG.png"
          alt="A frozen lake in front of rocky, snow-covered mountains."
        >
      </picture>
    </div>
    <div
      id="people"
      class="element"
      data-depth="0.20"
    >
      <picture>
        <!-- Not sure what the browser wants to do with this first one, but it's the largest original -->
<!--         <source srcset="@/assets/titleImages/splash/people.png"> -->
        <!-- Most compressed -->
        <source
          type="image/webp"
          srcset="@/assets/titleImages/splash/people.webp"
        > 
        <!-- Smallest Screen -->
        <source
          media="(min-width: 350px)"
          srcset="@/assets/titleImages/splash/people-sm.png"
        >
        <!-- Medium Screen -->
        <source
          media="(min-width: 500px)"
          srcset="@/assets/titleImages/splash/people-m.png"
        >
        <!-- Large screen -->
        <source
          media="(min-width: 800px)"
          srcset="@/assets/titleImages/splash/people-l.png"
        >
        <!-- X Large Screen -->
        <source
          media="(min-width: 1200px)"
          srcset="@/assets/titleImages/splash/people-xl.png"
        >
        <img 
          src="@/assets/titleImages/splash/people-l.png"
          href="@/assets/titleImages/splash/people-l.png"
          alt="Clouds rising over the snowy mountain"
        >
      </picture>
    </div>
    <div
      id="clouds"
      class="element cover"
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
          media="(min-width: 350px)"
          srcset="@/assets/titleImages/splash/cloud-sm.png"
        >
        <!-- Medium Screen -->
        <source
          media="(min-width: 500px)"
          srcset="@/assets/titleImages/splash/cloud-m.png"
        >
        <!-- Large screen -->
        <source
          media="(min-width: 800px)"
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
          alt="Clouds rising over the snowy mountain"
        >
      </picture>
    </div>
    <div
      id="more-clouds"
      class="element cover"
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
          media="(min-width: 350px)"
          srcset="@/assets/titleImages/splash/more-clouds-sm.png"
        >
        <!-- Medium Screen -->
        <source
          media="(min-width: 500px)"
          srcset="@/assets/titleImages/splash/more-clouds-m.png"
        >
        <!-- Large screen -->
        <source
          media="(min-width: 800px)"
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
                    //desktop 
                    "(min-width: 800px) and (max-width: 2619px)": function(){
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
                        .fromTo("#people", {yPercent: 17}, {yPercent: -11}, 0)
                        .fromTo("#water", {yPercent: 15}, {yPercent: -10}, 0)
                        .fromTo("#mountains", {yPercent: 10}, {yPercent: -2}, 0)
                    },
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
                        .fromTo("#people", {yPercent: 17}, {yPercent: -11}, 0)
                        .fromTo("#water", {yPercent: 15}, {yPercent: -10}, 0)
                        .fromTo("#mountains", {yPercent: 0}, {yPercent: 0}, 0)
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
    background-image: linear-gradient(#0c5fb4 0%, #fff 50%);
}
.splashTitle{
    position: absolute;
    top: 10%;
    z-index: 22;
    margin-bottom: 20px;
    padding: 0 15px;
    h1{
        font-size:clamp(5.4em, 20vw, 2em);
        font-weight: 500;
    }
    h2 {
      font-size:2.05em;
        font-weight: 400;
    }
    h1, h2, p{
        color: #fff;
        margin: auto;
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
}
#more-clouds {
  z-index: 30;
  height: 125%;
}
</style>