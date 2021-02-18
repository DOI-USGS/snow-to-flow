<template>
  <div id="visualization" >
    <SNTLmap />
    <Diagrams />
  </div>
</template>

<script>
    export default {
        name: 'Visualization',
        components: {
            Diagrams: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "diagrams"*/ "./../components/Diagrams"),
            SNTLmap: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "SNTLmap"*/ "./../components/SNTLmap")
        }
    }
</script>

<style lang="scss">

</style>
