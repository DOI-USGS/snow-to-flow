<template>
  <!---VizSection-->
  <VizSection
    id="SNTLMap"
    :take-away="false"
  >
    <!-- EXPLANATION -->
    <template #aboveExplanation>
      <p>
        As springtime temperatures warm and snow begins to melt, the Western U.S. enters an important phase of the water cycle. Snow on {{ percentileDayLabel }}, and how it turns into streamflow, indicates the potential for water availability in the summer and fall. In water year {{ info.water_year }}, snowpack at most SNOTEL sites peaked early and melted early.
      </p>
      <p
        v-if="mobileView"
        class="explain figureCaption"
      >
        Select a site to see its SWE through water year {{ info.water_year }}, and the magnitude (peak SWE <svg
          class="leggy"
          viewBox="0 0 10 10"
          width="10"
          height="10"
        >
          <circle
            cx="5"
            cy="5"
            r="4"
            style="fill: orchid; stroke: orchid;stroke-width: 1px;"
          />
        </svg>) and timing (SM50 <svg
          viewBox="0 0 10 10"
          width="10"
          height="10"
        >
          <circle
            cx="5"
            cy="5"
            r="4"
            style="fill: white; stroke: orchid; stroke-width: 1.3px;"
          />
        </svg>) of snow for every year since {{ info.record_start_wy }}. A symbol is left off if the peak or SM50 had not happened by {{ dataEndLabel }}.
      </p>
      <p
        v-if="!mobileView"
        class="explain figureCaption"
      >
        Mouseover a site, or choose one from the list, to see its SWE through water year {{ info.water_year }}, and the magnitude (peak SWE <svg
          class="leggy"
          viewBox="0 0 10 10"
          width="10"
          height="10"
        >
          <circle
            cx="5"
            cy="5"
            r="4"
            style="fill: orchid; stroke: orchid;stroke-width: 1px;"
          />
        </svg> ) and timing (SM50 <svg
          viewBox="0 0 10 10"
          width="10"
          height="10"
        >
          <circle
            cx="5"
            cy="5"
            r="4"
            style="fill: white; stroke: orchid; stroke-width: 1.3px;"
          />
        </svg> ) of snow for every year since {{ info.record_start_wy }}. A symbol is left off if the peak or SM50 had not happened by {{ dataEndLabel }}.
      </p>
    </template>
    <!-- FIGURES -->
    <template #figures>
      <div class="map-grid">
        <!-- LEGEND -->
        <div id="legendContainer">
          <svg
            id="legend-percentile"
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 300 90" 
            preserveAspectRatio="xMinYMin"
            width="100%"
          />
          <!-- keyboard and screen reader alternative to hovering the map -->
          <label class="site-picker">
            <span class="site-picker__label">Choose a site</span>
            <select
              :value="selectedId"
              @change="onSitePicked"
            >
              <option
                value=""
                disabled
              >
                Select a SNOTEL site
              </option>
              <option
                v-for="site in siteOptions"
                :key="site.id"
                :value="site.id"
              >
                {{ site.name }} ({{ site.elev }} ft)
              </option>
            </select>
          </label>
        </div>
        <!-- ALASKA -->
        <div id="grid-left">
          <div
            id="ak"
            class="map-container"
          >
            <div
              class="map-frame"
              :style="frameStyle('ak')"
            >
              <div
                class="map-stack"
                :style="stackStyle('ak')"
              >
                <img
                  class="map-layer"
                  :src="layers.ak.hillshade"
                  alt=""
                >
                <div
                  class="map-layer map-outline"
                  v-html="layers.ak.outline"
                />
                <svg
                  id="ak-sntl"
                  class="map-layer"
                  xmlns="http://www.w3.org/2000/svg"
                  :viewBox="viewBox('ak')"
                  role="img"
                  :aria-label="`Map of SNOTEL sites in Alaska, colored by ${percentileDayLabel} SWE percentile`"
                />
              </div>
            </div>
          </div>
        </div>
        <!-- CONTINENTAL USA -->
        <div id="grid-right">
          <div
            id="usa"
            class="map-container"
          >
            <div
              class="map-frame"
              :style="frameStyle('conus')"
            >
              <div
                class="map-stack"
                :style="stackStyle('conus')"
              >
                <img
                  class="map-layer"
                  :src="layers.conus.hillshade"
                  alt=""
                >
                <div
                  class="map-layer map-states"
                  v-html="layers.conus.states"
                />
                <div
                  class="map-layer map-outline"
                  v-html="layers.conus.outline"
                />
                <svg
                  id="usa-sntl"
                  class="map-layer"
                  xmlns="http://www.w3.org/2000/svg"
                  :viewBox="viewBox('conus')"
                  role="img"
                  :aria-label="`Map of SNOTEL sites in the western U.S., colored by ${percentileDayLabel} SWE percentile`"
                />
              </div>
            </div>
          </div>
        </div>
        <!-- PEAK SWE MINI -->
        <div id="peak-container">
          <svg
            id="peak-svg"
            xmlns="http://www.w3.org/2000/svg"
            viewBox="-50 -20 260 150" 
            preserveAspectRatio="xMinYMin slice"
          />
        </div>
        
        <!-- WY21 MINI -->
        <div id="wy21-container">
          <svg
            id="wy21-svg"
            xmlns="http://www.w3.org/2000/svg"
            viewBox="-50 -20 260 330" 
            preserveAspectRatio="xMinYMin slice"
          />
        </div>
        
        <!-- MELT DATE MINI -->
        <div id="melt-container">
          <svg
            id="melt-svg"
            xmlns="http://www.w3.org/2000/svg"
            viewBox="-50 -20 260 170" 
            preserveAspectRatio="xMinYMin slice"
          />
        </div>
      </div>
    </template>
    
    <!-- FIGURE CAPTION -->
    <template #figureCaption>
      <p id="explain-bottom">
        The map shows {{ percentileDayLabel }} snow as a percentile of this date in each site's period of record, calculated as in the NRCS interactive map. Snow is quantified as the daily snow-water equivalent (SWE) at  <a
          href="https://www.nrcs.usda.gov/programs-initiatives/sswsf-snow-survey-and-water-supply-forecasting-program"
          target="_blank"
        >the USDA Natural Resources Conservation Service (NRCS) snow telemetry (SNOTEL) sites </a> across the Western U.S. Sites without a percentile are shown in grey.
      </p>
    </template>
    <!-- EXPLANATION -->
    <template #belowExplanation>
      <!--       <ExpandingSidebar>
        <template v-slot:sidebarTitle>
          What are the small charts?
        </template>
        <template v-slot:sidebarMessage>
          <p>The left chart shows SWE in the current water year (2021) to date.</p>
          <p>The panels on the right show peak SWE and the melt date (SM50) for all years with data at a given site.</p>
        </template>
      </ExpandingSidebar> -->
      <ExpandingSidebar>
        <template #sidebarTitle>
          What is a percentile?
        </template>
        <template #sidebarMessage>
          <p>Percentiles show how SWE on {{ percentileDateLabel }} compares with {{ percentileDayLabel }} in every other year of the site's record. A site in the 90th percentile had as much or more SWE than in 90% of the other years on record, and a site at 0 had its lowest {{ percentileDayLabel }} on record.</p>
        </template>
      </ExpandingSidebar>
      <ExpandingSidebar>
        <template #sidebarTitle>
          When was peak SWE in {{ info.water_year }}?
        </template>
        <template #sidebarMessage>
          <p>{{ percentileDayLabel }} has traditionally been used as an indicator of peak SWE for the season. In {{ info.water_year }}, most sites peaked well before {{ percentileDayLabel }}, about three weeks earlier than usual, and half their snow had melted about a month earlier than usual. The charts show each site's actual peak (●) and the date half of it had melted (○).</p>
        </template>
      </ExpandingSidebar>
      <p>
        The USGS is undertaking new efforts to advance snow science through both measuring and modeling snowpack and linking these results to streamflow. As a part of the <a
          href="https://www.usgs.gov/mission-areas/water-resources/science/next-generation-water-observing-system-ngwos"
          target="_blank"
        >USGS Next Generation Water Observing System (NGWOS)</a>, new spatial and temporal snow and streamflow observations are being planned for unmonitored areas. These observations will provide valuable data to inform predictive modeling of water-cycle components in the Upper Colorado River Basin. New snow monitoring will include continuous snowpack and soil moisture stations, remotely sensed mapping of snow conditions, and manual snow surveys. In addition, USGS is involved in the development and production of the Landsat snow covered area product, available through <a
          href="https://www.usgs.gov/landsat-missions/landsat-fractional-snow-covered-area-science-products"
          target="_blank"
        > Earth Explorer.</a>
      </p>
      <p>
        The USGS also contributes to snow science research through modeling snowpack and snowmelt dynamics at local to National scales. These models use data for snow, landscape, vegetation, and meteorologic variables to understand how the annual snowpack evolves from accumulation through melt, and how these changes influence streamflow and ultimately, water availability.
      </p>
    </template>
  </VizSection>
