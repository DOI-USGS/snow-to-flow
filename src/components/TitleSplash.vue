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
        <!-- per screen size: WebP, with a PNG fallback -->
        <source
          type="image/webp"
          media="(max-width: 499px)"
          srcset="@/assets/titleImages/splash/mountainMG-sm.webp"
        >
        <source
          media="(max-width: 499px)"
          srcset="@/assets/titleImages/splash/mountainMG-sm.png"
        >
        <source
          type="image/webp"
          media="(min-width: 500px) and (max-width: 799px)"
          srcset="@/assets/titleImages/splash/mountainMG-m.webp"
        >
        <source
          media="(min-width: 500px) and (max-width: 799px)"
          srcset="@/assets/titleImages/splash/mountainMG-m.png"
        >
        <source
          type="image/webp"
          media="(min-width: 800px) and (max-width: 1199px)"
          srcset="@/assets/titleImages/splash/mountainMG-l.webp"
        >
        <source
          media="(min-width: 800px) and (max-width: 1199px)"
          srcset="@/assets/titleImages/splash/mountainMG-l.png"
        >
        <source
          type="image/webp"
          media="(min-width: 1200px)"
          srcset="@/assets/titleImages/splash/mountainMG-xl.webp"
        >
        <source
          media="(min-width: 1200px)"
          srcset="@/assets/titleImages/splash/mountainMG-xl.png"
        >
        <img
          src="@/assets/titleImages/splash/mountainMG-xl.png"
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
        <!-- per screen size: WebP, with a PNG fallback -->
        <source
          type="image/webp"
          media="(max-width: 499px)"
          srcset="@/assets/titleImages/splash/frozen-lakeFG-sm.webp"
        >
        <source
          media="(max-width: 499px)"
          srcset="@/assets/titleImages/splash/frozen-lakeFG-sm.png"
        >
        <source
          type="image/webp"
          media="(min-width: 500px) and (max-width: 799px)"
          srcset="@/assets/titleImages/splash/frozen-lakeFG-m.webp"
        >
        <source
          media="(min-width: 500px) and (max-width: 799px)"
          srcset="@/assets/titleImages/splash/frozen-lakeFG-m.png"
        >
        <source
          type="image/webp"
          media="(min-width: 800px) and (max-width: 1199px)"
          srcset="@/assets/titleImages/splash/frozen-lakeFG-l.webp"
        >
        <source
          media="(min-width: 800px) and (max-width: 1199px)"
          srcset="@/assets/titleImages/splash/frozen-lakeFG-l.png"
        >
        <source
          type="image/webp"
          media="(min-width: 1200px)"
          srcset="@/assets/titleImages/splash/frozen-lakeFG-xl.webp"
        >
        <source
          media="(min-width: 1200px)"
          srcset="@/assets/titleImages/splash/frozen-lakeFG-xl.png"
        >
        <img
          src="@/assets/titleImages/splash/frozen-lakeFG-xl.png"
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
        <!-- per screen size: WebP, with a PNG fallback -->
        <source
          type="image/webp"
          media="(max-width: 499px)"
          srcset="@/assets/titleImages/splash/cloud-sm.webp"
        >
        <source
          media="(max-width: 499px)"
          srcset="@/assets/titleImages/splash/cloud-sm.png"
        >
        <source
          type="image/webp"
          media="(min-width: 500px) and (max-width: 799px)"
          srcset="@/assets/titleImages/splash/cloud-m.webp"
        >
        <source
          media="(min-width: 500px) and (max-width: 799px)"
          srcset="@/assets/titleImages/splash/cloud-m.png"
        >
        <source
          type="image/webp"
          media="(min-width: 800px)"
          srcset="@/assets/titleImages/splash/cloud-l.webp"
        >
        <source
          media="(min-width: 800px)"
          srcset="@/assets/titleImages/splash/cloud-l.png"
        >
        <img
          src="@/assets/titleImages/splash/cloud-l.png"
          alt="Clouds lifting over the snowy mountain"
        >
      </picture>
    </div>
    <div
      id="more-clouds"
      class="element"
      data-depth="0.90"
    >
      <picture>
        <!-- per screen size: WebP, with a PNG fallback -->
        <source
          type="image/webp"
          media="(max-width: 499px)"
          srcset="@/assets/titleImages/splash/more-clouds-sm.webp"
        >
        <source
          media="(max-width: 499px)"
          srcset="@/assets/titleImages/splash/more-clouds-sm.png"
        >
        <source
          type="image/webp"
          media="(min-width: 500px) and (max-width: 799px)"
          srcset="@/assets/titleImages/splash/more-clouds-m.webp"
        >
        <source
          media="(min-width: 500px) and (max-width: 799px)"
          srcset="@/assets/titleImages/splash/more-clouds-m.png"
        >
        <source
          type="image/webp"
          media="(min-width: 800px)"
          srcset="@/assets/titleImages/splash/more-clouds.webp"
        >
        <source
          media="(min-width: 800px)"
          srcset="@/assets/titleImages/splash/more-clouds.png"
        >
        <img
          src="@/assets/titleImages/splash/more-clouds.png"
          alt="Clouds rising over the snowy mountain"
        >
      </picture>
    </div>
  </div>
</template>

<script setup>
  import { onMounted, nextTick } from "vue";
  import { gsap } from "gsap"
  import { ScrollTrigger } from "gsap/ScrollTrigger"; // animated scroll events

  import { useSplashRenderStore } from '@/stores/SplashRenderStore';
  const splashRenderStore = useSplashRenderStore();

  // Declare behavior on mounted
  // functions called here
  onMounted(() => {
    nextTick(() => {
      splashRenderStore.splashRenderedOnInitialLoad = true;
      splashParallax()
    });
  });

  function splashParallax() {
    gsap.registerPlugin(ScrollTrigger);
    ScrollTrigger.matchMedia({
      // mobile
      "(max-width: 799px)": function(){
          gsap.timeline({
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
      // starts at 800px, where the mobile range ends and the splash images switch size
      "(min-width: 800px) and (max-width: 2619px)": function(){
          gsap.timeline({
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
          gsap.timeline({
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
</script>

<style lang="scss" scoped>
  .splash{
      position: relative;
      height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      background-image: linear-gradient(var(--deep-blue) 0%, #fff 70%);
  }
  .splashTitle{
      position: absolute;
      top: 10%;
      z-index: 22;
      margin-bottom: 20px;
      padding: 0 15px;
      text-align: center;
      h1{
          font-family: sans-serif; /* fallback for old browsers */
          font-family: var(--title-font);
          font-size: clamp(4.5em, 9vw, 7.5em);
          font-weight: 700;
      }
      h2 {
        font-family: sans-serif; /* fallback for old browsers */
        font-family: var(--default-font), sans-serif;
        font-size:1.4em;
        line-height: 1.4em;
      }
      h1, h2{
          color: #fff;
          margin: 10px auto;
      } 
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
  #clouds{
      z-index: 25;
      height: 125%;
  }
  #more-clouds {
    z-index: 30;
    height: 125%;
  }
</style>