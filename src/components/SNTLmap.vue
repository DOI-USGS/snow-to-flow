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
      <p class="explain figureCaption">
        Select a site on the map, or choose one from the list, to see its {{ percentileDayLabel }} SWE and when its snow peaked and melted in water year {{ info.water_year }}.
      </p>
    </template>
    <!-- FIGURES -->
    <template #figures>
      <div
        v-if="loaded"
        class="snotel-map"
      >
        <div class="snotel-grid">
          <!-- LEGEND -->
          <div class="snotel-legend">
            <h3 class="snotel-legend__title">
              Snow this year
            </h3>
            <p class="snotel-legend__subtitle">
              {{ percentileDayLabel }} SWE percentile
            </p>
            <svg
              id="legend-percentile"
              xmlns="http://www.w3.org/2000/svg"
              :width="legendSize.width"
              :height="legendSize.height"
              role="img"
              :aria-label="legendLabel"
            />
          </div>

          <!-- SELECTED SITE -->
          <aside class="site-card">
            <label class="site-picker">
              <span class="site-picker__label">Choose a site</span>
              <select
                :value="selected ? selected.sntl_id : ''"
                @change="onSitePicked"
              >
                <option
                  value=""
                  disabled
                >
                  Select a SNOTEL site
                </option>
                <optgroup
                  v-for="[stateName, stateSites] in sitesByState"
                  :key="stateName"
                  :label="stateName"
                >
                  <option
                    v-for="site in stateSites"
                    :key="site.sntl_id"
                    :value="site.sntl_id"
                  >
                    {{ site.site_name }} ({{ site.elev_ft }} ft)
                  </option>
                </optgroup>
              </select>
            </label>

            <div
              class="site-card__details"
              aria-live="polite"
            >
              <template v-if="selected">
                <h3 class="site-card__name">
                  {{ selected.site_name }}
                  <span class="site-card__meta">&middot; {{ selected.state_name }} &middot; {{ formatNumber(selected.elev_ft) }} ft</span>
                </h3>
                <div
                  ref="chartBox"
                  class="site-chart"
                >
                  <svg
                    v-show="chartData"
                    id="site-chart"
                    xmlns="http://www.w3.org/2000/svg"
                    role="img"
                    :aria-label="chartLabel"
                  />
                  <p
                    v-if="!selected.has_charts"
                    class="site-card__note"
                  >
                    Too few years of record for a chart.
                  </p>
                </div>
                <dl>
                  <div>
                    <dt>{{ percentileDayLabel }} SWE:</dt>
                    <dd>{{ selected.swe == null ? 'No data' : `${selected.swe} in` }}</dd>
                  </div>
                  <div>
                    <dt>Percentile:</dt>
                    <dd>
                      <span
                        class="swatch"
                        :style="{ background: siteFill(selected), borderColor: siteStroke(selected) }"
                        aria-hidden="true"
                      />
                      {{ percentileText(selected) }}
                    </dd>
                  </div>
                  <div>
                    <dt>Peak SWE:</dt>
                    <dd>{{ peakText(selected) }}</dd>
                  </div>
                  <div>
                    <dt>Melt date (SM50):</dt>
                    <dd>{{ sm50Text(selected) }}</dd>
                  </div>
                </dl>
              </template>
              <p
                v-else
                class="site-card__prompt"
              >
                Select a site on the map to see its details here.
              </p>
            </div>
          </aside>

          <!-- WESTERN U.S. -->
          <figure class="map-west">
            <div
              ref="westStack"
              class="map-stack"
              :style="stackStyle('west')"
            >
              <img
                class="map-layer map-fade"
                :src="layers.west.hillshade"
                alt=""
              >
              <div
                class="map-layer map-fade map-states"
                v-html="layers.west.states"
              />
              <div
                class="map-layer map-fade map-outline"
                v-html="layers.west.outline"
              />
              <svg
                id="west-sites"
                class="map-layer map-sites"
                xmlns="http://www.w3.org/2000/svg"
                :viewBox="viewBox('west')"
                role="img"
                :aria-label="mapLabel('the western U.S.')"
              />
            </div>
          </figure>

          <!-- ALASKA -->
          <figure class="map-ak">
            <div
              ref="akStack"
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
                id="ak-sites"
                class="map-layer map-sites"
                xmlns="http://www.w3.org/2000/svg"
                :viewBox="viewBox('ak')"
                role="img"
                :aria-label="mapLabel('Alaska')"
              />
            </div>
            <figcaption class="map-ak__label">
              Alaska (not to scale)
            </figcaption>
          </figure>
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
          <p>{{ percentileDayLabel }} has traditionally been used as an indicator of peak SWE for the season. In {{ info.water_year }}, most sites peaked well before {{ percentileDayLabel }}, about three weeks earlier than usual, and half their snow had melted about a month earlier than usual. Select a site to see when its snow peaked and when half of it had melted.</p>
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
  import { onBeforeUnmount, ref, computed, nextTick, onMounted } from 'vue';
  import * as d3 from 'd3';
  import VizSection from '@/components/VizSection.vue';
  import ExpandingSidebar from '@/components/ExpandingSidebar.vue';

  // Map layers built by the targets pipeline (3_visualize): a hillshade and
  // state and outline SVGs, on one pixel grid per panel. Alaska is an inset
  // with its own scale, drawn by its outline.
  import westHillshade from '@/assets/maps/snotel_west_hillshade.png';
  import westStates from '@/assets/maps/snotel_west_states.svg?raw';
  import westOutline from '@/assets/maps/snotel_west_outline.svg?raw';
  import akHillshade from '@/assets/maps/snotel_ak_hillshade.png';
  import akOutline from '@/assets/maps/snotel_ak_outline.svg?raw';

  const publicPath = import.meta.env.BASE_URL;

  const layers = {
    west: { hillshade: westHillshade, states: westStates, outline: westOutline },
    ak: { hillshade: akHillshade, outline: akOutline }
  };

  // Data, loaded on mount
  const loaded = ref(false);
  const info = ref({});
  const panels = ref({});
  const sites = ref([]);
  const selected = ref(null);

  // Percentile colour scale, with the NRCS interactive map's percentile breaks
  const threshold = d3.scaleThreshold()
    .domain([0.1, 0.3, 0.5, 0.7, 0.9])
    .range(["#5C3406", "#C28D3D", "#ECD8A6", "#AADDD6", "#2A8C83", "#004439"]);
  const noPercentileFill = "#c4c4c4";
  const noPercentileStroke = "#7a7a7a";
  const siteFill = d => d.ptile_swe == null ? noPercentileFill : threshold(d.ptile_swe);
  const siteStroke = d => d.ptile_swe == null ? noPercentileStroke : "black";

  // Site marks, in screen pixels; converted to each panel's units on resize
  const siteRadiusPx = 4.5;
  const selectedRadiusPx = 8;
  const hitRadiusPx = 24; // how far from a site a tap or click still selects it

  // Labels
  const formatNumber = d3.format(",");
  const formatLongDate = d3.utcFormat('%B %-d, %Y');
  const formatMonthDay = d3.utcFormat('%B %-d');
  const ordinal = n => {
    const suffix = [11, 12, 13].includes(n % 100) ? 'th' : ({ 1: 'st', 2: 'nd', 3: 'rd' }[n % 10] || 'th');
    return `${n}${suffix}`;
  };
  // e.g. "April 1st", and "April 1st, 2026"
  const percentileDayLabel = computed(() => {
    const d = info.value.percentile_date;
    return d ? `${d3.utcFormat('%B')(d)} ${ordinal(d.getUTCDate())}` : '';
  });
  const percentileDateLabel = computed(() =>
    percentileDayLabel.value ? `${percentileDayLabel.value}, ${info.value.percentile_date.getUTCFullYear()}` : ''
  );
  const dataEndLabel = computed(() =>
    info.value.data_end_date ? formatLongDate(info.value.data_end_date) : ''
  );
  const mapLabel = region => `Map of SNOTEL sites in ${region}, colored by ${percentileDayLabel.value} SWE percentile`;

  // Water day (1 = October 1) of the focal water year as a date
  const waterDayDate = day => new Date(Date.UTC(info.value.water_year - 1, 9, day));

  // Legend drawing size, in screen pixels
  const legendSize = { width: 340, height: 88, left: 44, rampWidth: 270 };

  // Sites in each percentile class, and without a percentile
  const classCounts = computed(() => {
    const counts = threshold.range().map(() => 0);
    for (const d of sites.value) {
      if (d.ptile_swe != null) counts[threshold.range().indexOf(threshold(d.ptile_swe))] += 1;
    }
    return counts;
  });
  const noPercentileCount = computed(() => sites.value.filter(d => d.ptile_swe == null).length);
  const legendLabel = computed(() => {
    const breaks = [0, ...threshold.domain(), 1];
    const classes = classCounts.value.map((n, i) => `${breaks[i] * 100} to ${breaks[i + 1] * 100} percent: ${n} sites`);
    return `${percentileDayLabel.value} SWE percentile legend. ${classes.join('; ')}; no percentile: ${noPercentileCount.value} sites.`;
  });

  // Site details
  function percentileText(site) {
    if (site.ptile_swe == null) return "No percentile";
    const pct = Math.round(site.ptile_swe * 100);
    if (site.ptile_swe === 0) return `${ordinal(pct)} percentile (lowest on record)`;
    if (site.ptile_swe === 1) return `${ordinal(pct)} percentile (highest on record)`;
    return `${ordinal(pct)} percentile`;
  }
  function peakText(site) {
    if (site.peak_swe == null || site.peak_met === "TBD") return `Not reached by ${dataEndLabel.value}`;
    const text = `${site.peak_swe} in on ${formatMonthDay(site.peak_date)}`;
    if (site.normal_peak_swe == null) return text;
    return `${text} (normal ${site.normal_peak_swe} in, ${formatMonthDay(waterDayDate(site.normal_peak_day))})`;
  }
  function sm50Text(site) {
    if (site.sm50_day == null || site.sm50_met === "TBD") return `Not reached by ${dataEndLabel.value}`;
    const text = formatMonthDay(site.sm50_date);
    if (site.normal_sm50_day == null) return text;
    return `${text} (normal ${formatMonthDay(waterDayDate(site.normal_sm50_day))})`;
  }

  // Site picker, grouped by state
  const sitesByState = computed(() =>
    d3.groups(sites.value, d => d.state_name)
      .sort(([a], [b]) => a.localeCompare(b))
      .map(([state, list]) => [state, [...list].sort((a, b) => a.site_name.localeCompare(b.site_name))])
  );
  function onSitePicked(event) {
    const site = sites.value.find(d => d.sntl_id === event.target.value);
    if (site) selectSite(site);
  }

  // Map drawing
  const westStack = ref(null);
  const akStack = ref(null);
  const panelMarks = {}; // per panel: svg, site circles, selection ring, Delaunay index
  let resizeObserver = null;

  function viewBox(panel) {
    const p = panels.value[panel];
    return p ? `0 0 ${p.width_px} ${p.height_px}` : undefined;
  }
  function stackStyle(panel) {
    const p = panels.value[panel];
    return p ? { aspectRatio: `${p.width_px} / ${p.height_px}` } : {};
  }
  // panel units per screen pixel
  function unitsPerPx(panel) {
    const width = panelMarks[panel].svg.node().getBoundingClientRect().width;
    return width ? panels.value[panel].width_px / width : 1;
  }

  function drawPanel(panel) {
    const svg = d3.select(`#${panel}-sites`);
    const data = sites.value.filter(d => d.panel === panel);
    const circles = svg.append("g")
      .selectAll("circle")
      .data(data)
      .join("circle")
        .attr("class", "site")
        .attr("cx", d => d.x)
        .attr("cy", d => d.y)
        .attr("fill", siteFill)
        .attr("stroke", siteStroke);
    const ring = svg.append("circle")
      .attr("class", "site-ring")
      .attr("fill", "none")
      .attr("stroke", "#111")
      .attr("display", "none");
    const delaunay = d3.Delaunay.from(data, d => d.x, d => d.y);

    // A mouse selects the nearest site as it moves, and the selection stays
    // until another site is reached; a tap or click selects too
    const pick = event => {
      const [px, py] = d3.pointer(event, svg.node());
      const site = data[delaunay.find(px, py)];
      if (site && Math.hypot(site.x - px, site.y - py) / unitsPerPx(panel) <= hitRadiusPx) {
        selectSite(site);
      }
    };
    svg
      .on("pointermove", event => { if (event.pointerType === "mouse") pick(event); })
      .on("click", pick);

    panelMarks[panel] = { svg, circles, ring };
  }

  // Keep site marks the same size on screen however large the map is drawn
  // Legend: the percentile ramp with its breaks, the number of sites in each
  // class, and a key for sites without a percentile
  function drawLegend() {
    const { left, rampWidth } = legendSize;
    const x = d3.scaleLinear().domain([0, 1]).range([0, rampWidth]);
    const breaks = [0, ...threshold.domain(), 1];

    const g = d3.select("svg#legend-percentile").append("g")
      .attr("transform", `translate(${left},4)`);

    g.selectAll("rect")
      .data(threshold.range())
      .join("rect")
        .attr("x", (d, i) => x(breaks[i]))
        .attr("width", (d, i) => x(breaks[i + 1]) - x(breaks[i]))
        .attr("height", 10)
        .attr("fill", d => d);

    const axis = g.append("g")
      .attr("class", "legend-axis")
      .call(d3.axisBottom(x).tickSize(14).tickValues(breaks).tickFormat(d => d * 100 + '%'));
    axis.select(".domain").remove();

    // number of sites in each class, under the ramp
    g.append("text")
      .attr("class", "legend-note")
      .attr("text-anchor", "end")
      .attr("x", -8)
      .attr("y", 52)
      .text("Sites");
    g.selectAll("text.class-count")
      .data(classCounts.value)
      .join("text")
        .attr("class", "class-count legend-note")
        .attr("text-anchor", "middle")
        .attr("x", (d, i) => x((breaks[i] + breaks[i + 1]) / 2))
        .attr("y", 52)
        .text(d => d);

    g.append("circle")
      .attr("cx", 6)
      .attr("cy", 72)
      .attr("r", 5.5)
      .attr("fill", noPercentileFill)
      .attr("stroke", noPercentileStroke);
    g.append("text")
      .attr("class", "legend-label")
      .attr("x", 18)
      .attr("y", 77)
      .text(`No percentile (${noPercentileCount.value} sites)`);
  }

  // Site chart: the focal year's SWE over the site's percentile bands for each
  // day of the water year, in the map's colors. Loaded when a site is chosen.
  const chartBox = ref(null);
  const chartData = ref(null);
  const chartCache = new Map();
  const chartLabel = computed(() => selected.value
    ? `Chart of SWE at ${selected.value.site_name} through water year ${info.value.water_year}, over bands showing the site's SWE percentiles on each day in earlier years`
    : '');
  let chartObserver = null;

  async function loadChart(site) {
    chartData.value = null;
    if (!site.has_charts) return;
    let data = chartCache.get(site.site_id);
    if (!data) {
      data = await d3.json(`${publicPath}data/snotel_sites/${site.site_id}.json`);
      chartCache.set(site.site_id, data);
    }
    if (selected.value !== site) return; // another site was chosen meanwhile
    chartData.value = data;
    await nextTick();
    if (chartObserver) chartObserver.observe(chartBox.value);
    drawChart();
  }

  function drawChart() {
    const data = chartData.value;
    if (!data || !chartBox.value) return;
    const width = chartBox.value.clientWidth;
    const height = 170;
    const m = { top: 8, right: 8, bottom: 22, left: 34 };
    const svg = d3.select("svg#site-chart").attr("width", width).attr("height", height);
    svg.selectAll("*").remove();

    const lastDay = Math.max(365, data.swe.length);
    const x = d3.scaleLinear().domain([1, lastDay]).range([m.left, width - m.right]);
    const yMax = d3.max([...data.bands.map(b => b[6]), ...data.swe.filter(v => v != null)]) || 1;
    const y = d3.scaleLinear().domain([0, yMax]).nice(4).range([height - m.bottom, m.top]);

    // bands between the min, 10th, 30th, 50th, 70th, 90th percentiles, and max
    const band = i => d3.area()
      .x((d, j) => x(data.band_days[j]))
      .y0(d => y(d[i]))
      .y1(d => y(d[i + 1]))
      .curve(d3.curveMonotoneX);
    svg.append("g")
      .selectAll("path")
      .data(threshold.range())
      .join("path")
        .attr("d", (color, i) => band(i)(data.bands))
        .attr("fill", color => color)
        .attr("fill-opacity", 0.55);

    const axisX = svg.append("g")
      .attr("class", "chart-axis")
      .attr("transform", `translate(0,${height - m.bottom})`)
      .call(d3.axisBottom(x)
        .tickValues([1, 93, 183, 274])
        .tickFormat((d, i) => ["Oct", "Jan", "Apr", "Jul"][i])
        .tickSizeOuter(0));
    axisX.select(".domain").attr("stroke", "#9e9e9e");
    const axisY = svg.append("g")
      .attr("class", "chart-axis")
      .attr("transform", `translate(${m.left},0)`)
      .call(d3.axisLeft(y).ticks(4).tickSize(0).tickPadding(6));
    axisY.select(".domain").remove();
    axisY.append("text")
      .attr("x", -m.left + 2)
      .attr("y", m.top + 2)
      .attr("text-anchor", "start")
      .attr("fill", "currentColor")
      .text("in");

    // the percentile date, and SWE through the water year
    const pDay = d3.utcDay.count(Date.UTC(info.value.water_year - 1, 9, 1), info.value.percentile_date) + 1;
    svg.append("line")
      .attr("x1", x(pDay)).attr("x2", x(pDay))
      .attr("y1", m.top).attr("y2", height - m.bottom)
      .attr("stroke", "#5c5c5c")
      .attr("stroke-dasharray", "3 3");
    svg.append("path")
      .datum(data.swe.map((v, i) => [i + 1, v]))
      .attr("d", d3.line().defined(d => d[1] != null).x(d => x(d[0])).y(d => y(d[1])))
      .attr("fill", "none")
      .attr("stroke", "#111")
      .attr("stroke-width", 2);
    const pSwe = data.swe[pDay - 1];
    if (pSwe != null) {
      svg.append("circle")
        .attr("cx", x(pDay))
        .attr("cy", y(pSwe))
        .attr("r", 4.5)
        .attr("fill", siteFill(selected.value))
        .attr("stroke", "#111")
        .attr("stroke-width", 1.5);
    }
  }

  function sizeMarks() {
    for (const panel of Object.keys(panelMarks)) {
      const k = unitsPerPx(panel);
      panelMarks[panel].circles
        .attr("r", siteRadiusPx * k)
        .attr("stroke-width", 0.75 * k);
      panelMarks[panel].ring
        .attr("r", selectedRadiusPx * k)
        .attr("stroke-width", 2.5 * k);
    }
  }

  function selectSite(site) {
    if (selected.value === site) return;
    selected.value = site;
    loadChart(site);
    for (const [panel, marks] of Object.entries(panelMarks)) {
      if (panel === site.panel) {
        marks.ring.attr("cx", site.x).attr("cy", site.y).attr("display", null).raise();
      } else {
        marks.ring.attr("display", "none");
      }
    }
  }

  onMounted(async () => {
    const [runInfo, panelRows, siteRows] = await Promise.all([
      d3.csv(publicPath + "data/snotel_run_info.csv", d3.autoType),
      d3.csv(publicPath + "data/snotel_map_panels.csv", d3.autoType),
      d3.csv(publicPath + "data/snotel_sites.csv", d3.autoType)
    ]);
    info.value = runInfo[0];
    panels.value = Object.fromEntries(panelRows.map(d => [d.panel, d]));
    // has_charts is written as TRUE/FALSE, which d3.autoType leaves as text
    siteRows.forEach(d => { d.has_charts = d.has_charts === true || d.has_charts === "TRUE"; });
    sites.value = siteRows;
    loaded.value = true;

    await nextTick();
    drawLegend();
    drawPanel("west");
    drawPanel("ak");
    sizeMarks();
    resizeObserver = new ResizeObserver(sizeMarks);
    resizeObserver.observe(westStack.value);
    resizeObserver.observe(akStack.value);
    chartObserver = new ResizeObserver(() => drawChart());
  });

  onBeforeUnmount(() => {
    if (resizeObserver) resizeObserver.disconnect();
    if (chartObserver) chartObserver.disconnect();
  });
