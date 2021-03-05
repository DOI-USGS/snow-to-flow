<template>
    <div id="swe-chart-container">
        <svg id="swe-chart">
            <g id="title">
               <text
                    class="demo-text"
                    x="20"
                    y="35"
                    >
                    lines!
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
            margin: { top: 50, right: 50, bottom: 50, left: 50 },
            timeFormat: "%B",
            x: null,
            y: null,
            selectedYear: null, // this can be selected by a button

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
            this.initChart(this.sweAndDischarge);
        }, 
        initChart(data) {
            const self=this;
            console.log(data, "aaaand we can access the data from here too yay!")

            // Set dimensions of SVG for chart
            this.svg = this.d3.select("#swe-chart")
                .attr("width", this.width)
                .attr("height", this.height);

             // add a date object to each date in the array
            let parseTime = this.d3.timeParse("%m/%d/%Y");
        
            // make a copy of the dataset for editing
            data.forEach(function(day){
                    day.dateObj = parseTime(day.date);
                })
    
            let filteredData = data.filter(function(day){
                return day.dateObj.getFullYear() === 2011 // make this a variable selected by interaction
            })

            console.log(filteredData, "what about here?")

            

            // create data accessors, haven't implemented them yet
            const yAccessor = (d) => parseInt(d.SWEin); 
            const xAccessor = (d) => parseTime(d.dateObj);            
            
                
            // Create X Axis
            this.xScale = this.d3.scaleTime()
                .domain(this.d3.extent(filteredData, function(d) { return d.dateObj; })) // calculates min and max of the array of possible dates in the filtered dataset
                .range([0,this.width-this.margin.left-this.margin.right]);
            this.xAxis = this.d3.axisBottom(this.xScale).tickFormat(this.d3.timeFormat(this.timeFormat));
            this.svg.append("g")
                .attr("transform", `translate(${this.margin.left},${this.height-this.margin.top})`)
                .attr("class","xAxis");       
            this.svg.selectAll(".xAxis")
                .transition()
                .duration(this.duration)
                .call(this.xAxis);


            // Create Y Axis
            this.yScale = this.d3.scaleLinear()
                .domain(this.d3.extent(filteredData, function(d) { return d.SWEin; }))
                .range([this.height-this.margin.bottom, this.margin.top]);
            this.yAxis = this.d3.axisLeft(this.yScale);
            this.svg.append("g")
                .attr("transform", `translate(${this.margin.left},0)`)
                .attr("class","yAxis");   
            this.svg.selectAll(".yAxis")
                .transition()
                .duration(this.duration)
                .call(this.yAxis);    

            // Create Second Y Axis for Discharge
            this.yScaleDisch = this.d3.scaleLinear()
                .domain(this.d3.extent(filteredData, function(d) { return d.discharge; }))
                .range([this.height-this.margin.bottom, this.margin.top]);
            this.yAxisDisch = this.d3.axisRight(this.yScaleDisch);
            this.svg.append("g")
                .attr("transform", `translate(${this.width-this.margin.right},0)`)
                .attr("class","yAxisDisch");   
            this.svg.selectAll(".yAxisDisch")
                .transition()
                .duration(this.duration)
                .call(this.yAxisDisch);    
               
            // Create an update selection: bind to the data
            let lineGroup = this.svg.append("g")
                .attr("class","line-group")
                .attr("transform", `translate(${this.margin.left},0})`);
            
            // create groups for each line
            let groupedData = [{
                key: "discharge",
                values: []
                },{
                key: "SWEin",
                values: []
                }
            ];
            filteredData.forEach(function (day){
                var todaysDischarge = {
                    dateObj: day.dateObj,
                    n: day.discharge
                }
                var todaysSWE = {
                    dateObj: day.dateObj,
                    n: day.SWEin
                }
                // groupedData[0].values.push(todaysDischarge);
                groupedData[1].values.push(todaysSWE);
            })        
  
            // Update Line
            lineGroup.selectAll(".line")
                .data(groupedData)
                .enter()
                .append("path")
                    .attr("class","line")
                    .attr("fill", "none")
                    .attr("stroke", "white")
                    .attr("stroke-width", 1) 
                    .attr("d", function(d){
                        return d3.line()
                            // .curve(this.d3.curveMonotoneX)
                            .x(function(d) { return self.xScale(d.dateObj)})
                            .y(function(d) { return self.yScale(d.n)})
                            (d.values)
                    });
                // .merge()
                // .transition()
                // .duration(this.duration);
                 console.log("what's happening??!");
            // add annotation
            
            // find date of peak swe
           
            // let peakSWE = filteredData.reduce((acc, day) => {
            //     return acc + day.SWEin;
            // });
            let peakSWE = Math.max.apply(Math.filteredData.map(function(o){return o.SWEin;}));
            console.log(peakSWE,"Peak")
            

        }
    }
}
</script>

<style scoped>
    #swe-chart {
        background-color: coral;
    }

    .line {
        stroke: black;
        stroke-width: 2px;
    }

 
</style>

