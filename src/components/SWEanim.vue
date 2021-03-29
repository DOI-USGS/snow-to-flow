<template>
  <!---VizSection-->
  <VizSection id="firstSection">
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>Changing snow in the west can have enormous impacts on water availability.</h2>
    </template>
    <!-- EXPLANATION -->
    <template v-slot:aboveExplanation>
      <p>
        The differences between a high a low snow year illustrate the downstream effects of changing snow on water resources. For example, in 2011 snowmelt occurred ## days later than 2012.
        This was because of differences in the amount of snowpack between years - in 2011 peak SWE was  2x higher.  there were considerable difference in the magnitude of SWE and subsequently discharge at the shown locations in the Upper Colorado river basin.
        With 2 times higher snowpack shown int he line chart. 
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
            viewBox="-50 -50 600 550"
            aria-labelledby="page-title page-desc"
            width="100%"
          >

            <text
              x="90"
              y="470"
            >High snow year</text>
            <text
              x="350"
              y="470"
            >Low snow year</text>
          </svg>
        </div>
        <div class="compare">
        <div class="btn-group" data-toggle="buttons">
                  <h4 class="butt-head" >Compare streamflow: 
  <input class="butt" id="rb1" type="radio" name="radiogroup1" checked=true >
    <label class="butt" for="rb1">timing</label>
    <input  class="butt" id="rb2" type="radio" name="radiogroup1">
    <label class="butt" for="rb2">magnitude</label>
    <input class="butt" id="rb3" type="radio" name="radiogroup1">
    <label class="butt" for="rb3">by elevation</label></h4>
