<template>
  <div id="visualization">
    <!-- <Intro />
     -->
    <Header />
    <!--  <In2021 /> -->
    <Timing />
    <SWE />
    <SWEanimation />
    <Broadscale />
    <References />
  </div>
</template>

<script>
   
    export default {
        name: 'Visualization',
        components: {
          Timing: () => import(/* webpackPreload: true */ /*webpackChunkName: "intro"*/ "./timing/Timing"),
          Header: () => import(/* webpackPreload: true */ /*webpackChunkName: "Header"*/ "./header/Header"),
          SWE: () => import(/* webpackPreload: true */ /*webpackChunkName: "swe"*/ "./swe/SWE"),
          SWEanimation: () => import(/* webpackPreload: true */ /*webpackChunkName: "swea"*/ "./swe/SWEanimation"),
          //In2021: () => import(/* webpackPreload: true */ /*webpackChunkName: "In2021"*/ "./in2021/In2021")
          // Intro: () => import(/* webpackPreload: true */ /*webpackChunkName: "intro"*/ "./intro/Intro"),
          Broadscale: () => import(/* webpackPreload: true */ /*webpackChunkName: "broadscale"*/ "./1-Broadscale/Broadscale"),
          References: () => import(/* webpackPreload: true */ /*webpackChunkName: "references"*/ "./4-References/References"),
          
        }
    }
</script>

<style lang="scss">
SWE {
  z-index: 1;
}
</style>
