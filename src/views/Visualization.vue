<template>
  <div id="visualization">
    <Intro />
    <Scrubbable />
  </div>
</template>

<script>
    export default {
        name: 'Visualization',
        components: {
          Intro: () => import(/* webpackPreload: true */ /*webpackChunkName: "intro"*/ "./intro/Intro"),
          Scrubbable: () => import(/* webpackPreload: true */ /*webpackChunkName: "Scrubbable"*/ "./scrubbable/Scrubbable")
        }
    }
</script>

<style lang="scss">

</style>
