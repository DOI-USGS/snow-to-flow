<template>
  <section id="broadscale-impacts">       
    <SectionTitle
      :image="titleImage" 
    />
    <div class="text-content">
      <h2 v-html="text.subtitle1" />
      <p v-html="text.p1" />
      <p v-html="text.p2" />
      <p v-html="text.p3" />
    </div>
  </section>
</template>

<script>
    import broadscaleText from "./../../assets/text/broadscaleText";
    import SectionTitle from "@/components/SectionTitle";

    export default {
        name: 'Broadscale',
        components: {
            SectionTitle
        },
        data() {
            return {
                text: broadscaleText.textContents,
                titleImage:require('@/assets/titleImages/image1.png'), // insert link to parallax image used for this section,
            }
        }
    }
</script>

<style scoped lang="scss">

</style>