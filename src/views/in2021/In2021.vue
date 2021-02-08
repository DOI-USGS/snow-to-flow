<template>
  <section id="in2021">
    <div class="container">
      <div class="text-content">
        <h2 class="big-statement">
          In 2021....
        </h2>
      </div>
    </div>
  </section>
</template>

<script>
import * as d3Base from "d3";
    export default {
        name: 'In2021',
        data() {
            return {
              d3: null,
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
            this.d3 = Object.assign(d3Base);


        }
    }
</script>

<style scoped lang="scss">

.container {
    background-color: grey;
    height: 80vh;
    width: 100%;
}
h2 {
    color: white;
}
p {
    color: black;
}


</style>