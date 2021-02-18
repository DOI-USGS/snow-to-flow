<template>
  <div id="visualization" >
  <Diagrams />
  </div>
</template>

<script>
    export default {
        name: 'Visualization',
        components: {
            Diagrams: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "diagrams"*/ "./../components/Diagrams")
        }
    }
</script>

<style lang="scss">

</style>