</template>
<script setup>
  import { onMounted, ref, computed } from 'vue';
  import * as d3 from 'd3';
  import { isMobile } from 'mobile-device-detect';
  import VizSection from '@/components/VizSection.vue';
  import ExpandingSidebar from '@/components/ExpandingSidebar.vue';

  // Map layers built by the targets pipeline (3_visualize): a hillshade and
  // state and outline SVGs per panel, all on one pixel grid per panel. Alaska
  // uses only its outline, as on the 2021 map.
  import conusHillshade from '@/assets/maps/snotel_conus_hillshade.png';
  import conusStates from '@/assets/maps/snotel_conus_states.svg?raw';
  import conusOutline from '@/assets/maps/snotel_conus_outline.svg?raw';
  import akHillshade from '@/assets/maps/snotel_ak_hillshade.png';
  import akOutline from '@/assets/maps/snotel_ak_outline.svg?raw';

  const publicPath = import.meta.env.BASE_URL;
  const mobileView = isMobile;

  const layers = {
    conus: { hillshade: conusHillshade, states: conusStates, outline: conusOutline },
    ak: { hillshade: akHillshade, outline: akOutline }
  };

  // The part of each panel shown on the page, in panel pixels: the framing of
  // the 2021 map. `unit` is the size of one 2021 map unit in panel pixels, so
  // site sizes and strokes match the 2021 map.
  const frames = {
    conus: { x: -236.6, y: 24.5, w: 2349.8, h: 1488.2, unit: 2.611 },
    ak: { x: 328.9, y: 19.6, w: 1876.8, h: 1005, unit: 3.092 }
  };
  // Panel sizes in pixels, from snotel_map_panels.csv
  const panels = ref({
    conus: { width_px: 2400, height_px: 1529 },
    ak: { width_px: 1904, height_px: 1037 }
  });

  function viewBox(panel) {
    const p = panels.value[panel];
    return `0 0 ${p.width_px} ${p.height_px}`;
  }
  function frameStyle(panel) {
    const f = frames[panel];
    return { aspectRatio: `${f.w} / ${f.h}` };
  }
  function stackStyle(panel) {
    const f = frames[panel];
    const p = panels.value[panel];
    return {
      width: `${(p.width_px / f.w) * 100}%`,
      height: `${(p.height_px / f.h) * 100}%`,
      left: `${(-f.x / f.w) * 100}%`,
      top: `${(-f.y / f.h) * 100}%`
    };
  }

  // Run settings from snotel_run_info.csv: water year, dates, and thresholds
  const info = ref({});
  const formatLongDate = d3.utcFormat('%B %-d, %Y');
  const dataEndLabel = computed(() =>
    info.value.data_end_date ? formatLongDate(info.value.data_end_date) : ''
  );
  // e.g. "April 1st", and "April 1st, 2026"
  const percentileDayLabel = computed(() => {
    const d = info.value.percentile_date;
    if (!d) return '';
    const day = d.getUTCDate();
    const suffix = [11, 12, 13].includes(day % 100) ? 'th' : ({ 1: 'st', 2: 'nd', 3: 'rd' }[day % 10] || 'th');
    return `${d3.utcFormat('%B')(d)} ${day}${suffix}`;
  });
  const percentileDateLabel = computed(() =>
    percentileDayLabel.value ? `${percentileDayLabel.value}, ${info.value.percentile_date.getUTCFullYear()}` : ''
  );

  // Percentile colour scale shared by the map and legend, with the NRCS
  // interactive map's percentile breaks
  const threshold = d3.scaleThreshold()
    .domain([0.1, 0.3, 0.5, 0.7, 0.9])
    .range(["#5C3406", "#C28D3D", "#ECD8A6", "#AADDD6", "#2A8C83", "#004439"]);
  // Sites without a percentile, whether or not they have charts
  const noPercentileFill = "#c4c4c4";
  const noPercentileStroke = "#7a7a7a";
  const siteFill = d => d.ptile_swe == null ? noPercentileFill : threshold(d.ptile_swe);
  const siteStroke = d => d.ptile_swe == null ? noPercentileStroke : "black";
  const site_radius = 2.5;

  // Chart scales, set once the run settings are loaded
  let xYear = null;
  let yPeak = null;
  let yMelt = null;
  let xDay = null;
  let ySwe = null;
  let lastDay = null;

  // Per-site series for the charts, keyed by site_id
  let annualBySite = new Map();
  let dailyBySite = new Map();

  // Site currently shown in the mini charts, or null before the first hover
  let selectedSite = null;
  // Options for the site picker, and a lookup from its value to the site
  const siteOptions = ref([]);
  const selectedId = ref('');
  const siteById = new Map();

  onMounted(() => {
    Promise.all([
      d3.csv(publicPath + "data/snotel_run_info.csv", d3.autoType),
      d3.csv(publicPath + "data/snotel_map_panels.csv", d3.autoType),
      d3.csv(publicPath + "data/snotel_sites.csv", d3.autoType),
      d3.csv(publicPath + "data/snotel_annual.csv", d3.autoType),
      d3.csv(publicPath + "data/snotel_swe_daily.csv", d3.autoType)
    ]).then(callback);
  });

  function callback([runInfo, panelRows, sites, annual, daily]) {
    info.value = runInfo[0];
    panels.value = Object.fromEntries(panelRows.map(d => [d.panel, d]));
    annualBySite = d3.group(annual, d => d.site_id);
    dailyBySite = d3.group(daily, d => d.site_id);

    sites.forEach(d => {
      d.has_charts = d.has_charts === true || d.has_charts === "TRUE";
      d.unit = frames[d.panel].unit;
    });

    addSites(d3.select("svg#usa-sntl"), sites.filter(d => d.panel === "conus"));
    addSites(d3.select("svg#ak-sntl"), sites.filter(d => d.panel === "ak"));
    drawLegend();
    makeTrend();

    // sites with charts, the ones that respond to hover
    const pickable = sites.filter(d => d.has_charts);
    pickable.forEach(site => siteById.set(site.sntl_id, site));
    siteOptions.value = pickable
      .map(site => ({ id: site.sntl_id, name: site.site_name, elev: site.elev_ft }))
      .sort((a, b) => a.name.localeCompare(b.name));
  }

  function addSites(svg, sites) {
    const g = svg.append("g").classed("sites", true);

    // sites without charts look like any other site without a percentile,
    // but don't respond to hover
    g.selectAll("circle.SNTL_nodata")
      .data(sites.filter(d => !d.has_charts))
      .join("circle")
        .classed("SNTL_nodata", true)
        .attr("id", d => d.sntl_id)
        .attr("cx", d => d.x)
        .attr("cy", d => d.y)
        .attr("r", d => site_radius * d.unit)
        .attr("opacity", .85)
        .attr("stroke", noPercentileStroke)
        .attr("fill", noPercentileFill)
        .attr("stroke-width", d => .35 * d.unit);

    // sites with charts respond to hover
    g.selectAll("circle.SNTL")
      .data(sites.filter(d => d.has_charts))
      .join("circle")
        .classed("SNTL", true)
        .attr("id", d => d.sntl_id)
        .attr("cx", d => d.x)
        .attr("cy", d => d.y)
        .attr("r", d => site_radius * d.unit)
        .attr("opacity", .85)
        .attr("stroke", siteStroke)
        .attr("stroke-width", d => .35 * d.unit)
        .attr("fill", siteFill)
        .on("mouseover", (event, data) => selectSite(data));
  }

  function makeTrend() {
    const wy = info.value.water_year;
    const yy = y => `'${String(y).slice(-2)}`;
    // every ten years back from the water year, so it is always labelled
    const years = d3.range(wy, info.value.record_start_wy - 1, -10).reverse();
    const endAnchor = axis => axis.selectAll(".tick text")
      .filter(d => d === wy)
      .attr("text-anchor", "end");

    // peak SWE and melt date by year
    xYear = d3.scaleLinear().range([0, 200]).domain([info.value.record_start_wy, wy]);
    yPeak = d3.scaleLinear().range([110, 10]).domain([0, 130]);
    yMelt = d3.scaleLinear().range([110, 10]).domain([0, 350]);

    // SWE through the focal water year, to the last day of data
    lastDay = d3.utcDay.count(Date.UTC(wy - 1, 9, 1), info.value.data_end_date) + 1;
    xDay = d3.scaleLinear().range([0, 200]).domain([1, lastDay]);
    ySwe = d3.scaleLinear().range([270, 10]).domain([0, 130]);

    const peakSvg = d3.select("svg#peak-svg");
    const meltSvg = d3.select("svg#melt-svg");
    const wySvg = d3.select("svg#wy21-svg");

    peakSvg.append("g")
      .classed("corr-legend", true)
      .call(d3.axisLeft(yPeak).tickValues([10, 40, 70, 100, 130]).tickSize(2));
    peakSvg.append("g")
      .classed("peak-legend", true)
      .call(d3.axisBottom(xYear).tickValues(years).tickFormat(d3.format("d")).tickSize(0))
      .attr("transform", "translate(0,110)")
      .call(endAnchor);
    peakSvg.append("text")
      .classed("ele", true)
      .attr("fill", "black")
      .attr("font-size", ".9em")
      .attr("text-anchor", "start")
      .attr("font-style", "italic")
      .attr("y", 120)
      .attr("x", 35)
      .attr("transform", "rotate(-90) translate(-110, -150)")
      .text("inches");
    peakSvg.append("text")
      .classed("ele", true)
      .attr("fill", "black")
      .attr("font-size", "1em")
      .attr("font-weight", "bold")
      .attr("text-anchor", "start")
      .attr("y", 0)
      .attr("x", -25)
      .text("Peak SWE");

    const meltDays = [1, 93, 183, 274];
    const meltDates = ["Oct 1", "Jan 1", "Apr 1", "Jul 1"];
    meltSvg.append("g")
      .classed("melt-legend", true)
      .call(d3.axisBottom(xYear).tickValues(years).tickFormat(d3.format("d")).tickSize(0))
      .attr("transform", "translate(0,110)")
      .call(endAnchor);
    meltSvg.append("g")
      .classed("melt-legend", true)
      .call(d3.axisLeft(yMelt)
        .tickValues(meltDays)
        .tickFormat((d, i) => meltDates[i])
        .tickSizeOuter(2).tickSize(2));
    meltSvg.append("text")
      .attr("fill", "black")
      .attr("font-size", "1em")
      .attr("text-anchor", "start")
      .attr("font-weight", "bold")
      .attr("y", 140)
      .attr("x", 75)
      .text("Year");
    meltSvg.append("text")
      .classed("ele", true)
      .attr("fill", "black")
      .attr("font-size", "1em")
      .attr("font-weight", "bold")
      .attr("text-anchor", "start")
      .attr("y", 0)
      .attr("x", -25)
      .text("Melt date (SM50)");

    const wyTicks = meltDays.filter(d => d <= lastDay);
    const wyLabels = [`Oct ${yy(wy - 1)}`, `Jan ${yy(wy)}`, `Apr ${yy(wy)}`, `Jul ${yy(wy)}`];
    wySvg.append("g")
      .classed("melt-legend", true)
      .call(d3.axisBottom(xDay)
        .tickValues(wyTicks)
        .tickFormat((d, i) => wyLabels[i])
        .tickSizeOuter(0).tickSize(0))
      .attr("transform", "translate(0,270)")
      // keep a label at the end of the axis (the last day of data) inside the chart
      .selectAll(".tick text")
      .filter(d => xDay(d) > 185)
      .attr("text-anchor", "end");
    wySvg.append("g")
      .classed("melt-legend", true)
      .call(d3.axisLeft(ySwe)
        .tickValues([10, 40, 70, 100, 130])
        .tickSizeOuter(0).tickSize(0));
    wySvg.append("text")
      .attr("fill", "black")
      .attr("font-size", "1em")
      .attr("font-weight", "bold")
      .attr("y", 305)
      .attr("x", 50)
      .text(`${wy} Water year`);
    wySvg.append("text")
      .classed("ele", true)
      .attr("fill", "black")
      .attr("font-size", ".9em")
      .attr("text-anchor", "start")
      .attr("font-style", "italic")
      .attr("y", 130)
      .attr("x", -35)
      .attr("transform", "rotate(-90) translate(-110, -150)")
      .text("inches");
    wySvg.append("text")
      .classed("ele", true)
      .attr("fill", "black")
      .attr("font-size", "1em")
      .attr("font-weight", "bold")
      .attr("text-anchor", "start")
      .attr("y", 0)
      .attr("x", -25)
      .text("SWE");

    // hover/click prompt
    wySvg.append("text")
      .classed("hover_info", true)
      .attr("fill", "#000")
      .attr("font-size", "1.2em")
      .attr("text-anchor", "start")
      .attr("font-style", "italic")
      .attr("y", 50)
      .attr("x", 30)
      .text("Hover over a site");
  }

  // The last site hovered (or picked from the list) stays selected, and its
  // data stays in the mini charts, until a different site is chosen.
  function selectSite(data) {
    if (selectedSite === data) return;
    if (selectedSite) hoverOut(selectedSite);
    selectedSite = data;
    selectedId.value = data.sntl_id;
    hover(data);
    d3.select("text.hover_info").remove();
  }
  function onSitePicked(event) {
    const data = siteById.get(event.target.value);
    if (data) selectSite(data);
  }

  function hover(data) {
    d3.select('circle#' + data.sntl_id)
      .raise()
      .transition()
      .duration(50)
      .attr("r", site_radius * 2 * data.unit)
      .attr("fill", "orchid");
    drawCharts(data);
  }
  function hoverOut(data) {
    d3.select('circle#' + data.sntl_id)
      .transition()
      .duration(50)
      .attr("r", site_radius * data.unit)
      .attr("fill", siteFill(data));
    d3.selectAll(".trend").remove();
    d3.selectAll(".site_name").remove();
  }

  // Draw the three mini charts for a site from its annual and daily data
  function drawCharts(site) {
    const wy = info.value.water_year;
    const byYear = new Map((annualBySite.get(site.site_id) || []).map(d => [d.water_year, d]));
    const years = d3.range(info.value.record_start_wy, wy + 1).map(y => byYear.get(y) || { water_year: y });
    const byDay = new Map((dailyBySite.get(site.site_id) || []).map(d => [d.water_day, d.swe]));
    const days = d3.range(1, lastDay + 1).map(day => ({ day, swe: byDay.get(day) ?? null }));

    const peakMet = site.peak_met !== "TBD" && site.peak_swe != null;
    const sm50Met = site.sm50_met !== "TBD" && site.sm50_day != null;

    // peak SWE by year
    const peakG = d3.select("svg#peak-svg").append("g").classed("trend", true);
    peakG.append("path")
      .datum(years)
      .attr("d", d3.line().defined(d => d.peak_swe != null).x(d => xYear(d.water_year)).y(d => yPeak(d.peak_swe)))
      .attr("fill", "transparent")
      .attr("stroke", "black")
      .attr("stroke-width", "2px");
    if (peakMet) {
      peakG.append("circle")
        .attr("cx", xYear(wy))
        .attr("cy", yPeak(site.peak_swe))
        .attr("r", 4)
        .attr("fill", "orchid");
    }

    // melt date by year
    const meltG = d3.select("svg#melt-svg").append("g").classed("trend", true);
    meltG.append("path")
      .datum(years)
      .attr("d", d3.line().defined(d => d.sm50_day != null).x(d => xYear(d.water_year)).y(d => yMelt(d.sm50_day)))
      .attr("fill", "transparent")
      .attr("stroke", "black")
      .attr("stroke-width", "2px");
    if (sm50Met) {
      meltG.append("circle")
        .attr("cx", xYear(wy))
        .attr("cy", yMelt(site.sm50_day))
        .attr("r", 4)
        .attr("fill", "white")
        .attr("stroke", "orchid")
        .attr("stroke-width", 1.5);
    }

    // SWE through the focal water year, with its peak and SM50
    const wyG = d3.select("svg#wy21-svg").append("g").classed("trend", true);
    wyG.append("path")
      .datum(days)
      .attr("d", d3.line().defined(d => d.swe != null).x(d => xDay(d.day)).y(d => ySwe(d.swe)))
      .attr("fill", "transparent")
      .attr("stroke", "black")
      .attr("stroke-width", 2);
    if (peakMet) {
      wyG.append("circle")
        .attr("cx", xDay(site.peak_day))
        .attr("cy", ySwe(site.peak_swe))
        .attr("r", 4)
        .attr("fill", "orchid");
    }
    if (sm50Met) {
      wyG.append("circle")
        .attr("cx", xDay(site.sm50_day))
        .attr("cy", ySwe(site.sm50_swe))
        .attr("r", 4)
        .attr("fill", "white")
        .attr("stroke", "orchid")
        .attr("stroke-width", 1.5);
    }

    const wySvg = d3.select("svg#wy21-svg");
    wySvg.append("text")
      .classed("site_name", true)
      .attr("fill", "#000")
      .attr("font-size", "1em")
      .attr("font-weight", "bold")
      .attr("text-anchor", "start")
      .attr("y", 20)
      .attr("x", 10)
      .text(site.site_name);
    wySvg.append("text")
      .classed("site_name", true)
      .attr("fill", "#000")
      .attr("font-size", "1em")
      .attr("font-weight", "bold")
      .attr("text-anchor", "start")
      .attr("y", 40)
      .attr("x", 10)
      .text(site.elev_ft + " ft");
  }

  function drawLegend() {
    const x = d3.scaleLinear()
      .domain([0, 1])
      .range([0, 250]);

    const xAxis = d3.axisBottom(x)
      .tickSize(10)
      .tickValues([0, ...threshold.domain(), 1])
      .tickFormat(d => d * 100 + '%');

    const g = d3.select("svg#legend-percentile").append("g")
      .classed("thresh-legend", true).call(xAxis)
      .attr("transform", "translate(20,45)");

    g.select(".domain").remove();

    g.selectAll("rect")
      .data(threshold.range().map(color => {
        const d = threshold.invertExtent(color);
        if (d[0] == null) d[0] = x.domain()[0];
        if (d[1] == null) d[1] = x.domain()[1];
        return d;
      }))
      .enter().insert("rect", ".tick")
        .attr("height", 6)
        .attr("x", d => x(d[0]))
        .attr("width", d => x(d[1]) - x(d[0]))
        .attr("fill", d => threshold(d[0]));

    g.append("text")
      .attr("fill", "#000")
      .attr("font-size", "1.25em")
      .attr("text-anchor", "start")
      .attr("y", -10)
      .text(`${percentileDayLabel.value} SWE percentile`);

    g.append("text")
      .attr("fill", "#000")
      .attr("font-size", "2em")
      .attr("font-weight", "bold")
      .attr("text-anchor", "start")
      .attr("x", 0)
      .attr("y", -30)
      .text("Snow this year");

    // key for sites without a percentile
    g.append("circle")
      .attr("cx", 5)
      .attr("cy", 36)
      .attr("r", 4)
      .attr("fill", noPercentileFill)
      .attr("stroke", noPercentileStroke)
      .attr("stroke-width", 0.8);
    g.append("text")
      .attr("fill", "#000")
      .attr("font-size", "10px")
      .attr("text-anchor", "start")
      .attr("x", 14)
      .attr("y", 39.5)
      .text("No percentile");
  }
