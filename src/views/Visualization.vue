<template>
  <div id="visualization">
    <SNTLmap />
    <SWE />
    <DiagramsGood />
    <DiagramsBad />
    <SWEanim />
  </div>
</template>

<script>
    export default {
        name: 'Visualization',
        components: {
            DiagramsGood: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "diagramsgood"*/ "./../components/DiagramsGood"),
            DiagramsBad: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "diagramsbad"*/ "./../components/DiagramsBad"),
            SWE: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "SWE"*/ "./../components/SWE"),
            SNTLmap: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "SNTLmap"*/ "./../components/SNTLmap"),
            SWEanim: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "SWEanim"*/ "./../components/SWEanim")
        }
    }
</script>

<style lang="scss">

</style>
