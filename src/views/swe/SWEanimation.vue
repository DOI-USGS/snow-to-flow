<template>
    <section id="swe-animation">
        <div class="text-content">
        <h2 class="big-statement">What is SWE?</h2>
        </div>
        <div id="swe-animation-viz">
            </div>


    </section>
</template>

<script>
    export default {
        name: 'SWE',
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


#swe-animation-viz {
    height: 500px;
}
.big-statement {
}

</style>