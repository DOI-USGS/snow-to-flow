<template>
  <section id="swe">
    <div class="text-content">
      <h2 class="big-statement consequences" />
    </div>
  </section>
</template>

<script>
import rough from 'roughjs';
import * as d3Base from "d3";
    export default {
        name: 'SWE',
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

            let roughSvg = rough.svg(document.getElementById('svg'));
            const line = roughSvg.line(60, 60, 190, 60);
            svg.appendChild(line);

            var svg = this.d3.select("#swe-svg")

        }
    }
</script>

<style scoped lang="scss">

#swe {
    height: 60vh;
    width: 100vw;
    background-attachment: fixed;
    background-position: center;
    background-repeat: no-repeat;
    background-size: cover;
    -webkit-background-size:cover; 
    background-image: url(../../assets/titleImages/image3.png);
}
.consequences {
    color: white;
}
p {
    color: white;
}


</style>