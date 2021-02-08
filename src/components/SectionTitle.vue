<template>
  <div>
    <v-parallax
      dark
      :src="image"
      height="400"
    >
      <v-row
        align="center"
        justify="center"
      >
        <v-col
          class="text-center"
          cols="12"
        >
          <h1 class="display-1 font-weight-thin mb-4" />
          <h4 />
        </v-col>
      </v-row>
    </v-parallax>
  </div>  
</template>

<script>
    import Parallax from "vue-parallaxy"; 
    
    export default {
        name: "SectionTitle",
        props: {
            image: {
                type: String,
                required: true
             }
             // insert alt text dynamic binding here
        },
        data() {
            return {}
        }
    }
</script>


<style scoped lang="scss">

</style>