</div>
      </div>
      </div>
    </template>
    <!-- FIGURE CAPTION -->
    <template v-slot:figureCaption>
      <p>
        Snow-water equivalent (left) and stream discharge (right) through the 2011 water year in Colorado. Dots on map correspond to hydrographs on the right. 
      </p>
    </template>
    <template v-slot:belowExplanation>
      <p>
        Cheese and biscuits taleggio melted cheese say cheese cheesy feet cheesecake paneer roquefort. Squirty cheese cottage cheese manchego jarlsberg lancashire blue castello fromage frais cottage cheese. Pepper jack.
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
              line: null,
              area: null,
              group: null,
              ridge_o: 0.3,
              site_elev: [],
              site_sp: [],
        

              checkedData: ["mmd"],
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

        // set chart - separate for each year, using 2011 for max values to set the scaless
        self.initRidges(this.svgboth, 'ridge_2011', data.mmd11, data.days, 0, x_long, this.margin, this.height/2-mar);
        self.initRidges(this.svgboth, 'ridge_2012', data.mmd12, data.days, 0, x_long, this.height/2+mar,  this.height);



        // draw both years  adjacent to one another
        //self.drawHydro(this.svgstack, data.mmd11, days, gage_sp, 0, mid-mid*0.1, data.mmd11);
        //self.drawHydro(this.svgstack, data.mmd11, days, gage_sp, mid+mid*0.1, x_long, data.mmd11);

        // apply separate transition to each plot that
        // 1 - collapses or spreads the y axis
        // 2- transitions to width and height of x and z axes
        // 3 - moves the whole chart to a new location

      },
      initRidges(svg, ridge_class, data_nest, days, x_start, x_end,  y_start, y_end){
        const self = this;
        let overlap = 3;

        // x axis - time
        var x = this.d3.scaleLinear()
          .domain([1,365])
          .range([x_start, x_end]);

        // y axis = group for each site
        // this is ordered by snow persistence....in the csv
        var y = this.d3.scaleLinear()
          .domain([25, 0]).nice()
          .range([y_start, y_end])

        /* var y = this.d3.scalePoint()
          .domain(gages.map(d => d.site_no))
          .range([y_start, y_end]) */

        // define & style x &  y axes
        var xAxis = g => g
          .attr("transform", `translate(0,${this.height+5})`)
          .call(this.d3.axisBottom(x)
              .ticks(this.width / 60)
              .tickSizeOuter(0))

        var yAxis = g => g
          .attr("transform", `translate(${0},-2)`)
          .call(this.d3.axisLeft(y).tickSize(0).tickPadding(4))
        // append axes
        svg.append("g").classed("xaxis", true).classed(ridge_class, true).call(xAxis);
        svg.append("g").classed("yaxis", true).classed(ridge_class, true).call(yAxis);

        // define area chart parameters
        this.area = this.d3.area()
          .curve(this.d3.curveBasis)
          .defined(d => !isNaN(d))
          .x((d, i) => x(days[i]))
          .y0(0)
          .y1(d => y(d))
          
        this.line = this.area.lineY1()
          .defined(d => !isNaN(d));
        
        var colorStack = this.d3.scaleOrdinal()
        .domain(["site_6614800", "site_9063900","site_9034900","site_9035500","site_6746095",
            "site_9064000","site_9065500","site_9066200","site_9022000","site_9032100","site_9065100","site_7083000","site_9035700","site_9046490","site_9035900", 
            "site_9024000","site_9358550","site_9025000","site_9066000","site_9074000","site_9026500","site_9032000","site_9051050","site_9025300","site_9067200",
            "site_9066300","site_9047700","site_9067000","site_9132995","site_9134000","site_9306242"])
        .range(["blue", "blue", "blue", "blue", "blue", "dodgerblue", "dodgerblue", "dodgerblue", "dodgerblue", "dodgerblue", 
                "green","green","green","green","green","lightgreen","lightgreen","lightgreen","lightgreen","lightgreen",
                "gold","gold","gold","gold","gold","yellow","yellow","yellow","yellow","yellow"])

      // append g for each ridgeline/site_no
        this.group = svg.append("g")
          .classed(ridge_class, true).classed("curve", true)
          .selectAll("g")
          .data(data_nest)
          .join("g")
          .attr("transform", d => `translate(0,0)`)

/* 
        this.group.append("path")
          .attr("fill", "dodgerblue")
          .attr("d", d => this.area(d.mmd))
          .attr("opacity", 1); //#5C3406", "#C28D3D", "#ECD8A6", "#F0F0E6", "#AADDD6","#2A8C83", "#004439"]
 */
        this.group.append("path")
          .attr("fill", "none")
          .attr("stroke", "dodgerblue")
          .attr("d", d => this.line(d.mmd))
          .attr("stroke-width", "1px")
          .attr("stroke", function(d) { return colorStack(d.key)})
          .attr("class", function(d) { return d.key })
          .classed("ridge", true);

          
        this.y2011 = this.svgboth.selectAll("g.ridge_2011")
        this.y2012 = this.svgboth.selectAll("g.ridge_2012")

          self.stackRidges();
          self.shiftRidges(svg, days);
          self.spreadRidges();

      },
      stackRidges(){

        this.y2011.selectAll("path.ridge")
          .transition()
          .delay(function(d,i) { return i*20 })
          .duration(500)
          .attr("transform", "translate(0," + (this.height/2+(this.height/2)*0.05) + ")" )

      },
      shiftRidges(svg, days){
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

        var y = this.d3.scaleLinear()
          .domain([25, 0]).nice()
          .range([this.margin, this.height])

        var xAxisL = g => g
          .attr("transform", `translate(0,${this.height+5})`)
          .call(this.d3.axisBottom(xhalfL)
              .ticks(this.width / 60)
              .tickSizeOuter(0))

         var xAxisR = g => g
          .attr("transform", `translate(0,${this.height+5})`)
          .call(this.d3.axisBottom(xhalfR)
              .ticks(this.width / 60)
              .tickSizeOuter(0))

        var yAxisTall = g => g
          .attr("transform", `translate(${0},-2)`)
          .call(this.d3.axisLeft(y).tickSize(0).tickPadding(4))

        // transform axes
        this.d3.select(".xaxis.ridge_2011")
        .transition()
        .duration(1000)
        .delay(2000)
        .call(xAxisL);

        this.d3.select(".xaxis.ridge_2012")
        .transition()
        .duration(1000)
        .delay(2000)
        .call(xAxisR);

        this.d3.select(".yaxis.ridge_2012")
        .transition()
        .duration(1000)
        .delay(2000)
        .call(yAxisTall);

        this.d3.select(".yaxis.ridge_2011")
        .transition()
        .duration(1000)
        .delay(2000)
        .call(yAxisTall);

        this.d3.selectAll("g.ridge_2011.curve")
        .transition()
        .delay(2000)
        .duration(1000)
        .attr("transform", "translate(0, 0) scale(.49, 1)")

         this.d3.selectAll("g.ridge_2012.curve")
        .transition()
        .delay(2000)
        .duration(1000)
        .attr("transform", "translate(270, 0) scale(.49, 1)")

      },
      spreadRidges(){
     // spread ridge
        this.d3.selectAll("g.ridge_2011.curve g")
        .transition()
        .delay(3000)
        .duration(1000)
        .attr("transform", function(d, i) { 
          return "translate(0," + (30+i*-10)  + ") scale(1, .9)"
        })

          this.d3.selectAll("g.ridge_2012.curve g")
        .transition()
        .delay(3000)
        .duration(1000)
        .attr("transform", function(d, i) { 
          return "translate(0," + (30+i*-10) + ") scale(1, .9)"
        })

        this.d3.selectAll("g.yaxis g")
        .transition()
        .duration(1000)
        .delay(3000)
        .attr("opacity", 0)
        

        


      },
      drawHydro(svg, data_nest, days, gage_sp, x_start, x_end, data_max){
       const self = this;

        // append g for each ridgeline/site_no
        this.group = svg.append("g").attr("class", function(d) { return d.key })
          .selectAll("g")
          .data(data_nest)
          .join("g")
            .attr("transform", d => `translate(0,${y(d.key) + 1})`);
/* 
        this.group.append("path")
          .attr("fill", function(d) { return colorStack(d.key)}) //function(d) { return colorStack(d.key)}
          .attr("d", d => self.area(d.mmd))
          .attr("opacity", this.ridge_o); //#5C3406", "#C28D3D", "#ECD8A6", "#F0F0E6", "#AADDD6","#2A8C83", "#004439"] */

        // this adds swe to the same chart

        this.group.append("path")
          .attr("fill", "none")
          .attr("stroke",function(d) { return colorStack(d.key)})
          .attr("d", d => self.line(d.mmd))
          .attr("stroke-width", "1.5px");

        // add swe
         var z_swe = this.d3.scaleLinear()
          .domain([0, this.d3.max(data_max, d => this.d3.max(d.swe)/2)]).nice()
          .range([0, -overlap * y.step()])
          
        this.area_swe = this.d3.area()
          .curve(this.d3.curveBasis)
          .defined(d => !isNaN(d))
          .x((d, i) => x(days[i]))
          .y0(0)
          .y1(d => z_swe(d))


/*          this.group.append("path")
          .attr("fill", "grey")
          .attr("d", d => this.area_swe(d.swe))
          .attr("opacity", this.ridge_o); //#5C3406", "#C28D3D", "#ECD8A6", "#F0F0E6", "#AADDD6","#2A8C83", "#004439"] 
 */
          this.group.append("path")
          .attr("fill", "none")
          .attr("stroke", "grey")
          .attr("d", d => this.line_swe(d.swe))
          .attr("stroke-width", "1px"); 
 
    }
    },
    toggle() {
   this.isActive = !this.isActive;
  },
}
</script>
<style lang="scss" scoped>

.gage {
  color:black;
  opacity: .6;

}
.maxWidth {
  width: 90vw;
  max-width: 700px;
  margin: auto;
}
input {
  margin-left: 20px;
  margin-right: 5px;
  display: inline-block;
}
.compare {
  border: 2px solid black;
  display: inline-block;
  font-size: 18px;
  text-align: center;
    padding: 5px 10px;
}

.butt {
  padding: 5px 10px;
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
        border: 7px solid orchid;
        background-color: orchid;
        color: white;
    }
</style>