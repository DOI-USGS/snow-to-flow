<template>
  <!---VizSection-->
  <VizSection id="firstSection">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2 />
    </template>
    <!-- EXPLANATION -->
    <template v-slot:explanation>
      <p>Global changes in temperature and precipitation affect the timing and rate of snowmelt. </p>
    </template>
    <!-- FIGURES -->
    <template v-slot:figures>
      <div
        id="figs"
        class="group two maxWidth"
      ><svg id="Layer_1" data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 450">
       <image
            xlink:href="@/assets/SWEanim/co_2011_60fps_600w.gif"
            width="550px"
            x="0"
            y="10"
          />
          <text
            x="50"
            y="25"
          >Snow-water equivalent (SWE)</text>
          <!-- <text
            x="500"
            y="50"
          >Discharge</text> -->
          <text
            x="620"
            y="400"
          >2011</text>
          <text
            x="850"
            y="400"
          >2012</text>
          <path transform="scale(1.19) translate(0, -35)" d="M429,141l-.32.44L430,172.61l0,.84,1.05,32,.19,5.9,1.19,26.54.19,5.9.84,26.14L435,308.31l.19,6.32.27,19.4.88,28.25L432,363.66l-9.13.27-12.18.34-15.53.4-8.13.17-7.12-1.09-4.72.5-4.71.94-13.18.23-14.53.24-14.19.18-8.13.09-5.73.06-16.9.13-23.67.1h-26l-8.8,0-12.49-.06-7.1,0-16.9-.17-27.38-.36-7.44-.1-18.24-.34-21.61-1.32-9.82.61-1-.89-5.4-.14-21.62-.61-21-.69-7.1-.26-5.73-.63-11.84,0-13.52-.54-7.1-.3,1.32-46.82,1.09-17.26.59-21.1L27.91,249l2.79-62.82L30.83,176l.84-11.38,1.91-41.74,1.47-32L36.52,66l-.34.4,63.33.42,34.18,1,25.22,1,29.35.94,7,.11-.32-.42,51.42.86,19.15-.4,49.18.15,27.15-.38,11.17-.19,39.93-.9,2.23-.07,31-.52.63,18.56L426.62,90l.35.82.3,18.56.23,6.76Z" style="fill: none;stroke: #000;stroke-linejoin: round;stroke-width: 2.246646621121159px"/>
          <g id="sites">
            <circle cx="192.89" cy="136.47" r="2" class="gage" />
            <circle cx="190.45" cy="196.01" r="2" class="gage" />
            <circle cx="199.03" cy="178.19" r="2" class="gage" />
            <circle cx="192.21" cy="134.2" r="2" class="gage" />
            <circle cx="171.22" cy="204.38" r="2" class="gage" />
            <circle cx="171.46" cy="203.69" r="2" class="gage" />
            <circle cx="197.05" cy="170" r="2" class="gage" />
            <circle cx="196.09" cy="167.19" r="2" class="gage" />
            <circle cx="195.75" cy="166.15" r="2" class="gage" />
            <circle cx="193.87" cy="167.72" r="2" class="gage" />
            <circle cx="192.07" cy="166.65" r="2" class="gage" />
            <circle cx="196.55" cy="164.62" r="2" class="gage" />
            <circle cx="197.39" cy="162.78" r="2" class="gage" />
            <circle cx="190.88" cy="174.35" r="2" class="gage" />
            <circle cx="190.01" cy="173.38" r="2" class="gage" />
            <circle cx="186.14" cy="172.4" r="2" class="gage" />
            <circle cx="186.13" cy="172.22" r="2" class="gage" />
            <circle cx="185.95" cy="172.45" r="2" class="gage" />
            <circle cx="185.72" cy="189.97" r="2" class="gage" />
            <circle cx="188.16" cy="182.86" r="2" class="gage" />
            <circle cx="185.48" cy="180.49" r="2" class="gage" />
            <circle cx="168.17" cy="193.1" r="2" class="gage" />
            <circle cx="169.64" cy="192.34" r="2" class="gage" />
            <circle cx="170.61" cy="183.98" r="2" class="gage" />
            <circle cx="176" cy="181.08" r="2" class="gage" />
            <circle cx="176.5" cy="182.61" r="2" class="gage" />
            <circle cx="174.22" cy="179.91" r="2" class="gage" />
            <circle cx="171.87" cy="179.99" r="2" class="gage" />
            <circle cx="166.26" cy="180.73" r="2" class="gage" />
            <circle cx="162.83" cy="179.76" r="2" class="gage" />
            <circle cx="161.73" cy="206.89" r="2" class="gage" />
            <circle cx="162.02" cy="208.98" r="2" class="gage" />
            <circle cx="154.9" cy="202.36" r="2" class="gage" />
            <circle cx="123.71" cy="214.03" r="2" class="gage" />
            <circle cx="123.82" cy="217.18" r="2" class="gage" />
            <circle cx="126.1" cy="218.99" r="2" class="gage" />
            <circle cx="109.36" cy="216.86" r="2" class="gage" />
            <circle cx="89.18" cy="163.61" r="2" class="gage" />
            <circle cx="118.12" cy="272.88" r="2" class="gage" />
          </g>
        
        </svg>
        <!-- <svg
          id="swe-gifs"
          xmlns="http://www.w3.org/2000/svg"
          xmlns:xlink="http://www.w3.org/1999/xlink"
          viewBox="0 0 550 450"
          aria-labelledby="page-title page-desc"
          width="100%"
        >
          <title id="page-title">not all snow is flow</title>
          <desc id="page-desc">An animated one-year time series of snow-water equivalent in Colorado.</desc>
          <text
            x="0"
            y="30"
          >Snow-water equivalent (SWE)</text>
        
          <image
            xlink:href="@/assets/SWEanim/co_2011_30fps.gif"
            height="250px"
            x="0"
            y="30"
          />
          <image
            xlink:href="@/assets/SWEanim/co_2012_30fps.gif"
            height="250px"
            x="0"
            y="265"
          />
          <g id="gages_2011" />
        </svg> -->
        <div id="mmd-container">
          <svg
            id="mmd-line"
            xmlns="http://www.w3.org/2000/svg"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            viewBox="-50 -100 600 450"
            aria-labelledby="page-title page-desc"
            width="100%"
          >

            <text
              x="50"
              y="25"
            >Discharge</text>
          </svg>
        </div>
      </div>
    </template>
    <!-- FIGURE CAPTION -->
    <template v-slot:figureCaption>
      <p>
        Snow-water equivalent (left) and stream discharge (right) through the 2011 water year in Colorado. Dots on map correspond to hydrographs on the right. Alternative: showing a single year with gages ranked  by snow persistence and mapped on 3d elevation map.
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
              publicPath: process.env.BASE_URL,
              d3: null,
              mmd_2011: null,
              mmd_2012: null,
              svg: null,
              width: 600,
              height: 400,
              margin: 25
            }
        },
    mounted() {
          const self = this;
          this.d3 = Object.assign(d3Base);

          this.loadData();

        },
    methods: {
      loadData() {
        const self = this;
        // read in data to draw hydrographs - eventually want to animate with d3 over gif
        let promises = [self.d3.csv(self.publicPath + "data/mmd_df_cast.csv", ({site_no, Date, water_day, mmd}) =>({site_no, Date, water_day, mmd}), this.d3.autotype),
        self.d3.csv(self.publicPath + 'data/mmd_df.csv'), this.d3.autotype];

        Promise.all(promises).then(self.callback); 
      },
      callback(data) {
        const  self  = this;

        // same data served up 2 ways
        var data_cast = data[0];
        var data_long = data[1];

        // prep data for plotting
        var sites = data_cast.columns // array of all site_no - each gets a ridge
        sites.shift(); // drop first column
        var n = sites.length;

        // nest data to iterate over in plot
        // sort of inverse of series - array of objects where objs = site containing key  for site_no, mmd and day vars
         data.allmmd = [];
          for (i = 1; i < n; i++) {
              var key = sites[i];
              var mmd = data_cast.map(function(d){  return d[key]; });
              var day = data_cast.map(function(d){  return d['site_water_day']; });
              data.allmmd.push({key: key, mmd: mmd, day:day})
          };

          data.days = data_cast.map(function(d) { return  d['site_water_day']}) // array of j days for good luck
          console.log(data.allmmd)

        // set up g that holds ridgelines
        this.svg = this.d3.select('svg#mmd-line')
        //this.ridges = this.svg.append("g").classed("ridges", true)

        // draw hydro chart elements
        this.drawHydro(data.allmmd, data.days);

      },
      drawHydro(data_nest, days){
        const self = this;
        let overlap = 6;

        // x axis - time
        var x = this.d3.scaleLinear()
          .domain([1,365])
          .range([ 0, this.width-(this.margin*3)]);

        // y axis = group for each site
        var y = this.d3.scalePoint()
          .domain(data_nest.map(d => d.key))
          .range([this.margin*2, this.height])

        // z = the y axis within each group - mmd
        var z = this.d3.scaleLinear()
          .domain([0, this.d3.max(data_nest, d => this.d3.max(d.mmd))]).nice()
          .range([0, -overlap * y.step()])

        // define & style x &  y axes
        var xAxis = g => g
          .attr("transform", `translate(0,${this.height})`)
          .call(this.d3.axisBottom(x)
              .ticks(this.width / 80)
              .tickSizeOuter(0))

        var yAxis = g => g
          .attr("transform", `translate(${this.margin},0)`)
          .call(this.d3.axisLeft(y).tickSize(0).tickPadding(4))
          .call(g => g.select(".domain").remove())

        // append axes
        this.svg.append("g").classed("axis", true).call(xAxis);
        this.svg.append("g").classed("axis", true).call(yAxis);

        // define area chart parameters
        var area = this.d3.area()
          .curve(this.d3.curveBasis)
          .defined(d => !isNaN(d))
          .x((d, i) => x(days[i]))
          .y0(0)
          .y1(d => z(d))

        // append g for each ridgeline/site_no
        const group = this.svg.append("g").classed("ridge", true)
          .selectAll("g")
          .data(data_nest)
          .join("g")
            .attr("transform", d => `translate(0,${y(d.key) + 1})`);

        group.append("path")
          .attr("fill", "#ddd")
          .attr("d", d => area(d.mmd));
      }
    }
}
</script>
<style lang="scss" scoped>
#mmd-gifs, #swe-gifs {
  max-height: 80vh;
  width: auto;
}
.gage {
  color:black;
  opacity: .6;

}
.maxWidth {
  max-width:90vw;
}

</style>