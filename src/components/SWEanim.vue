<template>
  <!---VizSection-->
  <VizSection id="firstSection">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>snow >> flow</h2>
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
      >
        <svg
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
            y="40"
          >Snow-water equivalent (SWE)</text>
        
          <image
            xlink:href="@/assets/SWEanim/co_2011_30fps.gif"
            height="400px"
            x="0"
            y="50"
          />
          <g id="gages_2011" />
        </svg>
        <div id="mmd-container">
          <svg
            id="mmd-line"
            xmlns="http://www.w3.org/2000/svg"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            viewBox="0 0 550 450"
            aria-labelledby="page-title page-desc"
            width="100%"
          >

            <text
              x="0"
              y="40"
            >Discharge</text>
          </svg>
        </div>
      </div>
    </template>
    <!-- FIGURE CAPTION -->
    <template v-slot:figureCaption>
      <p>
        Snow-water equivalent (left) and stream discharge (right) through the 2011 water year in Colorado. Dots on map correspond to hydrographs on the right.
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
              d3: null,
              mmd_2011: null,
              mmd_2012: null,
              svg: null,
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
        let promises = [self.d3.csv(self.publicPath + "data/mmd_df.csv", ({site_no, Date, water_day, mmd}) =>({site_no, Date, water_day, mmd}), this.d3.autotype),
        self.d3.csv(self.publicPath + 'data/gage_mmd_2012.csv'), this.d3.autotype];

        Promise.all(promises).then(self.callback); 
      },
      callback(data) {
        const  self  = this;

        this.mmd_2011 = data[0];
        this.mmd_2012 = data[1];

        console.log(this.mmd_2011)

        this.svg = this.d3.select('svg#mmd-line')
        .append("g")
        .classed("ridges", true)

        this.drawHydro(this.mmd_2011);

      },
      drawHydro(data){
        var width = 550;
        var height = 450;
        var margin = 25;

        const self = this;

        var series = this.d3.nest()
          .key(d => d.site_no)
          .sortValues((a,b) => a.Date - b.Date)
        .entries(data)

        var sites = data.columns
        //var n = sites.length;
        console.log(series)

       var x = this.d3.scaleTime()
          .domain(this.d3.extent(data, d => d.Date))
          .range([ 0, width-(margin*2)]);


        var y = this.d3.scalePoint()
          .domain(series.map(d => d.site_no))
          .range([margin, height - (4*margin)])
        
        var z =  this.d3.scaleLinear()
          .domain([0, this.d3.max(data, d => d.mmd)]).nice()
          .range([0, -8 * y.step()])


          var yName = this.d3.scaleBand()
            .domain(sites)
            .range([0, height-(margin*4)])
            .paddingInner(1)

         this.svg.append("g")
          .attr("transform", "translate(25," + 425 + ")")
          .classed("x-line", true)
          .call(this.d3.axisBottom(x))
          .attr("stroke","black");

          this.svg.append("g")
            .classed("y-line", true)
            .attr("transform", "translate(25," + 75 + ")")
            .call(this.d3.axisLeft(yName));

          let area = this.d3.area()
            .curve(this.d3.curveBasis)
            .defined(d => !isNaN(d))
            .x((d, i) => x(data.Date[i]))
            .y0(0)
            .y1(d => z(d))


        const group = this.svg.append("g")
            .selectAll("g")
            .data(data)
            .join("g")
              .attr("transform", function(d,i) {return `translate(0,`+ i*10 +`)` } );

          group.append("path")
              .attr("fill", "pink")
              .attr("d", d => area(d.mmd));

           group.append("path")
              .attr("fill", "none")
              .attr("stroke", "black")
              .attr("d", d => line(d.mmd)); 

              this.svg.selectAll("areas")
                .data(data)
                .enter()
                .append("path")
                  .attr("transform", function(d){ return("translate(0," + (yName(d.site_no)-height)+")" )})
                  .datum(function(d){return(d.mmd)})
                  .attr("fill", "red")
                  .attr("stroke-width", 1)
                  .attr("d",  d3.line()
                      .curve(d3.curveBasis)
                      .x(function(d) { return x(d[0]); })
                      .y(function(d) { return y(d[1]); })
                  )

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