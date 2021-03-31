<template>
  <!---VizSection-->
  <VizSection id="firstSection">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <!-- <h2>Changing snow in the west can have enormous impacts on water availability.</h2> -->
    </template>
    <!-- EXPLANATION -->
    <template v-slot:aboveExplanation>
      <p>
         The differences between a high a low snow year illustrate the downstream effects of changing snow on water resources. For example, between 2011 and 2012 there was a two-fold difference in snowpack in some parts of the Upper Colorado River Basin which corresponded to differences in the timing of snowmelt and water availability downstream. 
      </p>
    </template>
    <!-- FIGURES -->
    <template v-slot:figures>
      <div
        id="figs"
        class="single one maxWidth"
      >
        <!-- <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 -50 600 500">
      
          <text
            x="50"
            y="25"
          >Snow-water equivalent (SWE) 2011-2012</text>
          <path transform="scale(1.19) translate(0, -25)" d="M429,141l-.32.44L430,172.61l0,.84,1.05,32,.19,5.9,1.19,26.54.19,5.9.84,26.14L435,308.31l.19,6.32.27,19.4.88,28.25L432,363.66l-9.13.27-12.18.34-15.53.4-8.13.17-7.12-1.09-4.72.5-4.71.94-13.18.23-14.53.24-14.19.18-8.13.09-5.73.06-16.9.13-23.67.1h-26l-8.8,0-12.49-.06-7.1,0-16.9-.17-27.38-.36-7.44-.1-18.24-.34-21.61-1.32-9.82.61-1-.89-5.4-.14-21.62-.61-21-.69-7.1-.26-5.73-.63-11.84,0-13.52-.54-7.1-.3,1.32-46.82,1.09-17.26.59-21.1L27.91,249l2.79-62.82L30.83,176l.84-11.38,1.91-41.74,1.47-32L36.52,66l-.34.4,63.33.42,34.18,1,25.22,1,29.35.94,7,.11-.32-.42,51.42.86,19.15-.4,49.18.15,27.15-.38,11.17-.19,39.93-.9,2.23-.07,31-.52.63,18.56L426.62,90l.35.82.3,18.56.23,6.76Z" style="fill: none;stroke: #000;stroke-linejoin: round;stroke-width: 2.246646621121159px"/>
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
        
        </svg> -->
        <div id="mmd-container-both">
          <svg
            id="mmd-line-both"
            xmlns="http://www.w3.org/2000/svg"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            viewBox="-50 -50 600 500"
            aria-labelledby="page-title page-desc"
            width="100%"
            height="auto"
          >

            <text
              id="melt11"
              class="yr-label"
              x="200"
              y="20"
            >later and <tspan x="200" y="40px">faster melt</tspan></text>
            <text
              id="melt12"
              class="yr-label"
              x="300"
              y="290"
            >earlier and <tspan x="300" y="310px">longer melt</tspan></text>

            <text
              id="peak11"
              class="yr-label"
              x="80"
              y="230"
            >high snow</text>
            <text
              id="peak12"
              class="yr-label"
              x="350"
              y="320"
            >low snow</text>
            
            <text
              id="el11"
              class="yr-label"
              x="20"
              y="20"
            >high elevation</text>
            <text
              id="el12"
              class="yr-label"
              x="-20"
              y="390"
            >low</text>
          </svg>
        </div>
        <div class="compare">
          <div
            class="btn-group"
            data-toggle="buttons"
          >
            <h4 class="butt-head">
              Compare streamflow: 
            </h4> 
            <div class="inputsContainer">
              <div class="inputs">
                <input
                  id="rb1"
                  class="butt"
                  type="radio"
                  name="radiogroup1"
                  checked="true"
                  value="time"
                  @change="changePos"
                >
                <label
                  class="butt"
                  for="rb1"
                >timing</label>
                <input
                  id="rb2"
                  class="butt"
                  type="radio"
                  name="radiogroup1"
                  value="peak"
                  @change="changePos"
                >
                <label
                  class="butt"
                  for="rb2"
                >magnitude</label>
                <input
                  id="rb3"
                  class="butt"
                  type="radio"
                  name="radiogroup1"
                  value="el"
                  @change="changePos"
                >
                <label
                  class="butt"
                  for="rb3"
                >by elevation</label>
              </div>
            </div>
          </div>
        </div>
      </div>
    </template>
    <!-- FIGURE CAPTION -->
    <template v-slot:figureCaption>
      <p>
        Use the toggles to compare the timing and magnitude of snow-to-flow between a high and a low snow year at a selection of sites across an elevational range.  
      </p>
    </template>
    <template v-slot:belowExplanation>
      <p>
        These dynamics are complex and intertwined with other factors that vary with elevation, like snow persistence, Y, & Z. This is why the USGS is pursuing research that looks at XYZ...[plug for current monitoring and modeling directions goes here, include links to any pages of related  programs, cite any recent papers].
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
              isActive: false,
              title: process.env.VUE_APP_TITLE,
              publicPath: process.env.BASE_URL,
              d3: null,
              mmd_2011: null,
              mmd_2012: null,
              svg: null,
              width: 600,
              height: 400,
              margin: 25,

              line_swe: null,
              area_swe: null,
              line_mmd: null,
              area_mmd: null,
              group: null,
              ridge_o: 0.3,
              site_elev: [],
              site_sp: [],
              tickDates: ["Oct", "Jan", "Apr", "July"],
              highlabel: null,
              lowlabel: null,
              xAxis: null,
              yAxis_mmd: null,
              yAxis_swe: null,
              x11: null,
              x12: null,
              y11_swe: null,
              y12_swe: null,
              y11_mmd: null,
              y12_mmd: null,
              ridge11:null,
              ridge12: null,

              color_mmd: "dodgerblue",
              color_swe: "grey",

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
        let promises = [self.d3.csv(self.publicPath + "data/gage_sp.csv",  this.d3.autotype),
        self.d3.csv(self.publicPath + "data/mmd_df_2011.csv",  this.d3.autotype),
        self.d3.csv(self.publicPath + "data/mmd_df_2012.csv",  this.d3.autotype),
        self.d3.csv(self.publicPath + "data/swe_df_2011.csv",  this.d3.autotype),
        self.d3.csv(self.publicPath + "data/swe_df_2012.csv",  this.d3.autotype)];

        Promise.all(promises).then(self.callback); 
      },
      callback(data) {
        const  self  = this;

        // same data served up 2 ways
        var gage_sp = data[0]; // snow persistence for gages
        var data_2011 = data[1]; // mmd
        var data_2012 = data[2]; // mmd
        var swe_2011 = data[3]; // swe
        var swe_2012 = data[4]; // swe

        // prep data for plotting
        var sites = data_2011.columns // array of all site_no - each gets a ridge
        sites.shift(); // drop first column
        var n = sites.length;

        // sort gages by elevation
        this.site_elev = gage_sp.slice().sort((a,b) => this.d3.ascending(a.elev, b.elev)).map(function(d) { return d.site_no })

        //sort ages by snow persistence
        this.site_sp = gage_sp.slice().sort((a,b) => this.d3.ascending(a.sp, b.sp)).map(function(d) { return d.site_no })

        // nest data to iterate over in plot
        // sort of inverse of series - array of objects where objs = site containing key  for site_no, mmd and day vars
         data.mmd11 = [];
          for (i = 1; i < n; i++) {
              var key = this.site_elev[i];
              var mmd = data_2011.map(function(d){  return d[key]; });
              var swe = swe_2011.map(function(d){  return d[key]; });
              var day = data_2011.map(function(d){  return d['site_water_day']; });
              data.mmd11.push({key: key, mmd: mmd, day:day, swe:swe})
          };

          data.mmd12 = [];
          for (i = 1; i < n; i++) {
              var key = this.site_elev[i];
              var mmd = data_2012.map(function(d){  return d[key]; });
              var swe = swe_2012.map(function(d){  return d[key]; });
              var day = data_2012.map(function(d){  return d['site_water_day']; });
              data.mmd12.push({key: key, mmd: mmd, day:day, swe:swe})
          };

        data.days = data_2011.map(function(d) { return  d['site_water_day']}) // array of j days for good luck

        // set up g that holds ridgelines
        this.svgboth = this.d3.select('svg#mmd-line-both');
        this.svgstack = this.d3.select('svg#mmd-line-stack');

         // draw hydro chart elements
        var x_long = this.width-(this.margin*3);
        var mid = x_long/2;
        var mar = mid*0.05

        // set chart - separate for each year, using 2011 for max values to set the scales
        //  first draw is MMD
        self.initRidges(this.svgboth, 'ridge_2011', data.mmd11, data.days, 0, x_long, 0, this.height/2);
        self.initRidges(this.svgboth, 'ridge_2012', data.mmd12, data.days, 0, x_long, this.height/2,  this.height);

      },
      initRidges(svg, ridge_class, data_nest, days, x_start, x_end,  y_start, y_end){
        const self = this;

        // x axis - time
        var x = this.d3.scaleLinear()
          .domain([1,365])
          .range([x_start, x_end]);

        // y mmd
        var y_mmd = this.d3.scaleLinear()
          .domain([30, 0]).nice()
          .range([y_start, y_end])

          // y swe
        var y_swe = this.d3.scaleLinear()
          .domain([1100, 0]).nice()
          .range([y_start, y_end])

        // define & style x &  y axes
        this.xAxis = g => g
          .attr("transform", `translate(0,${y_end})`)
          .call(this.d3.axisBottom(x)
              .tickValues([1, 93, 183, 273])
              .tickFormat(function(d,i) { return self.tickDates[i] })
              .tickSizeOuter(0).tickSize(0))

      // mmd axes
        this.yAxis_mmd = g => g
          .attr("transform", `translate(${this.width-75},0)`)
          .call(this.d3.axisRight(y_mmd).tickSize(0).tickPadding(4).tickValues([0, 10, 20, 30]))

          // mmd axes
        this.yAxis_swe = g => g
          .attr("transform", `translate(${0},0)`)
          .call(this.d3.axisLeft(y_swe).tickSize(0).tickPadding(4).tickValues([0, 250, 500, 750, 1000]))

        // append axes
        svg.append("g").classed("xaxis", true).classed(ridge_class, true).call(this.xAxis).attr("font-style", "italic");
        svg.append("g").classed("yaxis", true).classed(ridge_class, true).call(this.yAxis_mmd).attr("font-style", "italic").attr("color", this.color_mmd).classed("mmd", true);
        svg.append("g").classed("yaxis", true).classed(ridge_class, true).call(this.yAxis_swe).attr("font-style", "italic").attr("color", this.color_swe).classed("swe", true);

        // define area chart parameters
        this.area_mmd = this.d3.area()
          .curve(this.d3.curveBasis)
          .defined(d => !isNaN(d))
          .x((d, i) => x(days[i]))
          .y0(0)
          .y1(d => y_mmd(d))

        this.area_swe = this.d3.area()
          .curve(this.d3.curveBasis)
          .defined(d => !isNaN(d))
          .x((d, i) => x(days[i]))
          .y0(0)
          .y1(d => y_swe(d))
          
        this.line_mmd = this.area_mmd.lineY1()
          .defined(d => !isNaN(d));

        this.line_swe = this.area_swe.lineY1()
          .defined(d => !isNaN(d));

      // append g for each ridgeline/site_no
        this.group = svg.append("g")
          .classed(ridge_class, true).classed("curve", true)
          .selectAll("g")
          .data(data_nest)
          .join("g")
          .attr("transform", d => `translate(0,0)`)

        // draw MMD curves
        this.group.append("path")
          .attr("fill", "none")
          .attr("stroke", this.color_mmd)
          .attr("d", d => this.line_mmd(d.mmd))
          .attr("stroke-width", "1px")
          .attr("stroke", this.color_mmd)
          .attr("opacity", 0.7)
          .attr("class", function(d) { return d.key })
          .classed("ridge", true)
          .classed("mmd", true);

         // draw SWE curves
        this.group.append("path")
          .attr("fill", "none")
          .attr("stroke", this.color_swe)
          .attr("d", d => this.line_swe(d.swe))
          .attr("stroke-width", "1px")
          .attr("stroke", this.color_swe)
          .attr("opacity", 0.7)
          .attr("class", function(d) { return d.key })
          .classed("ridge", true)
          .classed("swe", true);

        this.y2011 = this.svgboth.selectAll("g.ridge_2011") // ridge group
        this.y2012 = this.svgboth.selectAll("g.ridge_2012")
        this.ridge11 = this.d3.selectAll("g.ridge_2011.curve g") // ridge themselves for staggered animation
        this.ridge12 = this.d3.selectAll("g.ridge_2012.curve g") 

        this.highlabel = this.svgboth.select("text#peak11") // high and low snow labels
        this.lowlabel = this.svgboth.select("text#peak12")
        this.highel = this.svgboth.select("text#el11") // high and low snow labels
        this.lowel = this.svgboth.select("text#el12")
        this.fast = this.svgboth.select("text#melt11") // high and low snow labels
        this.slow = this.svgboth.select("text#melt12")    

        this.y11_swe = this.d3.select(".yaxis.ridge_2011.swe") // axes
        this.y12_swe = this.d3.select(".yaxis.ridge_2012.swe")
        this.y11_mmd = this.d3.select(".yaxis.ridge_2011.mmd") // axes
        this.y12_mmd = this.d3.select(".yaxis.ridge_2012.mmd")
        this.x11 = this.d3.select(".xaxis.ridge_2011")
        this.x12 = this.d3.select(".xaxis.ridge_2012")

        this.lowlabel.transition().duration(0).attr("opacity",0)
        this.highlabel.transition().duration(0).attr("opacity",0)
        this.lowel.transition().duration(0).attr("opacity",0)
        this.highel.transition().duration(0).attr("opacity",0)
        this.slow.transition().duration(0).attr("opacity",1)
        this.fast.transition().duration(0).attr("opacity",1)

      },
      changePos(){
        const self = this;
          if(event.target.value == "peak"){
            self.toMagnitude()
          }
          if(event.target.value == "time"){
            self.toTiming();
          }
           if(event.target.value == "el"){
            self.toMagnitude()
            self.toElevation();
          }
      },
      transPosition(el, delay, duration, x, y, xscale, yscale){
        el
        .transition()
          .delay(delay)
          .duration(duration)
          .attr("transform", "translate(" + (x) + ", " + (y) + ") scale(" + xscale + "," + yscale + ")")

      },
      transFade(el, delay, duration, alpha){
       el
        .transition()
        .duration(duration)
        .delay(delay)
        .attr("opacity", alpha)
      },
      transAxis(el, delay, duration, axis, x, y, xscale, yscale){
        el
        .transition()
        .duration(duration)
        .delay(delay)
        .call(axis)
        .attr("transform", "translate(" + (x) + ", " + (y) + ") scale(" + xscale + "," + yscale + ")" )

      },
      toTiming(){
        const self = this;
        
        // fade in y axis
        self.transFade(this.d3.selectAll("g.yaxis g"), 300, 500, 1)

        // make sure ridges are stacked flat
        this.y2011.selectAll("path.ridge")
          .transition()
          .delay(function(d,i) { return i*15 })
          .duration(1100)
          .attr("transform", "translate(0," + (0) + ")" )

        // move labels
        //self.transPosition(self.lowlabel, 600, 800, 0, 0, 1, 1)
        //self.transPosition(self.highlabel, 700, 700, 0, 0, 1, 1)

        this.lowlabel.transition().delay(100).duration(300).attr("opacity",0)
        this.highlabel.transition().delay(100).duration(300).attr("opacity",0)
        this.lowel.transition().delay(100).duration(300).attr("opacity",0)
        this.highel.transition().delay(100).duration(300).attr("opacity",0)
        this.slow.transition().delay(100).duration(300).attr("opacity",1)
        this.fast.transition().delay(100).duration(300).attr("opacity",1)

        // transform axes
        self.transAxis(this.x11, 350, 300, self.xAxis, 0, this.height/2, 1, 1)
        self.transAxis(this.x12, 250, 500, self.xAxis, 0, this.height, 1, 1)
        self.transAxis(this.y11_swe, 350, 300, self.yAxis_swe, 0, -this.height/2, 1, 1)
        self.transAxis(this.y12_swe, 250, 500, self.yAxis_swe, 0, 0, 1, 1)
        self.transAxis(this.y11_mmd, 350, 300, self.yAxis_mmd, this.width-75, -this.height/2, 1, 1)
        self.transAxis(this.y12_mmd, 250, 500, self.yAxis_mmd, this.width-75, 0, 1, 1)

        // stretch ridges to full x and y extent
        self.transPosition(this.d3.selectAll("g.ridge_2011.curve"), 270, 500,  0, 0, 1, 1)
        self.transPosition(this.d3.selectAll("g.ridge_2012.curve"), 250, 500,  0, 0, 1, 1)

        // un-spread ridge
        this.ridge11
        .transition()
        .delay(function(d,i) { return i*15 })
        .duration(400)
        .attr("transform", function(d, i) { 
          return "translate(0," + (0+i*0)  + ")"
        })

        this.ridge12
        .transition()
        .delay(function(d,i) { return i*15 })
        .duration(400)
        .attr("transform", function(d, i) { 
          return "translate(0," + (0) + ")"
        })


      },
      toMagnitude(){
        const self = this;
        
        self.shiftRidges();

        // flatten stacks
        this.y2011.selectAll("path.ridge")
          .transition()
          .delay(function(d,i) { return i*15 })
          .duration(1100)
          .attr("transform", "translate(0," + (this.height/2) + ")" )

        this.ridge11
        .transition()
        .delay(200)
        .duration(400)
        .attr("transform", function(d, i) { 
          return "translate(0," + (0+i*0)  + ") scale(1, 1)"
        })

        this.ridge12
        .transition()
        .delay(200)
        .duration(400)
        .attr("transform", function(d, i) { 
          return "translate(0," + (0) + ") scale(1, 1)"
        })

        // y mmd
        var y_mmd = this.d3.scaleLinear()
          .domain([30, 0]).nice()
          .range([this.height/2, this.height])

          // y swe
        var y_swe = this.d3.scaleLinear()
          .domain([1100, 0]).nice()
          .range([this.height/2, this.height])

      // mmd axes
        var y_mmd_low = g => g
          .attr("transform", `translate(${this.width-75},0)`)
          .call(this.d3.axisRight(y_mmd).tickSize(0).tickPadding(4).tickValues([0, 10, 20, 30]))

          // mmd axes
        var y_swe_low = g => g
          .attr("transform", `translate(${0},0)`)
          .call(this.d3.axisLeft(y_swe).tickSize(0).tickPadding(4).tickValues([0, 250, 500, 750, 1000]))
        
        // move labels
        //self.transPosition(self.lowlabel, 600, 800, 310, -50, 1,1)
        //self.transPosition(self.highlabel, 700, 700, 80, 40, 1, 1)  
        self.transFade(this.d3.selectAll("g.yaxis g"), 300, 500, 1)

         // transform axes
        self.transAxis(this.y11_mmd, 450, 500, y_mmd_low, this.width-75,0, 1, 1)
        self.transAxis(this.y12_mmd, 450, 500, y_mmd_low,this.width-75, 0,1, 1)
        self.transAxis(this.y11_swe, 450, 500, y_swe_low, 0, 0, 1, 1)
        self.transAxis(this.y12_swe, 450, 500, y_swe_low, 0, 0, 1, 1) 


/*         this.y11_mmd.transition().duration(100).attr("opacity", 0)
         this.y12_mmd.transition().duration(100).attr("opacity", 0) */


        this.lowlabel.transition().delay(100).duration(300).attr("opacity",1)
        this.highlabel.transition().delay(100).duration(300).attr("opacity",1)
        this.lowel.transition().delay(100).duration(300).attr("opacity",0)
        this.highel.transition().delay(100).duration(300).attr("opacity",0)
        this.slow.transition().delay(100).duration(300).attr("opacity",0)
        this.fast.transition().delay(100).duration(300).attr("opacity",0)

      },
      toElevation(){
        const self = this;

        // spread ridges
        this.ridge11
        .transition()
        .delay(300)
        .duration(500)
        .attr("transform", function(d, i) { 
          return "translate(0," + (40+i*-10)  + ") scale(1, .9)"
        })

        this.ridge12
        .transition()
        .delay(300)
        .duration(500)
        .attr("transform", function(d, i) { 
          return "translate(0," + (40+i*-10) + ") scale(1, .9)"
        })

        //var color = this.d3.interpolateRainbow;

        // make bigger axes
         var y = this.d3.scaleLinear()
          .domain([25, 0]).nice()
          .range([0, this.height])

        var yAxisTall = g => g
          .attr("transform", `translate(${0},0)`)
          .call(this.d3.axisLeft(y).tickSize(0).tickPadding(4))

        // move labels
        //self.transPosition(self.highlabel, 350, 600, 20, -100, 1, 1)
        //self.transPosition(self.lowlabel, 450, 500, 320, -300, 1, 1)
        this.lowlabel.transition().delay(100).duration(300).attr("opacity",0)
        this.highlabel.transition().delay(100).duration(300).attr("opacity",0)
        this.lowel.transition().delay(100).duration(300).attr("opacity",1)
        this.highel.transition().delay(100).duration(300).attr("opacity",1)
        this.slow.transition().delay(100).duration(300).attr("opacity",0)
        this.fast.transition().delay(100).duration(300).attr("opacity",0)

       // transform axes
        self.transAxis(this.y11_swe, 350, 500, self.yAxis_swe, 0, -100, 1, 1)
        self.transAxis(this.y12_swe, 350, 500, self.yAxis_swe, 0, 0, 1, 1) 
        self.transAxis(this.y11_mmd, 350, 500, self.yAxis_mmd, this.width-75, -100, 1, 1)
        self.transAxis(this.y12_mmd, 350, 500, self.yAxis_mmd, this.width-75, 0, 1, 1) 

        self.transFade(this.d3.selectAll("g.yaxis g"), 300, 400, 0)
      },
      shiftRidges(){
        const self = this;
        var x_long = this.width-(this.margin*3);
        var mid = x_long/2;
        var mar = mid*0.05

        var xhalfL = this.d3.scaleLinear()
          .domain([1,365])
          .range([0, mid-5]);

        var xhalfR = this.d3.scaleLinear()
          .domain([1,365])
          .range([mid+5, x_long]);

        
        var xAxisL = g => g
          .attr("transform", `translate(0,${this.height})`)
          .call(this.d3.axisBottom(xhalfL)
              .tickValues([1, 93, 183, 273])
              .tickFormat(function(d,i) { return self.tickDates[i] })
              .tickSizeOuter(0).tickSize(0))

         var xAxisR = g => g
          .attr("transform", `translate(0,${this.height})`)
          .call(this.d3.axisBottom(xhalfR)
              .tickValues([1, 93, 183, 273])
              .tickFormat(function(d,i) { return self.tickDates[i] })
              .tickSizeOuter(0).tickSize(0))

   // transform axes
        self.transAxis(this.x11, 350, 400, xAxisL, 0, this.height, 1, 1)
        self.transAxis(this.x12, 250, 500, xAxisR, 0, this.height, 1, 1)
         /*    self.transAxis(this.y11_swe, 350, 500, self.yAxis_swe, 0, this.height/2, 1, 1)
        self.transAxis(this.y12_swe, 350, 400, self.yAxis_swe, 0, 0, 1, 1)
        self.transAxis(this.y11_mmd, 350, 500, self.yAxis_mmd, this.width-75, this.height/2, 1, 1)
        self.transAxis(this.y12_mmd, 350, 400, self.yAxis_mmd, this.width-75, 0, 1, 1) */

        this.d3.selectAll("g.ridge_2011.curve")
        .transition()
        .delay(270)
        .duration(500)
        .attr("transform", "translate(0, 0) scale(.49, 1)")

         this.d3.selectAll("g.ridge_2012.curve")
        .transition()
        .delay(250)
        .duration(500)
        .attr("transform", "translate(270, 0) scale(.49, 1)")

      }
    }
}
</script>
<style lang="scss" scoped>

