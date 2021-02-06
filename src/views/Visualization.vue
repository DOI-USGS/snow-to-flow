<template>
  <div id="visualization">
    <Header />
    <Timing />
  </div>
</template>

<script>
    export default {
        name: 'Visualization',
        components: {
          Timing: () => import(/* webpackPreload: true */ /*webpackChunkName: "intro"*/ "./timing/Timing"),
          Header: () => import(/* webpackPreload: true */ /*webpackChunkName: "Header"*/ "./header/Header")
        }
    }
</script>

<style lang="scss">

</style>
