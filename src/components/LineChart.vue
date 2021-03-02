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
            margin: { top: 50, right: 50, bottom: 50, left: 50 },
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
            this.initChart(this.sweAndDischarge);
        }, 
        initChart(data) {
            const self=this;
            console.log(data, "aaaand we can access the data from here too yay!")

            // Set dimensions of SVG for chart
            this.svg = this.d3.select("#swe-chart")
                .attr("width", this.width)
                .attr("height", this.height);

            // make a copy of the dataset for editing
            let filteredData = data;
            console.log(filteredData, "what about here?")

            // add a date object to each date in the array
            let parseTime = this.d3.timeParse("%m/%d/%Y");
            filteredData.forEach(function(day){
                    day.dateObj = parseTime(day.date);
                })

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
               
            // Create an update selection: bind to the data
            let lineGroup = this.svg.append("g")
                .attr("class","line-group");
            
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
                groupedData[0].values.push(day.discharge);
                groupedData[1].values.push(day.SWEin);
            })

            console.log("groupedData", groupedData);

         
            // Draw the lines
            lineGroup.selectAll(".line")
                .data(groupedData)
                .enter()
                .append("path")
                    .attr("class", "line")
                    .attr("id", function(l) { return l.key; })
                    .attr("fill","none")
                    .attr("stroke","black")
                    .attr("stroke-width", 1.5)
                    .attr("d",function(l) {
                        return this.d3.line()
                            .x(function(d) { return xScale(d.dateObj); })
                            .y(this.height/2)
                    })


            // // Create Line generator
            // let line = this.d3.line() 
            //     .x(function(d) { return this.x(d.dateObj); })
            //     .y(function(d) { return this.y(d.SWEin); })
            //     .curve(this.d3.curveCardinal);

            // // Update Line
            // lineGroup.enter()
            //     .append("path")
            //     .datum(filteredData)
            //     .attr("class","lineTest")
            //     .merge(update)
            //     .transition()
            //     .duration(this.duration)
            //     .attr("d",line)
            //     .attr("fill", "none")
            //     .attr("stroke", "steelblue")
            //     .attr("stroke-width", 2.5) 
        

            // // line generator
            // let line = this.d3.line()
            //     .x(function(d) { console.log(this.xScale(d.dateObj)); return this.xScale(d.dateObj); }) // set the x values for the line generator
            //     .y(function(d) { return this.yScale(d.SWEin); }) // set the y values for the line generator 
            //     .curve(this.d3.curveMonotoneX) // apply smoothing to the line

            // TEST: pick a random data point and see if it gives a number for x position in the svg
            console.log("outside",this.xScale(filteredData[500].dateObj)); 
                // this returns a digit, yay!
            

            // // append path
            // lineGroup
            //     .enter()
            //     .append("path")
            //     .data(filteredData) 
            //     .attr("class", "line") 
            //     .merge()
            //     .transition()
            //     .duration(this.duration)
            //     .attr("d", this.d3.line()
            //         .x(function(d){ console.log('inside', d); return this.xScale(d.dateObj); })
            //         .y(this.height/2)
            //         .curve(this.d3.curveMonotoneX)); // 11. Calls the line generator 

    


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