.gage {
  color:black;
  opacity: .6;

}
.maxWidth {
  width: 90vw;
  margin-left: 5vw;
  max-width: 700px;
  margin: auto;
}

.compare {
  border: 2px solid black;
  display: inline-block;
  font-size: 18px;
  text-align: center;
  padding: 15px 10px;
  margin: auto;
  position: relative;
  h4{
    margin-bottom: 15px;
  }
}
.butt {
  padding: 5px 10px;
}
.yr-label {
  font-size: 16px;
  font-weight: 700;
  text-anchor: middle;
  font-style: italic;
  fill: rgb(165, 163, 163);
}
input[name="radiogroup1"] {
            display: none;
        }
         input[name="radiogroup1"]+label {
            /* style passive state as you like */
            border: 2px solid transparent;
            color: black;
            font-weight: 400;
        }

    input[name="radiogroup1"]:checked+label {
        /* style checked state as you like */
        border: 7px solid dodgerblue;
        background-color: dodgerblue;
        color: white;
    }
@media screen and (min-width: 650px){
  .compare{
    width: 100%;
    max-width: 570px;
    padding: 5px 5px;
    .btn-group{
      display: flex;
      align-items: center;
      .inputsContainer{
        flex: 2;
        position: relative;
        display: flex;
        align-items: center;
        justify-content: space-between;
        .inputs{
          position: absolute;
          left: 10px;
          .butt{
            margin-right: 25px;
          }
          .butt:last-child{
            margin-right: 0;;
          }
        }
      }
      h4{
        flex: 1;
        margin-bottom: 0;
      }
    }
  } 
}
</style>