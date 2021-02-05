<template>
    <section>       
        <div class="text-content">
            <h3 v-html="text.subtitle1" />
            <p v-html="text.p1" />
            <p v-html="text.p2" />
            <p v-html="text.p3" />
        </div>
    </section>
</template>

<script>
    import broadscaleText from "./../../assets/text/broadscaleText";

    export default {
        name: 'Broadscale',
        data() {
            return {
                text: broadscaleText.textContents
            }
        }
    }
</script>

<style scoped lang="scss">

</style>