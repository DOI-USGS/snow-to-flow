<template>
    <div id="swe-chart-container">
        <svg id="swe-chart">
            <g id="title">
               <text
                    class="demo-text"
                    x="20"
                    y="35"
                    >
                    words!
                </text>
            </g>
        </svg>
    </div>
</template>

<script>
import * as d3 from 'd3';


export default {
    name: "LineChart",
   
    data() {
        return {
            publicPath: process.env.BASE_URL, // this is need for the data files in the public folder, this allows the application to find the files when on different deployment roots
            d3: null,
            svg: null, // not sure
            width: null,
            height: null,
            margin: { top: 10, right: 50, bottom: 10, left: 50 },
            timeFormat: "%Y",
            x: null,
            y: null,

            // animation elements
            duration: 1000 // 1 second

        };
    },
    mounted (){
        this.d3 = Object.assign(d3);
        
        //insert resize here
        this.width = window.innerWidth - this.margin.left - this.margin.right;
        this.height = window.innerHeight*.5 - this.margin.top - this.margin.bottom;

        // load data
        this.loadData();
    },
    methods: {
        loadData() {
            const self=this;

            let promises = [self.d3.csv(self.publicPath + "data/swe_and_discharge_data.csv", this.d3.autoType)]
            Promise.all(promises).then(self.callback);
        },
        callback(data){
            const self=this;
            this.sweAndDischarge = data[0];
            console.log(this.sweAndDischarge, "swe and discharge data!")
            console.log(this.width, this.height, "heh?")
            // set chart defaults

            // draw the chart
            this.initChart();
        }, 
        initChart() {
            const self=this;

            console.log(this.sweAndDischarge, "aaaand we can access the data from here too yay!")

            this.svg = this.d3.select("#swe-chart")
                .attr("width", this.width)
                .attr("height", this.height);

            // initialize x axis
            this.x = this.d3.scaleTime().range(0,this.width);
            this.xAxis = this.d3.axisBottom(this.x).tickFormat(this.d3.timeFormat(this.timeFormat));
            this.svg.append("g")
                .attr("transform", `translate(0,${this.height-50})`)
                .attr("class","xAxis");

            // initialize Y axis
            this.y = d3.scaleLinear().range([this.height, 0]);
            this.yAxis = this.d3.axisBottom(this.y);
            this.svg.append("g")
                .attr("class","yAxis");
            
            this.drawChart();
        },
        drawChart() {
            console.log(this.sweAndDischarge, "what about here?")

            // do something to select data and process time
            let filteredData = this.sweAndDischarge;

            // add a date object to each date in the array
            let parseTime = this.d3.timeParse("%m/%d/%Y");
            filteredData.forEach(function(day){
                day.dateObj = parseTime(day.date);
            })

            // // compute the date range
            // let dates = filteredData.map(function(day){
            //     return day.dateObj;
            // })

            console.log(this.width, "this.x")
                
            // populate the x axis
            this.x.domain(this.d3.extent(filteredData, function(d) { return d.dateObj; })); // calculates min and max of the array of possible dates in the filtered dataset
            this.svg.selectAll(".xAxis").transition()
                .duration(this.duration)
                .call(this.xAxis);

        }
    }
}
</script>

<style scoped>
    #swe-chart {
        background-color: coral;
    }

 
</style>

