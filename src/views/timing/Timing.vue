<template>
  <section id="timing">
    <div id="timing-viz">
      <!-- rigth now this is just spacing out between the header and end of page because there is some sketchy css in the header  -->
    </div>
  </section>
</template>

<script>
    export default {
        name: 'Intro',
        data() {
            return {
              title: process.env.VUE_APP_TITLE
            }
        },
        computed: {
            windowHeight: function () {
                const usgsBannerHeight = 85;
                return Number(this.$store.state.windowHeight - this.$store.state.warningHeight - usgsBannerHeight) + 'px';
            }
        },
        mounted() {
        }
    }
</script>

<style scoped lang="scss">

#header {
    position: relative;
    height: 80vh;
    background-color:  white;
}
#title {
    margin:0;
    margin-top:20vh;
}
#subheader {
    font-size: 1.9em;
}
#timing-viz {
    height: 00px;
}

</style>