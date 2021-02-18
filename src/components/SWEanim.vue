<template>
  <!---VizSection-->
  <VizSection id="firstSection">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>Changes in snowmelt have downstream consequences</h2>
    </template>
    <!-- EXPLANATION -->
    <template v-slot:explanation>
      <p>Stuff to explain.</p>
    </template>
    <!-- FIGURES -->
    <template v-slot:figures>
      <div class="group two maxWidth">
        <figure>
          <svg
            id="swe-gifs"
            xmlns="http://www.w3.org/2000/svg"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            viewBox="0 0 500 900"
            aria-labelledby="page-title page-desc"
            width="100%"
          >
            <title id="page-title">not all snow is flow</title>
            <desc id="page-desc">An animated one-year time series of snow-water equivalent in  the upper colorado river basin</desc>
        
            <image
              xlink:href="@/assets/videos/swe_2011.gif"
              height="400px"
              x="0"
              y="50"
            />
            <image
              xlink:href="@/assets/videos/swe_2012.gif"
              height="400px"
              x="0"
              y="475"
            />
            <g id="gages_2011">
              <rect
                x="0"
                y="50"
                width="430"
                height="400"
                style="fill: none;stroke: black;stroke-linecap: round;stroke-linejoin: round;stroke-width: 3px"
              />
              <circle
                id="gage_2011_06714800"
                fill="#ffe0e0"
                cx="392.26"
                cy="134.07"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2011_0671500"
                fill="#ebb5a8"
                cx="396.26"
                cy="125.37"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2011_06716100"
                fill="#d9b29a"
                cx="398.19"
                cy="124.44"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2011_06716500"
                fill="#d6b399"
                cx="400"
                cy="123.53"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2011_06717400"
                fill="#cdb194"
                cx="406.38"
                cy="130.22"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2011_09016500"
                fill="#c0ad8d"
                cx="373.25"
                cy="76.67"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2011_09019000"
                fill="#99937a"
                cx="376.12"
                cy="72.29"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2011_09019500"
                fill="#8d8975"
                cx="372.64"
                cy="75.4"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2011_09022000"
                fill="#757167"
                cx="402"
                cy="112.64"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2011_09024000"
                fill="#757167"
                cx="385.21"
                cy="105.3"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2011_09025000"
                fill="#66655f"
                cx="384.33"
                cy="102.56"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2011_09025300"
                fill="#62615d"
                cx="379.39"
                cy="106.68"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2011_09025400"
                fill="#62615d"
                cx="380.12"
                cy="102.67"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2011_09026500"
                fill="#62615d"
                cx="374.66"
                cy="103.86"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2011_09032000"
                fill="#555552"
                cx="386.42"
                cy="98.57"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2011_09032100"
                fill="#555552"
                cx="388.59"
                cy="93.76"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2011_09033300"
                fill="#555552"
                cx="377.9"
                cy="90.81"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2011_09034900"
                fill="#555552"
                cx="371.54"
                cy="124.02"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2011_035500"
                fill="#ebb5a8"
                cx="369.29"
                cy="121.49"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2011_394308105413800"
                fill="#ebb5a8"
                cx="393.56"
                cy="129.8"
                r="2.25"
                class="gage"
              />
            </g>
            <g id="gages_2012">
              <rect
                x="0"
                y="475"
                width="430"
                height="400"
                style="fill: none;stroke: black;stroke-linecap: round;stroke-linejoin: round;stroke-width: 3px"
              />
              <circle
                id="gage_2012_06714800"
                fill="#ffe0e0"
                cx="392.26"
                cy="559.07"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2012_0671500"
                fill="#ebb5a8"
                cx="396.26"
                cy="559.37"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2012_06716100"
                fill="#d9b29a"
                cx="398.19"
                cy="5584.44"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2012_06716500"
                fill="#d6b399"
                cx="400"
                cy="557.53"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2012_06717400"
                fill="#cdb194"
                cx="406.38"
                cy="555.22"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2012_09016500"
                fill="#c0ad8d"
                cx="373.25"
                cy="501.67"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2012_09019000"
                fill="#99937a"
                cx="376.12"
                cy="497.29"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2012_09019500"
                fill="#8d8975"
                cx="372.64"
                cy="500.4"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2012_09022000"
                fill="#757167"
                cx="402"
                cy="537.64"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2012_09024000"
                fill="#757167"
                cx="385.21"
                cy="530.3"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2012_09025000"
                fill="#66655f"
                cx="384.33"
                cy="527.56"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2012_09025300"
                fill="#62615d"
                cx="379.39"
                cy="531.68"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2012_09025400"
                fill="#62615d"
                cx="380.12"
                cy="527.67"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2012_09026500"
                fill="#62615d"
                cx="374.66"
                cy="528.86"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2012_09032000"
                fill="#555552"
                cx="386.42"
                cy="523.57"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2012_09032100"
                fill="#555552"
                cx="388.59"
                cy="518.76"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2012_09033300"
                fill="#555552"
                cx="377.9"
                cy="515.81"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2012_09034900"
                fill="#555552"
                cx="371.54"
                cy="549.02"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2012_035500"
                fill="#ebb5a8"
                cx="369.29"
                cy="546.49"
                r="2.25"
                class="gage"
              />
              <circle
                id="gage_2012_394308105413800"
                fill="#ebb5a8"
                cx="393.56"
                cy="554.8"
                r="2.25"
                class="gage"
              />
            </g>
          </svg>
        </figure>
        <figure>
          <svg
            id="mmd-gifs"
            xmlns="http://www.w3.org/2000/svg"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            viewBox="0 0 500 900"
            aria-labelledby="page-title page-desc"
            width="100%"
          >
            <image
              xlink:href="@/assets/videos/mmd_2011.gif"
              height="450px"
              x="0"
              y="50"
            />
            <image
              xlink:href="@/assets/videos/mmd_2012.gif"
              height="450px"
              x="0"
              y="475"
            />
            <text
              x="0"
              y="100"
            >high snow (2011)</text>
            <text
              x="0"
              y="550"
            >low snow (2012)</text>
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
        let promises = [self.d3.csv(self.publicPath + "gage_mmd_2011.csv", this.d3.autoType),
        self.d3.csv(self.publicPath + 'gage_mmd_2012.csv'), this.d3.autotype];

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

</style>