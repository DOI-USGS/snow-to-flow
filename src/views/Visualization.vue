<template>
  <div id="visualization">
    <SNTLmap />
    <Diagrams />
    <SWEanim />
  </div>
</template>

<script>
    export default {
        name: 'Visualization',
        components: {
            Diagrams: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "diagrams"*/ "./../components/Diagrams"),
            SNTLmap: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "SNTLmap"*/ "./../components/SNTLmap"),
            SWEanim: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "SWEanim"*/ "./../components/SWEanim")
        }
    }
</script>

<style lang="scss">

</style>
