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
        <p class="map-summary">
          {{ summaryText }}
        </p>

        <div class="snotel-grid">
          <!-- LEGEND -->
          <div class="snotel-legend">
            <svg
              id="legend-percentile"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 320 125"
              preserveAspectRatio="xMinYMin"
              width="100%"
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
                </h3>
                <p class="site-card__meta">
                  {{ selected.state_name }} &middot; {{ formatNumber(selected.elev_ft) }} ft
                </p>
                <dl>
                  <dt>{{ percentileDayLabel }} SWE</dt>
                  <dd>{{ selected.swe == null ? 'No data' : `${selected.swe} in` }}</dd>
                  <dt>Percentile</dt>
                  <dd>
                    <span
                      class="swatch"
                      :style="{ background: siteFill(selected), borderColor: siteStroke(selected) }"
                      aria-hidden="true"
                    />
                    {{ percentileText(selected) }}
                  </dd>
                  <dt>Peak SWE in {{ info.water_year }}</dt>
                  <dd>
                    {{ peakText(selected) }}
                    <span
                      v-if="peakNormalText(selected)"
                      class="site-card__normal"
                    >{{ peakNormalText(selected) }}</span>
                  </dd>
                  <dt>Melt date (SM50)</dt>
                  <dd>
                    {{ sm50Text(selected) }}
                    <span
                      v-if="sm50NormalText(selected)"
                      class="site-card__normal"
                    >{{ sm50NormalText(selected) }}</span>
                  </dd>
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

  const summaryText = computed(() => {
    const withPercentile = sites.value.filter(d => d.ptile_swe != null);
    const low = withPercentile.filter(d => d.ptile_swe < 0.1).length;
    const high = withPercentile.filter(d => d.ptile_swe >= 0.9).length;
    const share = Math.round(100 * low / withPercentile.length);
    return `On ${percentileDateLabel.value}, ${low} of the ${withPercentile.length} SNOTEL sites with a percentile (${share}%) were below the 10th percentile, and ${high} were at or above the 90th.`;
  });

  // Site details
  function percentileText(site) {
    if (site.ptile_swe == null) return "No percentile";
    const pct = Math.round(site.ptile_swe * 100);
    if (site.ptile_swe === 0) return `${ordinal(pct)} percentile (lowest on record)`;
    if (site.ptile_swe === 1) return `${ordinal(pct)} percentile (highest on record)`;
    return `${ordinal(pct)} percentile`;
  }
  function daysFromNormal(day, normalDay) {
    const diff = Math.round(day - normalDay);
    if (diff === 0) return "same day as normal";
    return `${Math.abs(diff)} day${Math.abs(diff) === 1 ? '' : 's'} ${diff < 0 ? 'earlier' : 'later'} than normal`;
  }
  function peakText(site) {
    if (site.peak_swe == null || site.peak_met === "TBD") return `Not reached by ${dataEndLabel.value}`;
    return `${site.peak_swe} in on ${formatMonthDay(site.peak_date)}`;
  }
  function peakNormalText(site) {
    if (site.normal_peak_swe == null || site.peak_swe == null || site.peak_met === "TBD") return '';
    return `Normal: ${site.normal_peak_swe} in around ${formatMonthDay(waterDayDate(site.normal_peak_day))} (${daysFromNormal(site.peak_day, site.normal_peak_day)})`;
  }
  function sm50Text(site) {
    if (site.sm50_day == null || site.sm50_met === "TBD") return `Not reached by ${dataEndLabel.value}`;
    return formatMonthDay(site.sm50_date);
  }
  function sm50NormalText(site) {
    if (site.normal_sm50_day == null || site.sm50_day == null || site.sm50_met === "TBD") return '';
    return `Normal: around ${formatMonthDay(waterDayDate(site.normal_sm50_day))} (${daysFromNormal(site.sm50_day, site.normal_sm50_day)})`;
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
    const x = d3.scaleLinear().domain([0, 1]).range([0, 250]);
    const breaks = [0, ...threshold.domain(), 1];

    const g = d3.select("svg#legend-percentile").append("g")
      .attr("transform", "translate(40,55)");

    g.append("text")
      .attr("font-size", "2em")
      .attr("font-weight", "bold")
      .attr("y", -30)
      .text("Snow this year");
    g.append("text")
      .attr("font-size", "1.25em")
      .attr("y", -10)
      .text(`${percentileDayLabel.value} SWE percentile`);

    g.selectAll("rect")
      .data(threshold.range())
      .join("rect")
        .attr("x", (d, i) => x(breaks[i]))
        .attr("width", (d, i) => x(breaks[i + 1]) - x(breaks[i]))
        .attr("height", 6)
        .attr("fill", d => d);

    const axis = g.append("g")
      .call(d3.axisBottom(x).tickSize(10).tickValues(breaks).tickFormat(d => d * 100 + '%'));
    axis.select(".domain").remove();

    // number of sites in each class, under the ramp
    g.append("text")
      .attr("font-size", "9px")
      .attr("fill", "#5c5c5c")
      .attr("text-anchor", "end")
      .attr("x", -6)
      .attr("y", 38)
      .text("Sites");
    g.selectAll("text.class-count")
      .data(classCounts.value)
      .join("text")
        .attr("class", "class-count")
        .attr("font-size", "9px")
        .attr("fill", "#5c5c5c")
        .attr("text-anchor", "middle")
        .attr("x", (d, i) => x((breaks[i] + breaks[i + 1]) / 2))
        .attr("y", 38)
        .text(d => d);

    g.append("circle")
      .attr("cx", 5)
      .attr("cy", 55)
      .attr("r", 4)
      .attr("fill", noPercentileFill)
      .attr("stroke", noPercentileStroke)
      .attr("stroke-width", 0.8);
    g.append("text")
      .attr("font-size", "10px")
      .attr("x", 14)
      .attr("y", 58.5)
      .text(`No percentile (${noPercentileCount.value} sites)`);
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
  });

  onBeforeUnmount(() => {
    if (resizeObserver) resizeObserver.disconnect();
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
  .map-summary {
    font-size: 1em;
    line-height: 1.5;
    margin-bottom: 1rem;
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
  .snotel-legend {
    grid-area: legend;
    max-width: 26rem;
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
    font-size: 0.7em;
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
    font-size: 0.8em;
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
    margin: 0;
    font-size: 1.2em;
  }
  .site-card__meta {
    margin: 0 0 0.75rem;
    color: var(--medium-grey-dark);
  }
  .site-card__prompt {
    color: var(--medium-grey-dark);
    font-style: italic;
  }
  .site-card__normal {
    display: block;
    font-size: 0.85em;
    color: var(--medium-grey-dark);
  }
  .site-card dl {
    margin: 0;
    font-size: 0.9em;
    dt {
      font-weight: 700;
      margin-top: 0.6rem;
    }
    dd {
      margin: 0;
    }
  }

</style>
