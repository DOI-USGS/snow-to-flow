<template>
    <section id="swe">
        <div class="text-content">
        <h2 class="big-statement consequences">Changes in snowmelt have downstream consequences for water</h2>
        </div>
        <div id="swe-viz">
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

#swe {
    height: 100vh;
    width: 100vw;
    background-color: rgb(92, 91, 91);
}
.consequences {
    color: white;
}

</style>