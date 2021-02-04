<template>
  <div id="visualization">
    <h1>{{ title }}</h1>
  </div>
</template>

<script>
    export default {
        name: 'Visualization',
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