</script>

<style lang="scss" scoped>
  .explain {
    font-style: italic;
  }
  // the explanatory paragraphs reuse .figureCaption for its type styles
  .figureCaption {
    display: block;
  }

  .snotel-map {
    max-width: 1100px;
    margin: 0 auto;
    padding: 0 10px;
    text-align: left;
  }
  .swatch {
    display: inline-block;
    flex: 0 0 auto;
    width: 1em;
    height: 1em;
    border: 1px solid;
    border-radius: 50%;
    vertical-align: middle;
  }

  // Legend, site details, and Alaska on the left, the western U.S. on the
  // right on wide screens; one column in reading order on narrow ones
  .snotel-grid {
    display: grid;
    grid-template-columns: minmax(0, 1fr);
    grid-template-areas:
      "legend"
      "card"
      "west"
      "ak";
    gap: 1rem;
  }
  @media screen and (min-width: 900px) {
    .snotel-grid {
      grid-template-columns: minmax(18rem, 2fr) minmax(0, 3fr);
      grid-template-areas:
        "legend west"
        "card west"
        "ak west";
      grid-template-rows: auto auto 1fr;
      column-gap: 2rem;
    }
  }
  // Text sizes follow one scale: map title 2.8rem, site name 2rem, legend
  // subtitle 1.8rem, panel text 1.6rem, legend and map labels 1.4rem, chart
  // axes 1.2rem
  .snotel-legend {
    grid-area: legend;
    svg {
      display: block;
      max-width: 100%;
    }
    :deep(.legend-axis text),
    :deep(.legend-label),
    :deep(.legend-note) {
      font-size: 1.4rem;
    }
    :deep(.legend-note) {
      fill: #5c5c5c;
    }
  }
  .snotel-legend__title {
    margin: 0;
    padding: 0;
    font-size: 2.8rem;
    line-height: 1.2;
  }
  .snotel-legend__subtitle {
    margin: 0 0 0.5rem;
    font-size: 1.8rem;
  }
  .site-card {
    grid-area: card;
  }
  .map-west {
    grid-area: west;
    margin: 0;
  }
  .map-ak {
    grid-area: ak;
    margin: 0;
  }
  .map-ak__label {
    font-size: 1.4rem;
    color: var(--medium-grey-dark);
  }
  .map-stack {
    position: relative;
    width: 100%;
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
  .map-sites {
    cursor: pointer;
    // touch taps select sites; vertical scrolling still works
    touch-action: pan-y;
  }
  // The western map fades out on the right, where it is cut off
  .map-fade {
    -webkit-mask-image: linear-gradient(to right, #000 78%, transparent 100%);
    mask-image: linear-gradient(to right, #000 78%, transparent 100%);
  }
  // Map lines keep the same width on screen however large the map is drawn
  .map-states :deep(path) {
    vector-effect: non-scaling-stroke;
    stroke: #9e9e9e;
    stroke-width: 1px;
  }
  .map-outline :deep(path) {
    vector-effect: non-scaling-stroke;
    stroke: #7a7a7a;
    stroke-width: 1.2px;
  }

  // Details card
  .site-card {
    padding: 1rem;
    border: 1px solid #ddd;
    border-radius: 4px;
    background: #fafafa;
  }
  .site-picker {
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
    margin-bottom: 1rem;
    font-size: 1.6rem;
    select {
      max-width: 100%;
      padding: 0.25rem;
      font: inherit;
    }
  }
  .site-picker__label {
    font-weight: 700;
  }
  .site-card__name {
    margin: 0 0 0.5rem;
    font-size: 2rem;
    line-height: 1.3;
  }
  .site-card__meta {
    font-weight: 400;
    color: var(--medium-grey-dark);
  }
  .site-card__prompt,
  .site-card__note {
    margin: 0;
    font-size: 1.6rem;
    font-style: italic;
    color: var(--medium-grey-dark);
  }
  // The details keep the height of a filled-in card, and the chart keeps its
  // height while loading or when a site has no chart, so the layout below
  // (Alaska) doesn't jump as sites are selected
  .site-card__details {
    min-height: 34rem;
  }
  .site-chart {
    height: 170px;
    margin-bottom: 0.75rem;
    svg {
      display: block;
    }
    :deep(.chart-axis text) {
      font-size: 1.2rem;
      fill: #5c5c5c;
    }
  }
  .site-card dl {
    margin: 0;
    font-size: 1.6rem;
    line-height: 1.5;
    div {
      margin: 0;
    }
    dt,
    dd {
      display: inline;
      margin: 0;
    }
    dd {
      margin-left: 0.3em;
    }
    dt {
      font-weight: 700;
    }
  }
</style>
