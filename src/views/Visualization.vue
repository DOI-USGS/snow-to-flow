<template>
  <div id="visualization">
    <Intro />
    <Broadscale />
    <References />
  </div>
</template>

<script>
   
    export default {
        name: 'Visualization',
        components: {
          Intro: () => import(/* webpackPreload: true */ /*webpackChunkName: "intro"*/ "./intro/Intro"),
          Broadscale: () => import(/* webpackPreload: true */ /*webpackChunkName: "broadscale"*/ "./1-Broadscale/Broadscale"),
          References: () => import(/* webpackPreload: true */ /*webpackChunkName: "references"*/ "./4-References/References"),
        }
    }
</script>

<style lang="scss">

</style>
