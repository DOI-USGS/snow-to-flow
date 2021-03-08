<template>
  <!---VizSection-->
  <VizSection id="firstSection">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>The magnitude of SWE affects  runoff</h2>
    </template>
    <!-- EXPLANATION -->
    <template v-slot:explanation>
      <p>Global changes in temperature and precipitation affect the timing and rate of snowmelt. </p>
    </template>
    <!-- FIGURES -->
    <template v-slot:figures>
      <div class="group two maxWidth">
        <figure>
          <svg
            id="swe-gifs"
            xmlns="http://www.w3.org/2000/svg"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            viewBox="0 0 600 500"
            aria-labelledby="page-title page-desc"
            width="100%"
          >
            <title id="page-title">not all snow is flow</title>
            <desc id="page-desc">An animated one-year time series of snow-water equivalent in  the upper colorado river basin</desc>
        
            <image
              xlink:href="@/assets/SWEanim/co_2011_30fps.gif"
              height="400px"
              x="0"
              y="50"
            />
            <g id="gages_2011">
              </g>
          </svg>
        </figure>
        <figure>
          <svg
            id="mmd-gifs"
            xmlns="http://www.w3.org/2000/svg"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            viewBox="0 0 500 400"
            aria-labelledby="page-title page-desc"
            width="100%"
          >
<!--             <image
              xlink:href="@/assets/SWEanim/mmd_2011.gif"
              height="450px"
              x="0"
              y="50"
            /> -->
            <text
              x="0"
              y="100"
            >Discharge</text>
          </svg>
        </figure>
      </div>
    </template>
    <!-- FIGURE CAPTION -->
    <template v-slot:figureCaption>
      <p>
        Figure. The snow-water equivalent (left) and stream  discharge (right) through an entire water year in the Upper Colorado River Basin. Dots on map correspond to hydrographs on the right. Hydrographs are ordered and colored by elevation.
      </p>
    </template>
  </VizSection>
</template>
<script>
import VizSection from '@/components/VizSection';
import * as d3Base from "d3";
export default {
    name: "SWEanim",
    components:{
        VizSection
    },
    data() {
            return {
              title: process.env.VUE_APP_TITLE,
              mmd_2011: null,
              mmd_2012: null,
            }
        },
    mounted() {
          const self = this;
          this.d3 = Object.assign(d3Base);

        },
    methods: {
      loadData() {
        const self = this;
        // read in data to draw hydrographs - eventually want to animate with d3 over gif
        let promises = [self.d3.csv(self.publicPath + "data/gage_mmd_2011.csv", this.d3.autoType),
        self.d3.csv(self.publicPath + 'data/gage_mmd_2012.csv'), this.d3.autotype];

        Promise.all(promises).then(self.callback); 
      },
      callback(data) {
        const  self  = this;

        this.mmd_2011 = data[0];
        this.mmd_2012 = data[1];
      }
    }
}
</script>
<style lang="scss" scoped>
#mmd-gifs, #swe-gifs {
  max-height: 80vh;
  width: auto;
}

.maxWidth {
  max-width:80vw;
}
</style>