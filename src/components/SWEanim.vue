<template>
  <!---VizSection-->
  <VizSection
    id="firstSection"
    :take-away="true"
  >
    <!-- TAKEAWAY TITLE -->
    <template #takeAway>
      <h2>Changes in snowmelt have downstream consequences</h2>
    </template>
    <!-- EXPLANATION -->
    <template #aboveExplanation>
      <p />
      <p>
        Seasonal snowpack varies widely from place to place, and from year to year<sup>14</sup>, and this variability can have a strong influence on the timing and magnitude of snowmelt, delivery to a watershed, and subsequent streamflow response. At the sites shown below in the Upper Colorado River Basin, there was a two-fold difference in the magnitude of SWE between 2011 and 2012, illustrating how changes in snowmelt can shape the timing and magnitude of streamflow, and subsequently, water availability. Use the buttons below to explore how differences in snow between two years affect streamflow dynamics measured by USGS streamgages.
      </p>
    </template>
    <!-- FIGURES -->
    <template #figures>
      <div
        id="figs"
        class="single one"
      >
        <div class="compare">
          <div
            class="btn-group"
            data-toggle="buttons"
          >
            <h4 class="butt-head">
              Show: 
            </h4> 
            <div class="inputsContainer">
              <div class="inputs">
                <input
                  id="cb1"
                  class="butt"
                  type="checkbox"
                  name="checkboxgroup2"
                  checked="true"
                  value="swe"
                  @change="showSWE"
                >
                <label
                  class="butt"
                  for="cb1"
                >SWE (in)</label>
                <input
                  id="cb2"
                  class="butt"
                  type="checkbox"
                  name="checkboxgroup1"
                  checked="true"
                  value="flow"
                  @change="showFlow"
                >
                <label
                  class="butt"
                  for="cb2"
                >Streamflow (<sup>mm</sup>&frasl;<sub>day</sub>)</label>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div
        id="figs"
        class="single one"
      >
        <div id="mmd-container-both">
          <svg
            id="mmd-line-both"
            xmlns="http://www.w3.org/2000/svg"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            viewBox="-50 -50 600 500"
            aria-labelledby="page-title page-desc"
            width="100%"
            height="100%"
          >

            <text
              id="melt11"
              class="yr-label"
              x="200"
              y="20"
            >later and <tspan
              x="200"
              y="40px"
            >faster melt</tspan></text>
            <text
              id="melt12"
              class="yr-label"
              x="300"
              y="290"
            >earlier and <tspan
              x="300"
              y="310px"
            >longer melt</tspan></text>

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
              Compare: 
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
    <template #figureCaption>
      <p>
        Use the buttons to reorganize the chart and compare SWE and streamflow across a selection of USGS streamgages.
      </p>
    </template>
    <template #belowExplanation>
      <p>
        Elevation is intertwined with numerous factors like snow persistence, wind redistribution, and slope that drive complex snow-to-flow dynamics from site to site. At higher elevations, fallen snow can be blown over ridges, scouring windward rises or trees, leading to snow accumulating on the leeward side of the ridge. This results in spatial variation in snowpack depth and snowmelt timing.
      </p>
      <!-- <Sidebar>
        <template v-slot:sidebarTitle>
          What is a "water year"?
        </template>
        <template v-slot:sidebarMessage>
          <p>Instead starting the year at Janauary 1, USGS hydrologists mark the start of the <span class="emph">water year</span> on October 1, three months early.  The USGS has been using water years since 1911 to mark the start of hydrologic activity, and use it here because it captures a full snow cycle.</p>
        </template>
      </Sidebar> -->
    </template>
  </VizSection>
