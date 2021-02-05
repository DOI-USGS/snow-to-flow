<template>
  <div id="visualization">
    <Intro />
  </div>
</template>

<script>
    export default {
        name: 'Visualization',
        components: {
          Intro: () => import(/* webpackPreload: true */ /*webpackChunkName: "intro"*/ "./intro/Intro")
        }
    }
</script>

<style lang="scss">

</style>
