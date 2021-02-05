<template>
    <SectionTitle
        :title="title"
        :image="titleImage"
    />
</template>

<script>
    import SectionTitle from "@/components/SectionTitle";

    export default {
        name: 'BroadscaleSectionTitle',
        components: {
           SectionTitle
        },
        data() {
            return {
                titleImage:require('@/assets/titleImages/image1.png')
            }
        }
    }
</script>

<style scoped lang="scss">

</style>