</template>
<script setup>
  import { onMounted } from 'vue';
  import * as d3 from 'd3';
  import VizSection from '@/components/VizSection.vue';

  const publicPath = import.meta.env.BASE_URL;

  // Chart geometry
  const width = 600;
  const height = 400;
  const margin = 25;

  const tickDates = ["Oct", "Jan", "Apr", "July"];
  const color_mmd = "dodgerblue";
  const color_swe = "grey";

  // Toggle state for the SWE / streamflow checkboxes
  let sweActive = true;
  let flowActive = true;

  // Ordering of gages
  let site_elev = [];

  // Site currently highlighted on hover, or null
  let activeSite = null;

  // d3 selections and generators, assigned during setup and reused by the
  // transition helpers below. These are plain references, not reactive state.
  let svgboth = null;
  let area_swe = null;
  let area_mmd = null;
  let line_swe = null;
  let line_mmd = null;
  let group = null;
  let xAxis = null;
  let yAxis_mmd = null;
  let yAxis_swe = null;
  let y2011 = null;
  let y2012 = null;
  let ridge11 = null;
  let ridge12 = null;
  let highlabel = null;
  let lowlabel = null;
  let highel = null;
  let lowel = null;
  let fast = null;
  let slow = null;
  let x11 = null;
  let x12 = null;
  let y11_swe = null;
  let y12_swe = null;
  let y11_mmd = null;
  let y12_mmd = null;

  onMounted(() => {
    loadData();
  });

  function loadData() {
    // read in data to draw hydrographs - eventually want to animate with d3 over gif
    // NOTE: the original passed `d3.autotype`, which is not a d3 export and so
    // evaluated to undefined - meaning no row conversion ever ran and every
    // value stayed a string. The scales coerce those strings, so the chart
    // works. Switching to the real d3.autoType would turn "NA" into null,
    // which isNaN() treats as 0 rather than a gap, so the omission is kept.
    const promises = [
      d3.csv(publicPath + "data/gage_sp.csv"),
      d3.csv(publicPath + "data/mmd_df_2011.csv"),
      d3.csv(publicPath + "data/mmd_df_2012.csv"),
      d3.csv(publicPath + "data/swe_df_2011.csv"),
      d3.csv(publicPath + "data/swe_df_2012.csv")
    ];

    Promise.all(promises).then(callback);
  }

  function callback(data) {
    // same data served up 2 ways
    const gage_sp = data[0]; // snow persistence for gages
    const data_2011 = data[1]; // mmd
    const data_2012 = data[2]; // mmd
    const swe_2011 = data[3]; // swe
    const swe_2012 = data[4]; // swe

    // prep data for plotting
    const sites = data_2011.columns // array of all site_no - each gets a ridge
    sites.shift(); // drop first column
    const n = sites.length;

    // sort gages by elevation
    site_elev = gage_sp.slice().sort((a, b) => d3.ascending(a.elev, b.elev)).map(d => d.site_no)

    // nest data to iterate over in plot
    // sort of inverse of series - array of objects where objs = site containing key for site_no, mmd and day vars
    data.mmd11 = [];
    for (let i = 1; i < n; i++) {
      const key = site_elev[i];
      const mmd = data_2011.map(d => d[key]);
      const swe = swe_2011.map(d => d[key]);
      const day = data_2011.map(d => d['site_water_day']);
      data.mmd11.push({ key: key, mmd: mmd, day: day, swe: swe })
    }

    data.mmd12 = [];
    for (let i = 1; i < n; i++) {
      const key = site_elev[i];
      const mmd = data_2012.map(d => d[key]);
      const swe = swe_2012.map(d => d[key]);
      const day = data_2012.map(d => d['site_water_day']);
      data.mmd12.push({ key: key, mmd: mmd, day: day, swe: swe })
    }

    // array of j days for good luck
    data.days = data_2011.length > data_2012.length
      ? data_2011.map(d => d['site_water_day'])
      : data_2012.map(d => d['site_water_day'])

    // set up g that holds ridgelines
    svgboth = d3.select('svg#mmd-line-both');

    // draw hydro chart elements
    const x_long = width - (margin * 3);

    // set chart - separate for each year, using 2011 for max values to set the scales, except
    // x scale of days, which is set based on whichever year has more days (2012)
    // first draw is MMD
    initRidges(svgboth, 'ridge_2011', data.mmd11, data.days, 0, x_long, 0, height / 2 - 10);
    initRidges(svgboth, 'ridge_2012', data.mmd12, data.days, 0, x_long, height / 2 + 10, height);

    // Hover is resolved from whatever is under the pointer on every move,
    // rather than per-path mouseover/mouseout. Raising the hovered ridge moves
    // it in the DOM, which can swallow its mouseout and leave it stuck on.
    svgboth
      .on("pointermove", (event) => {
        const target = d3.select(event.target);
        setActiveSite(target.classed("ridge") ? target.datum().key : null);
      })
      .on("pointerleave", () => setActiveSite(null));
  }

  function initRidges(svg, ridge_class, data_nest, days, x_start, x_end, y_start, y_end) {
    // x axis - time
    const x = d3.scaleLinear()
      .domain([1, 365])
      .range([x_start, x_end]);

    // y mmd
    const y_mmd = d3.scaleLinear()
      .domain([30, 0]).nice()
      .range([y_start, y_end])

    // y swe
    const y_swe = d3.scaleLinear()
      .domain([1100, 0]).nice()
      .range([y_start, y_end])

    // define & style x & y axes
    xAxis = g => g
      .attr("transform", `translate(0,${y_end})`)
      .call(d3.axisBottom(x)
        .tickValues([1, 93, 183, 273])
        .tickFormat(function (d, i) { return tickDates[i] })
        .tickSizeOuter(0).tickSize(0))

    // mmd axes
    yAxis_mmd = g => g
      .attr("transform", `translate(${width - 75},0)`)
      .call(d3.axisRight(y_mmd).tickSize(0).tickPadding(4).tickValues([0, 10, 20, 30]))

    // swe axes
    yAxis_swe = g => g
      .attr("transform", `translate(${0},0)`)
      .call(d3.axisLeft(y_swe).tickSize(0).tickPadding(4).tickValues([0, 250, 500, 750, 1000]))

    // append axes
    svg.append("g").classed("xaxis", true).classed(ridge_class, true).call(xAxis).attr("font-style", "italic");
    svg.append("g").classed("yaxis", true).classed(ridge_class, true).call(yAxis_mmd).attr("font-style", "italic").attr("color", color_mmd).classed("mmd", true);
    svg.append("g").classed("yaxis", true).classed(ridge_class, true).call(yAxis_swe).attr("font-style", "italic").attr("color", color_swe).classed("swe", true);

    // define area chart parameters
    area_mmd = d3.area()
      .curve(d3.curveBasis)
      .defined(d => !isNaN(d))
      .x((d, i) => x(days[i]))
      .y0(0)
      .y1(d => y_mmd(d))

    area_swe = d3.area()
      .curve(d3.curveBasis)
      .defined(d => !isNaN(d))
      .x((d, i) => x(days[i]))
      .y0(0)
      .y1(d => y_swe(d))

    line_mmd = area_mmd.lineY1()
      .defined(d => !isNaN(d));

    line_swe = area_swe.lineY1()
      .defined(d => !isNaN(d));

    // append g for each ridgeline/site_no
    group = svg.append("g")
      .classed(ridge_class, true).classed("curve", true)
      .selectAll("g")
      .data(data_nest)
      .join("g")
      .attr("class", d => "ridge_group " + d.key)
      .attr("transform", () => `translate(0,0)`)

    // draw MMD curves
    group.append("path")
      .attr("stroke", color_mmd)
      .attr("fill", color_mmd)
      .attr("stroke-opacity", .5)
      .attr("fill-opacity", .1)
      .attr("d", d => line_mmd(d.mmd))
      .attr("stroke-width", "1px")
      .attr("class", d => d.key)
      .classed("ridge", true)
      .classed("mmd", true)
      .attr('pointer-events', 'visibleStroke');

    // draw SWE curves
    group.append("path")
      .attr("stroke", color_swe)
      .attr("fill", color_swe)
      .attr("stroke-opacity", .5)
      .attr("fill-opacity", .1)
      .attr("d", d => line_swe(d.swe))
      .attr("stroke-width", "1px")
      .attr("class", d => d.key)
      .classed("ridge", true)
      .classed("swe", true)
      .attr('pointer-events', 'visibleStroke');

    y2011 = svgboth.selectAll("g.ridge_2011") // ridge group
    y2012 = svgboth.selectAll("g.ridge_2012")
    ridge11 = d3.selectAll("g.ridge_2011.curve g") // ridges themselves for staggered animation
    ridge12 = d3.selectAll("g.ridge_2012.curve g")

    highlabel = svgboth.select("text#peak11") // high and low snow labels
    lowlabel = svgboth.select("text#peak12")
    highel = svgboth.select("text#el11")
    lowel = svgboth.select("text#el12")
    fast = svgboth.select("text#melt11")
    slow = svgboth.select("text#melt12")

    y11_swe = d3.select(".yaxis.ridge_2011.swe") // axes
    y12_swe = d3.select(".yaxis.ridge_2012.swe")
    y11_mmd = d3.select(".yaxis.ridge_2011.mmd")
    y12_mmd = d3.select(".yaxis.ridge_2012.mmd")
    x11 = d3.select(".xaxis.ridge_2011")
    x12 = d3.select(".xaxis.ridge_2012")

    lowlabel.transition().duration(0).attr("opacity", 0)
    highlabel.transition().duration(0).attr("opacity", 0)
    lowel.transition().duration(0).attr("opacity", 0)
    highel.transition().duration(0).attr("opacity", 0)
    slow.transition().duration(0).attr("opacity", 1)
    fast.transition().duration(0).attr("opacity", 1)
  }

  function setActiveSite(key) {
    if (key === activeSite) return;
    activeSite = key;

    d3.selectAll('g.curve path.mmd')
      .attr("stroke-width", "1px")
      .attr("stroke", color_mmd)
      .attr('stroke-opacity', .5)

    d3.selectAll('g.curve path.swe')
      .attr("stroke-width", "1px")
      .attr("stroke", color_swe)
      .attr('stroke-opacity', .5)

    if (key === null) return;

    d3.selectAll('g.ridge_group.' + key)
      .raise()

    d3.selectAll('g.curve path.mmd.' + key)
      .attr('stroke-width', "2px")
      .attr('stroke', "darkblue")
      .attr('stroke-opacity', .8)

    d3.selectAll('g.curve path.swe.' + key)
      .attr('stroke-width', "2px")
      .attr('stroke', "black")
      .attr('stroke-opacity', .8)
  }

  function showSWE() {
    if (sweActive === true) {
      sweActive = false;

      d3.selectAll(".ridge.swe")
        .transition()
        .delay(50)
        .duration(300)
        .attr("opacity", 0)
    } else if (sweActive === false) {
      sweActive = true;

      d3.selectAll(".ridge.swe")
        .transition()
        .delay(50)
        .duration(300)
        .attr("opacity", 0.5)
    }
  }

  function showFlow() {
    if (flowActive === true) {
      flowActive = false;

      d3.selectAll(".ridge.mmd")
        .transition()
        .delay(50)
        .duration(300)
        .attr("opacity", 0)
    } else if (flowActive === false) {
      flowActive = true;

      d3.selectAll(".ridge.mmd")
        .transition()
        .delay(50)
        .duration(300)
        .attr("opacity", 0.5)
    }
  }

  function changePos(e) {
    if (e.target.value === "peak") {
      toMagnitude()
    }
    if (e.target.value === "time") {
      toTiming();
    }
    if (e.target.value === "el") {
      toMagnitude()
      toElevation();
    }
  }

  function transPosition(el, delay, duration, x, y, xscale, yscale) {
    el
      .transition()
      .delay(delay)
      .duration(duration)
      .attr("transform", "translate(" + (x) + ", " + (y) + ") scale(" + xscale + "," + yscale + ")")
  }

  function transFade(el, delay, duration, alpha) {
    el
      .transition()
      .duration(duration)
      .delay(delay)
      .attr("opacity", alpha)
  }

  function transAxis(el, delay, duration, axis, x, y, xscale, yscale) {
    el
      .transition()
      .duration(duration)
      .delay(delay)
      .call(axis)
      .attr("transform", "translate(" + (x) + ", " + (y) + ") scale(" + xscale + "," + yscale + ")")
  }

  function toTiming() {
    // fade in y axis if coming from elevation
    transFade(d3.selectAll("g.yaxis g"), 300, 500, 1)

    // make sure ridges are stacked flat
    y2011.selectAll("path.ridge")
      .transition()
      .delay(function (d, i) { return i * 15 })
      .duration(1100)
      .attr("transform", "translate(0," + (0) + ")")

    lowlabel.transition().delay(50).duration(300).attr("opacity", 0)
    highlabel.transition().delay(50).duration(300).attr("opacity", 0)
    lowel.transition().delay(50).duration(300).attr("opacity", 0)
    highel.transition().delay(50).duration(300).attr("opacity", 0)
    slow.transition().delay(50).duration(300).attr("opacity", 1)
    fast.transition().delay(50).duration(300).attr("opacity", 1)

    // transform axes
    transAxis(x11, 50, 300, xAxis, 0, height / 2 - 10, 1, 1)
    transAxis(x12, 50, 500, xAxis, 0, height, 1, 1)
    transAxis(y11_swe, 50, 300, yAxis_swe, 0, -height / 2 - 10, 1, 1)
    transAxis(y12_swe, 50, 500, yAxis_swe, 0, 0, 1, 1)
    transAxis(y11_mmd, 50, 300, yAxis_mmd, width - 75, -height / 2 - 10, 1, 1)
    transAxis(y12_mmd, 50, 500, yAxis_mmd, width - 75, 0, 1, 1)

    // stretch ridges to full x and y extent
    transPosition(d3.selectAll("g.ridge_2011.curve"), 270, 500, 0, 0, 1, 1)
    transPosition(d3.selectAll("g.ridge_2012.curve"), 250, 500, 0, 0, 1, 1)

    // un-spread ridge
    ridge11
      .transition()
      .delay(function (d, i) { return i * 15 })
      .duration(400)
      .attr("transform", function (d, i) {
        return "translate(0," + (0 + i * 0) + ")"
      })

    ridge12
      .transition()
      .delay(function (d, i) { return i * 15 })
      .duration(400)
      .attr("transform", function () {
        return "translate(0," + (0) + ")"
      })
  }

  function toMagnitude() {
    shiftRidges();

    // flatten stacks
    y2011.selectAll("path.ridge")
      .transition()
      .delay(function (d, i) { return i * 15 })
      .duration(1000)
      .attr("transform", "translate(0," + (height / 2 + 10) + ")")

    ridge11
      .transition()
      .delay(50)
      .duration(400)
      .attr("transform", function (d, i) {
        return "translate(0," + (0 + i * 0) + ") scale(1, 1)"
      })

    ridge12
      .transition()
      .delay(50)
      .duration(400)
      .attr("transform", function () {
        return "translate(0," + (0) + ") scale(1, 1)"
      })

    // y mmd
    const y_mmd = d3.scaleLinear()
      .domain([30, 0]).nice()
      .range([height / 2 + 10, height])

    // y swe
    const y_swe = d3.scaleLinear()
      .domain([1100, 0]).nice()
      .range([height / 2 + 10, height])

    // mmd axes
    const y_mmd_low = g => g
      .attr("transform", `translate(${width - 75},0)`)
      .call(d3.axisRight(y_mmd).tickSize(0).tickPadding(4).tickValues([0, 10, 20, 30]))

    // swe axes
    const y_swe_low = g => g
      .attr("transform", `translate(${0},0)`)
      .call(d3.axisLeft(y_swe).tickSize(0).tickPadding(4).tickValues([0, 250, 500, 750, 1000]))

    transFade(d3.selectAll("g.yaxis g"), 300, 500, 1)

    // transform axes
    transAxis(y11_mmd, 150, 500, y_mmd_low, width - 75, 0, 1, 1)
    transAxis(y12_mmd, 150, 500, y_mmd_low, width - 75, 0, 1, 1)
    transAxis(y11_swe, 150, 500, y_swe_low, 0, 0, 1, 1)
    transAxis(y12_swe, 150, 500, y_swe_low, 0, 0, 1, 1)

    lowlabel.transition().delay(50).duration(300).attr("opacity", 1)
    highlabel.transition().delay(50).duration(300).attr("opacity", 1)
    lowel.transition().delay(50).duration(300).attr("opacity", 0)
    highel.transition().delay(50).duration(300).attr("opacity", 0)
    slow.transition().delay(50).duration(300).attr("opacity", 0)
    fast.transition().delay(50).duration(300).attr("opacity", 0)
  }

  function toElevation() {
    // spread ridges
    ridge11
      .transition()
      .delay(50)
      .duration(500)
      .attr("transform", function (d, i) {
        return "translate(0," + (40 + i * -10) + ") scale(1, .9)"
      })

    ridge12
      .transition()
      .delay(50)
      .duration(500)
      .attr("transform", function (d, i) {
        return "translate(0," + (40 + i * -10) + ") scale(1, .9)"
      })

    lowlabel.transition().delay(50).duration(300).attr("opacity", 0)
    highlabel.transition().delay(50).duration(300).attr("opacity", 0)
    lowel.transition().delay(50).duration(300).attr("opacity", 1)
    highel.transition().delay(50).duration(300).attr("opacity", 1)
    slow.transition().delay(50).duration(300).attr("opacity", 0)
    fast.transition().delay(50).duration(300).attr("opacity", 0)

    // transform axes
    transAxis(y11_swe, 150, 500, yAxis_swe, 0, -100, 1, 1)
    transAxis(y12_swe, 150, 500, yAxis_swe, 0, 0, 1, 1)
    transAxis(y11_mmd, 150, 500, yAxis_mmd, width - 75, -100, 1, 1)
    transAxis(y12_mmd, 150, 500, yAxis_mmd, width - 75, 0, 1, 1)

    transFade(d3.selectAll("g.yaxis g"), 300, 400, 0)
  }

  function shiftRidges() {
    const x_long = width - (margin * 3);
    const mid = x_long / 2;

    const xhalfL = d3.scaleLinear()
      .domain([1, 365])
      .range([0, mid - 5]);

    const xhalfR = d3.scaleLinear()
      .domain([1, 365])
      .range([mid + 5, x_long]);

    const xAxisL = g => g
      .attr("transform", `translate(0,${height})`)
      .call(d3.axisBottom(xhalfL)
        .tickValues([1, 93, 183, 273])
        .tickFormat(function (d, i) { return tickDates[i] })
        .tickSizeOuter(0).tickSize(0))

    const xAxisR = g => g
      .attr("transform", `translate(0,${height})`)
      .call(d3.axisBottom(xhalfR)
        .tickValues([1, 93, 183, 273])
        .tickFormat(function (d, i) { return tickDates[i] })
        .tickSizeOuter(0).tickSize(0))

    // transform axes
    transAxis(x11, 150, 400, xAxisL, 0, height, 1, 1)
    transAxis(x12, 150, 500, xAxisR, 0, height, 1, 1)

    d3.selectAll("g.ridge_2011.curve")
      .transition()
      .delay(170)
      .duration(500)
      .attr("transform", "translate(0, 0) scale(.49, 1)")

    d3.selectAll("g.ridge_2012.curve")
      .transition()
      .delay(150)
      .duration(500)
      .attr("transform", "translate(270, 0) scale(.49, 1)")
  }
