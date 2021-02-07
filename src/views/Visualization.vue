<template>
  <div id="visualization">
    <Header />
    <Timing />
    <SWE />
    <SWEanimation />
  </div>
</template>

<script>
    export default {
        name: 'Visualization',
        components: {
          Timing: () => import(/* webpackPreload: true */ /*webpackChunkName: "intro"*/ "./timing/Timing"),
          Header: () => import(/* webpackPreload: true */ /*webpackChunkName: "Header"*/ "./header/Header"),
          SWE: () => import(/* webpackPreload: true */ /*webpackChunkName: "swe"*/ "./swe/SWE"),
          SWEanimation: () => import(/* webpackPreload: true */ /*webpackChunkName: "swea"*/ "./swe/SWEanimation")
        }
    }
</script>

<style lang="scss">
SWE {
  z-index: 1;
}
</style>
