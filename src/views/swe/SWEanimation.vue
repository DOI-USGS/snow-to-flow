<template>
  <section id="swe-animation">
    <div class="text-content">
        <div>
          <h2 id="no-flow">Not all snow = flow </h2>
        <svg id="swe-gifs"
          xmlns="http://www.w3.org/2000/svg"
          xmlns:xlink="http://www.w3.org/1999/xlink"
          viewBox="0 0 1000 1200"
          aria-labelledby="page-title page-desc"
          width="100%"
          >
          <title id="page-title">not all snow is flow</title>
        <desc id="page-desc">An animated one-year time series of snow-water equivalent in  the upper colorado river basin</desc>
          <image
            xlink:href="@/assets/videos/swe_2011.gif"
            height="400px"
            x="0"
            y="0"
          />
          <image
            xlink:href="@/assets/videos/swe_2012.gif"
            height="400px"
            x="0"
            y="425"
          />
          <g id="gages_2011" >
            <rect x="0" y="0" width="430" height="400" style="fill: none;stroke: black;stroke-linecap: round;stroke-linejoin: round;stroke-width: 3px"/>
            <circle id="gage_2011_06714800" cx="392.26" cy="134.07" r="2.25" class="gage"/>
            <circle id="gage_2011_0671500" cx="396.26" cy="125.37" r="2.25" class="gage"/>
            <circle id="gage_2011_06716100" cx="398.19" cy="124.44" r="2.25" class="gage"/>
            <circle id="gage_2011_06716500" cx="400" cy="123.53" r="2.25" class="gage"/>
            <circle id="gage_2011_06717400" cx="406.38" cy="130.22" r="2.25" class="gage"/>
            <circle id="gage_2011_09016500" cx="373.25" cy="76.67" r="2.25" class="gage"/>
            <circle id="gage_2011_09019000" cx="376.12" cy="72.29" r="2.25" class="gage"/>
            <circle id="gage_2011_09019500" cx="372.64" cy="75.4" r="2.25" class="gage"/>
            <circle id="gage_2011_09022000" cx="402" cy="112.64" r="2.25" class="gage"/>
            <circle id="gage_2011_09024000" cx="385.21" cy="105.3" r="2.25" class="gage"/>
            <circle id="gage_2011_09025000" cx="384.33" cy="102.56" r="2.25" class="gage"/>
            <circle id="gage_2011_09025300" cx="379.39" cy="106.68" r="2.25" class="gage"/>
            <circle id="gage_2011_09025400" cx="380.12" cy="102.67" r="2.25" class="gage"/>
            <circle id="gage_2011_09026500" cx="374.66" cy="103.86" r="2.25" class="gage"/>
            <circle id="gage_2011_09032000" cx="386.42" cy="98.57" r="2.25" class="gage"/>
            <circle id="gage_2011_09032100" cx="388.59" cy="93.76" r="2.25" class="gage"/>
            <circle id="gage_2011_09033300" cx="377.9" cy="90.81" r="2.25" class="gage"/>
            <circle id="gage_2011_09034900" cx="371.54" cy="124.02" r="2.25" class="gage"/>
            <circle id="gage_2011_035500" cx="369.29" cy="121.49" r="2.25" class="gage"/>
            <circle id="gage_2011_394308105413800" cx="393.56" cy="129.8" r="2.25" class="gage"/>
          </g>
            <g id="gages_2012" >
            <rect x="0" y="425" width="430" height="400" style="fill: none;stroke: black;stroke-linecap: round;stroke-linejoin: round;stroke-width: 3px"/>
            <circle id="gage_2012_06714800" cx="392.26" cy="559.07" r="2.25" class="gage"/>
            <circle id="gage_2012_0671500" cx="396.26" cy="559.37" r="2.25" class="gage"/>
            <circle id="gage_2012_06716100" cx="398.19" cy="5584.44" r="2.25" class="gage"/>
            <circle id="gage_2012_06716500" cx="400" cy="557.53" r="2.25" class="gage"/>
            <circle id="gage_2012_06717400" cx="406.38" cy="555.22" r="2.25" class="gage"/>
            <circle id="gage_2012_09016500" cx="373.25" cy="501.67" r="2.25" class="gage"/>
            <circle id="gage_2012_09019000" cx="376.12" cy="497.29" r="2.25" class="gage"/>
            <circle id="gage_2012_09019500" cx="372.64" cy="500.4" r="2.25" class="gage"/>
            <circle id="gage_2012_09022000" cx="402" cy="537.64" r="2.25" class="gage"/>
            <circle id="gage_2012_09024000" cx="385.21" cy="530.3" r="2.25" class="gage"/>
            <circle id="gage_2012_09025000" cx="384.33" cy="527.56" r="2.25" class="gage"/>
            <circle id="gage_2012_09025300" cx="379.39" cy="531.68" r="2.25" class="gage"/>
            <circle id="gage_2012_09025400" cx="380.12" cy="527.67" r="2.25" class="gage"/>
            <circle id="gage_2012_09026500" cx="374.66" cy="528.86" r="2.25" class="gage"/>
            <circle id="gage_2012_09032000" cx="386.42" cy="523.57" r="2.25" class="gage"/>
            <circle id="gage_2012_09032100" cx="388.59" cy="518.76" r="2.25" class="gage"/>
            <circle id="gage_2012_09033300" cx="377.9" cy="515.81" r="2.25" class="gage"/>
            <circle id="gage_2012_09034900" cx="371.54" cy="549.02" r="2.25" class="gage"/>
            <circle id="gage_2012_035500" cx="369.29" cy="546.49" r="2.25" class="gage"/>
            <circle id="gage_2012_394308105413800" cx="393.56" cy="554.8" r="2.25" class="gage"/>
          </g>
        </svg>
      </div>
