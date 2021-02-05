<template>
  <div>
    <div class="parallax-container">
      <parallax 
        :speed-Factor="0.3"
        :fixed="true"
        breakpoint="(min-width: 600px)"
      >
        <img
          class="title-backing"
          :src="image"
          alt="Picture of snow"
          loading="lazy"
        >
      </parallax>
    </div>
  </div>  
</template>

<script>
    import Parallax from "vue-parallaxy"; 
    
    export default {
        name: "SectionTitle",
        components: {
          Parallax
        },
        props: {
            image: {
                type: String,
                required: true
             }
        },
        data() {
            return {}
        }
    }
</script>


<style scoped lang="scss">

.parallax-container {
  position: relative;
}
.parallax-title {
  position: absolute;
  top: 60%;
  left: 0;
  right: 0;
  text-align: center;
}

</style>