<template>
  <div id="visualization">
    <!-- <Intro />
     -->
    <Header />
    <Timing />
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
          // Intro: () => import(/* webpackPreload: true */ /*webpackChunkName: "intro"*/ "./intro/Intro"),
          Broadscale: () => import(/* webpackPreload: true */ /*webpackChunkName: "broadscale"*/ "./1-Broadscale/Broadscale"),
          References: () => import(/* webpackPreload: true */ /*webpackChunkName: "references"*/ "./4-References/References"),
          
        }
    }
</script>

<style lang="scss">

</style>
