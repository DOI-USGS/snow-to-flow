<template>
  <div id="visualization" />
</template>

<script>
   
    export default {
        name: 'Visualization',
        components: {
          // Timing: () => import(/* webpackPreload: true */ /*webpackChunkName: "intro"*/ "@/components/Timing"),
          // Splash: () => import(/* webpackPreload: true */ /*webpackChunkName: "Header"*/ "@/components/Splash"),
          // // SWE: () => import(/* webpackPreload: true */ /*webpackChunkName: "swe"*/ "./swe/SWE"),
          // SWEanimation: () => import(/* webpackPreload: true */ /*webpackChunkName: "swea"*/ "@/components/SWEanimation"),
          // //In2021: () => import(/* webpackPreload: true */ /*webpackChunkName: "In2021"*/ "./in2021/In2021"),
          // // Intro: () => import(/* webpackPreload: true */ /*webpackChunkName: "intro"*/ "./intro/Intro"),
          // Broadscale: () => import(/* webpackPreload: true */ /*webpackChunkName: "broadscale"*/ "@/components/Broadscale"),
          // References: () => import(/* webpackPreload: true */ /*webpackChunkName: "references"*/ "@/components/References"), 
        }
    }
</script>

<style lang="scss">
SWE {
  z-index: 1;
}
</style>