</script>
<style lang="scss" scoped>
$familySerif:  'Noto Serif', serif;
.maxWidth {
  width: 90vw;
  margin-left: 5vw;
  max-width: 700px;
  margin: auto;
}

.compare {
  border: 0px solid black;
  display: inline-block;
  width: 80vw;
  max-width: 600px;
  font-size: 18px;
  text-align: center;
  padding: 15px 0px;
  margin: auto;
  position: relative;
  h4{
    margin-bottom: 15px;
  }
}
.butt {
  padding: 5px 10px;
  margin: 5px 5px;
  cursor: pointer;
  display: inline-block;
}
.yr-label {
  font-size: 16px;
  font-weight: 400;
  text-anchor: middle;
  font-style: italic;
  fill: rgb(165, 163, 163);
}
.inputsContainer{
  .inputs{
    font-size:.85em;
  }
}
#mmd-container-both {
  width: 90vw;
  max-width: 900px;
  margin: auto;
}
svg#mmd-line-both{
  transform: translate(-5px, 0);
}

input[name="radiogroup1"] {
            display: none;
        }
         input[name="radiogroup1"]+label {
            /* style passive state as you like */
            background-color: rgb(221,221,221);
            border: 2px solid transparent;
            color: black;
            font-weight: 400;
            transition: background-color .1s, border .1s;
        }

    input[name="radiogroup1"]:checked+label {
        /* style checked state as you like */
        border: 7px solid dodgerblue;
        background-color: dodgerblue;
        color: white;
    }
