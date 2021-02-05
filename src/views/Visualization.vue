<template>
  <div id="visualization">
    <h1>{{ title }}</h1>
    <Intro />
  </div>
</template>

<script>
    export default {
        name: 'Visualization',
        components: {
          Intro: () => import(/* webpackPreload: true */ /*webpackChunkName: "intro"*/ "./intro/Intro")
        },
        props: {
            title: {
                type: String,
                default: process.env.VUE_APP_TITLE
            }
        }
    }
</script>

<style scoped lang="scss">

</style>
