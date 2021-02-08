<template>
  <section id="references">       
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
    import referencesText from "./../../assets/text/referencesText";
    import SectionTitle from "@/components/SectionTitle";

    export default {
        name: 'References',
        components: {
            SectionTitle
        },
        data() {
            return {
                text: referencesText.textContents,
                titleImage:require('@/assets/titleImages/image2.png'), // insert link to parallax image used for this section
            }
        }
    }
</script>

<style scoped lang="scss">

</style>