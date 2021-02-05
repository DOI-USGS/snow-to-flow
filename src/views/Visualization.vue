<template>
  <div id="visualization">
    <Intro />
    <BroadscaleSectionTitle />
    <Broadscale />
  </div>
</template>

<script>
   
    export default {
        name: 'Visualization',
        components: {
          Intro: () => import(/* webpackPreload: true */ /*webpackChunkName: "intro"*/ "./intro/Intro"),
          BroadscaleSectionTitle: () => import(/* webpackPreload: true */ /*webpackChunkName: "broadscaletitle"*/ "./1-Broadscale/BroadscaleSectionTitle"),
          Broadscale: () => import(/* webpackPreload: true */ /*webpackChunkName: "broadscale"*/ "./1-Broadscale/Broadscale")
        }
    }
</script>

<style lang="scss">

</style>