input[name="checkboxgroup1"] {
            display: none;
        }
         input[name="checkboxgroup1"]+label {
            /* style passive state as you like */
            background-color: rgb(221,221,221);
            border: 2px solid transparent;
            color: black;
            font-weight: 400;
            transition: background-color .1s, border .1s;
        }

    input[name="checkboxgroup1"]:checked+label {
        /* style checked state as you like */
        border: 7px solid dodgerblue;
        background-color: dodgerblue;
        color: white;
    }
    input[name="checkboxgroup2"] {
            display: none;
        }
         input[name="checkboxgroup2"]+label {
            /* style passive state as you like */
            background-color: rgb(221,221,221);
            border: 2px solid transparent;
            color: black;
            font-weight: 400;
            transition: background-color .1s, border .1s;
        }

    input[name="checkboxgroup2"]:checked+label {
        /* style checked state as you like */
        border: 7px solid grey;
        background-color: grey;
        color: white;
        transition: background-color .1s, border .1s;
    }
    

@media screen and (min-width: 650px){
  .compare{
    width: 100%;
    max-width: 600px;
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
          font-size: 18px;
          .butt{
            margin-right: 10px;
          }
          .butt:last-child{
            margin-right: 0;
          }
        }
      }
      #mmd-container-both {
        width: 90vw;
        max-width: 1200px;
        margin: auto;
      }
      h4{
        flex: 1;
        margin-bottom: 0;
      }
    }
  } 
}
// adding a break for full screen laptop adjustments
@media screen and (max-height: 750px){
  #mmd-container-both {
    width: 90vw;
    max-width: 700px;
    margin: auto;
  }

}
</style>