</script>
<style lang="scss" scoped>
  .leggy {
    display: inline-block;
  }
  .site-picker {
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
    max-width: 700px;
    margin: 0 auto 1rem auto;
    padding: 0 10px;
    font-size: 0.8em;
    text-align: left;
    select {
      max-width: 100%;
      padding: 0.25rem;
      font: inherit;
    }
  }
  .site-picker__label {
    font-weight: 700;
  }
  // the explanatory paragraphs reuse .figureCaption for its type styles;
  // keep them block so the inline legend symbols lay out in the text
  .figureCaption {
    display: block;
  }

  .map-grid{
    display: grid;
    grid-template-columns: repeat(6, 16.6%);
    grid-template-areas: 
      "legend legend legend legend legend ."
      "ak ak ak ak ak ak"
      "us us us us us us"
      "peak peak peak wy21 wy21 wy21"
      "melt melt melt wy21 wy21 wy21"
    ;
    overflow: hidden;
  }
  line, polyline, polygon, path, rect, circle {
    fill: none;
    stroke: grey;
    stroke-linecap: round;
    stroke-linejoin: round;
    stroke-miterlimit: 10.00;
  }
  .explain {
    font-style: italic;
  }
  .map-container {
    width: 100vw;
  }
  // Each map is a stack of pipeline layers on one pixel grid: the frame shows
  // the 2021 map's part of the panel, and the stack is positioned inside it
  .map-frame {
    position: relative;
    width: 100%;
    overflow: hidden;
  }
  .map-stack {
    position: absolute;
  }
  .map-layer {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    :deep(svg) {
      display: block;
      width: 100%;
      height: 100%;
    }
  }
  // Line widths as on the 2021 map (state lines 2 units, outline 1 unit), in
  // panel pixels: one 2021 map unit is 2.611 CONUS or 3.092 Alaska pixels
  #usa .map-states :deep(path) {
    stroke-width: 5.222;
  }
  #usa .map-outline :deep(path) {
    stroke-width: 2.611;
  }
  #ak .map-outline :deep(path) {
    stroke-width: 3.092;
  }
  #legendContainer{
    grid-area: legend;
    margin-bottom: 0px;
    margin-left: 30px;
    z-index: 1;
  }
  #grid-left{
    grid-area: ak;
    width: 190vw;
    margin-right: 2.5vw; 
  }
  #ak{
    width: 110vw;// careful editing this, it's sizing the maps to be on the same scale
  }
  #grid-right{
    grid-area: us;
    width: 90vw;
    margin-left: 70px;
  }
  #usa{
    width: 160vw;// careful editing this, it's sizing the maps to be on the same scale
  }
  #peak-container{
    grid-area: peak;
  }
  #melt-container{
    grid-area: melt;
  }
  #wy21-container{
    grid-area: wy21;
  }

  @media screen and (min-width: 1024px){
    #melt-svg {
      transform: translate(0, 0px);
    }
    #peak-svg {
      transform: translate(0, -5px);
    }
    .map-grid{
      grid-template-areas: 
        ". legend legend us us us"
        ". wy21 peak us us us"
        ". wy21 peak us us us"
        ". wy21 melt us us us"
        ". wy21 melt us us us"
        ". ak ak us us us"
        ". ak ak us us us"
        ". ak ak us us us"
        ". ak ak us us us"
        ". . . us us us";
    }
    #grid-left{
      width: 30vw; // careful editing this, it's sizing the maps to the same scale
    }
    #legendContainer {
      margin-top: 0px;
    }
    #ak {
      width: 55vw;// 2x the width of the containerthis needs to match with #usa to keep scaling constant
    }
    #grid-right {
      width: 70vw;// careful editing this, it's sizing the maps to the same scale
      margin-right: 2.5vw;
      margin-left: 0px;
    }
    #usa{
      width: 80vw; // 2x the width of the container, get cut off (intentionally). needs to be mirror with alaska
    }
  }

  @media screen and (min-height: 900px){
    #melt-svg {
      transform: translate(0, 5px);
    }
    #peak-svg {
      transform: translate(0, 0px);
    }
    .map-grid{
      grid-template-areas: 
        ". legend legend us us us"
        ". wy21 peak us us us"
        ". wy21 peak us us us"
        ". wy21 melt us us us"
        ". wy21 melt us us us"
        "ak ak . us us us"
        "ak ak . us us us"
        "ak ak . us us us"
        "ak ak . us us us"
        ". . . us us us";
    }
    #grid-left{
      width: 30vw; // careful editing this, it's sizing the maps to the same scale
    }
    #legendContainer {
      margin-top: 0px;
      margin-left: 20px;
    }
    #ak {
      width: 60vw;// 2x the width of the containerthis needs to match with #usa to keep scaling constant
      margin-left: 30px;
      padding-top: 50px;
    }
    #grid-right {
      width: 70vw;// careful editing this, it's sizing the maps to the same scale
      margin-right: 2.5vw;
      margin-left: 0px;
    }
    #usa{
      width: 100vw; // 2x the width of the container, get cut off (intentionally). needs to be mirror with alaska
      margin-left: -25px;
    }
  }
</style>