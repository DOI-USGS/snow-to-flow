<template>
    <section id="intro">
        <div id="header">
            <div class="text-content">
                <h1 id="title"> {{ title }} </h1>
                <p id="subheader">
                What changing snowmelt means for water
                </p>
            </div>
             <div 
      id="byline-wrapper" 
      class="text-content"
    >
      <p class="byline">
        U.S. Geological Survey<br>Water Resources Mission Area
      </p>
    </div>
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
</style>