<div class="text-content grey-box">
      <h2 class="big-statement">
        What is SWE?
      </h2>

      <div id="swe-animation-viz">
        <p class="text-content">The Snow Water Equivalent (SWE) is the translation from snowpack to water, measured as a depth.</p>
        <div id="swe-viz">
          <svg
            id="swe-svg"
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 221 146"
          >
            <g>
              <path
                class="sketchy"
                d="M14.43,6V141"
              />
              <path
                class="sketchy"
                d="M8,137.3H211"
              />
              <g class="axes">
                <path d="M125.54,7.85v.92" />
                <path d="M125.54,10.59v123" />
                <path d="M125.54,134.53v.92" />
              </g>
              <path
                class="sketchy-blue"
                d="M15.81,132.22a15.18,15.18,0,0,0,8.26,0c2.93-.89,3.67-2,8.27-4.63,6.43-3.62,7.15-2.45,9.18-4.62,3.57-3.83,1.19-7.34,4.59-11.1s6.66-1.17,10.1-4.62c3.79-3.8.88-8,5.51-16.64,1.88-3.52,3.42-4.82,4.59-5.55,3.46-2.17,5.24-.4,8.27-1.85,5.72-2.74,3.28-11,10.1-15.72,3.16-2.18,3.9-.59,6.43-2.77,5.2-4.51,2.78-10.32,7.34-15.72,4.37-5.17,8.43-1.59,12.86-6.48,4.79-5.28,1.35-10.94,7.35-21.26,3-5.26,4.94-5.52,5.51-5.55,4.15-.24,7.7,7.79,9.18,11.09,9.25,20.61,21.48,39.73,31.22,60.11,3.22,6.74-1.42-1.73,15.61,27.74,3.14,5.43,4.86,8.3,8.27,11.09,7.34,6,16.42,6.67,22,6.48"
              />
            </g>
          </svg>
        </div>
      </div>
      </div>
    </div>
  </section>
</template>

<script>
import * as d3Base from "d3";
    export default {
        name: 'SWE',
        data() {
            return {
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
          const self = this;
          this.d3 = Object.assign(d3Base);

        },
        methods: {
          loadData() {
            const self = this;
            // read in data 
            let promises = [self.d3.csv(self.publicPath + "gage_mmd_2011.csv", this.d3.autoType),
            self.d3.csv(self.publicPath + 'gage_mmd_2012.csv'), this.d3.autotype];

            Promise.all(promises).then(self.callback); 
          },
          callback(data) {
            const  self  = this;

            this.mmd_2011 = data[0];
            this.mmd_2012 = data[1];

            //trigger hydrograph animation
            self.drawHydrographs();

          },
          drawHydrographs() {

          }
        }
    }
</script>

<style scoped lang="scss">


#swe-animation-viz {
    height: 1000px;
}
.sketchy {
    stroke-width: 2px;
    fill: none;
    stroke: white;

}
.sketchy-blue {
    stroke-width:10px;
    fill: none;
    stroke: #0e64bb;

}
.axes {
    fill: none;
    stroke-width: 1px;
    stroke-dasharray: 2px;
    stroke: white;
}
#swe-viz {
    position: relative;
    width: 60%;
}
#no-flow {
  margin: 50px;
}
line, polyline, polygon, path, rect, circle {
      fill: none;
      stroke: #000000;
      stroke-linecap: round;
      stroke-linejoin: round;
      stroke-miterlimit: 10.00;
    }
.gage {
      fill: #FF007F;
      stroke: none;
}
.grey-box {
      background-color: grey;
      height: 500px;
}
h2.big-statement {
  margin: 20px;
      color: white;
      fill: white;
    }
</style>