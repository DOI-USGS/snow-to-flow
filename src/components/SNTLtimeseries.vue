<template>
  <!---VizSection-->
  <VizSection
    id="SNTLtimeseries"
    :take-away="false"
  >
    <!-- EXPLANATION -->
    <template #aboveExplanation>
      <!-- PLACEHOLDER text, to be replaced -->
      <p>
        When snow peaks and how much of it there is shape how much water is available downstream, and when. A smaller snowpack holds less water for the dry months, and an early melt sends that water downstream sooner, when demand is lower and reservoirs may not be able to store it all. Streams can then run lower in late summer and fall, when water is needed for farms, cities, and ecosystems. Changes in the timing and magnitude of snowmelt from year to year, and over decades, affect how water is managed across the West.
      </p>
      <p>
        How does {{ info.water_year }} compare with other years? Select a dot, or choose a site from the list, to follow one site through time.
      </p>
    </template>
    <!-- FIGURES -->
    <template #figures>
      <div
        ref="box"
        class="snotel-ts"
      >
        <template v-if="loaded">
          <h3 class="snotel-ts__title">
            Peak snow and melt, {{ firstYear }}&ndash;{{ info.water_year }}
          </h3>

          <div class="ts-controls">
            <select
              class="ts-picker"
              aria-label="Choose a SNOTEL site to follow through time"
              :value="selected ? selected.sntl_id : ''"
              @change="onSitePicked"
            >
              <option
                value=""
                disabled
              >
                Choose a SNOTEL site
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
                  {{ site.site_name }}
                </option>
              </optgroup>
            </select>
            <button
              v-if="selected"
              type="button"
              class="ts-clear"
              @click="clearSelection"
            >
              Clear
            </button>
          </div>

          <div
            class="ts-details"
            aria-live="polite"
          >
            <template v-if="selected">
              <p class="ts-details__meta">
                {{ selected.state_name }} &middot; {{ d3.format(",")(selected.elev_ft) }} ft &middot; {{ selectedRows.length }} years since {{ firstYear }}
              </p>
              <!-- the popup shows these values on screen, but is hidden from
                   screen readers, so they are read from here -->
              <p
                v-if="selectedRow"
                class="ts-details__year sr-only"
              >
                <strong>{{ selectedYear }}:</strong>
                {{ peakYearText(selectedRow) }}; {{ meltYearText(selectedRow) }}
              </p>
            </template>
            <p
              v-else
              class="ts-details__prompt"
            >
              Point to or select a dot, or choose a site, to follow it through time.
            </p>
          </div>

          <!-- Arrow keys step through the selected site's years; the panels
               sit side by side and share the year axis -->
          <div
            class="ts-panels"
            tabindex="0"
            role="group"
            :aria-label="groupLabel"
            @keydown="onKey"
            @pointerleave="onLeaveCharts"
          >
            <figure
              v-for="panel in panels"
              :key="panel.key"
              class="ts-panel"
            >
              <figcaption class="ts-panel__title">
                <strong>{{ panel.title }}</strong> {{ panel.subtitle }}
                <span class="ts-key">
                  <span><span
                    class="ts-key__swatch"
                    :style="{ background: lessColor }"
                    aria-hidden="true"
                  /> {{ panel.less }}</span>
                  <span>{{ panel.more }} <span
                    class="ts-key__swatch"
                    :style="{ background: moreColor }"
                    aria-hidden="true"
                  /></span>
                </span>
              </figcaption>
              <div
                :ref="el => { stacks[panel.key] = el; }"
                class="ts-stack"
                :data-panel="panel.key"
                @pointermove="onPointerMove($event, panel)"
                @pointerleave="hover = null"
                @click="onClick($event, panel)"
              >
                <canvas :ref="el => { canvases[panel.key] = el; }" />
                <svg
                  :ref="el => { svgs[panel.key] = el; }"
                  role="img"
                  :aria-label="panelLabel(panel)"
                />
                <div
                  v-if="tip && tip.panel === panel.key"
                  class="ts-tip"
                  :style="tipStyle"
                  aria-hidden="true"
                >
                  <strong>{{ tip.site.site_name }}</strong>, {{ tip.row.water_year }}<br>
                  {{ peakYearText(tip.row) }}<br>
                  {{ meltYearText(tip.row) }}
                </div>
              </div>
            </figure>
          </div>
        </template>
      </div>
    </template>
    <!-- FIGURE CAPTION -->
    <template #figureCaption>
      <p>
        Each dot is one SNOTEL site in one year, compared with that site's own 1991&ndash;2020 normal, so high and low sites can be read together: brown dots had less snow or melted earlier than normal, and teal dots more snow or melted later. Shown are the {{ sitesWithNormals }} sites with at least 20 years of record in 1991&ndash;2020; values beyond an axis are drawn at its edge.
      </p>
    </template>
    <!-- EXPLANATION -->
    <template #belowExplanation>
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
  import { computed, nextTick, onBeforeUnmount, onMounted, ref, watch } from 'vue';
  import * as d3 from 'd3';
  import VizSection from '@/components/VizSection.vue';

  const publicPath = import.meta.env.BASE_URL;

  // Data
  const info = ref({});
  const sites = ref([]);
  const rows = ref([]);
  const loaded = ref(false);
  const sitesById = computed(() => new Map(sites.value.map(d => [d.site_id, d])));
  const firstYear = computed(() => info.value.record_start_wy);
  const sitesWithNormals = computed(() => new Set(rows.value.map(d => d.site_id)).size);
  const sitesByState = computed(() => d3.groups(
    sites.value.filter(d => rowsBySite.value.has(d.site_id)),
    d => d.state_name
  )
    .sort((a, b) => a[0].localeCompare(b[0]))
    .map(([state, list]) => [state, [...list].sort((a, b) => a.site_name.localeCompare(b.site_name))]));
  const rowsBySite = computed(() => d3.group(rows.value, d => d.site_id));

  // One panel per measure, each as a change from the site's normal. Axes are
  // clamped to hold nearly all values; the rest are drawn at the edge
  const panels = [
    {
      key: "peak",
      field: "peak_swe_pct",
      title: "Peak SWE",
      subtitle: "percent of normal",
      domain: [0, 300],
      normal: 100,
      ticks: [0, 100, 200, 300],
      ticksNarrow: [0, 100, 200, 300],
      colorStops: [0, 50, 100, 175, 250],
      less: "Less snow",
      more: "More snow",
      tickFormat: d => `${d}%`
    },
    {
      key: "melt",
      field: "sm50_diff",
      title: "Melt date (SM50)",
      subtitle: "days earlier (−) or later (+) than normal",
      domain: [-90, 60],
      normal: 0,
      ticks: [-90, -60, -30, 0, 30, 60],
      ticksNarrow: [-60, 0, 60],
      colorStops: [-60, -30, 0, 30, 60],
      less: "Earlier",
      more: "Later",
      tickFormat: d => d > 0 ? `+${d}` : d < 0 ? `−${-d}` : "0"
    }
  ];

  // Colors run from brown (less snow, earlier melt) through grey at normal to
  // teal (more snow, later melt), the map's hues with ends light enough to
  // tell apart as small dots (checked for color vision deficiency)
  const colorRange = ["#B06A1C", "#D1A15E", "#a3a3a3", "#5FB3AA", "#008C80"];
  const colorScales = Object.fromEntries(panels.map(p => [p.key,
    d3.scaleLinear().domain(p.colorStops).range(colorRange).interpolate(d3.interpolateLab).clamp(true)]));
  const lessColor = colorRange[0];
  const moreColor = colorRange[4];

  // Text
  const formatMonthDay = d3.utcFormat("%b %-d");
  // water day 1 is October 1 of the previous calendar year
  const waterDayDate = (wy, day) => d3.utcDay.offset(new Date(Date.UTC(wy - 1, 9, 1)), day - 1);
  function peakYearText(row) {
    if (row.peak_swe_pct == null) return "no peak SWE";
    return `peak SWE ${row.peak_swe} in, ${row.peak_swe_pct}% of normal`;
  }
  function meltYearText(row) {
    if (row.sm50_diff == null) return "no melt date";
    const date = formatMonthDay(waterDayDate(row.water_year, row.sm50_day));
    const diff = row.sm50_diff;
    const rel = diff === 0 ? "the normal date" : `${Math.abs(diff)} day${Math.abs(diff) === 1 ? "" : "s"} ${diff < 0 ? "earlier" : "later"} than normal`;
    return `melted ${date}, ${rel}`;
  }

  // The middle site in each year, for the charts' screen reader summaries
  const summaries = computed(() => Object.fromEntries(panels.map(panel => {
    const byYear = d3.rollups(
      rows.value.filter(d => d[panel.field] != null),
      v => ({ n: v.length, median: d3.median(v, d => d[panel.field]) }),
      d => d.water_year
    ).map(([year, s]) => ({ year, ...s }))
      .filter(d => d.n >= 10)
      .sort((a, b) => a.year - b.year);
    return [panel.key, byYear];
  })));
  function panelLabel(panel) {
    const s = summaries.value[panel.key];
    const focal = s?.find(d => d.year === info.value.water_year);
    const lead = `${panel.title}, ${panel.subtitle}, at ${sitesWithNormals.value} SNOTEL sites from ${firstYear.value} to ${info.value.water_year}.`;
    if (!focal) return lead;
    const value = panel.key === "peak" ? `${Math.round(focal.median)}% of normal` : `${Math.abs(Math.round(focal.median))} days ${focal.median < 0 ? "earlier" : "later"} than normal`;
    return `${lead} In ${info.value.water_year} the middle site was ${value}.`;
  }

  // Selection
  const selected = ref(null);
  const selectedYear = ref(null);
  const hover = ref(null);
  // the panel the popup sits in: the one last pointed to or tapped
  const tipPanel = ref("peak");
  // whether the mouse made the current selection, which then clears when the
  // mouse leaves the charts; a site chosen any other way stays selected
  let selectedByMouse = false;
  const selectedRows = computed(() => selected.value ? rowsBySite.value.get(selected.value.site_id) ?? [] : []);
  const selectedRow = computed(() => selectedRows.value.find(d => d.water_year === selectedYear.value));
  const groupLabel = computed(() => selected.value
    ? `Charts following ${selected.value.site_name}. Use the up and down arrow keys to step through its years, and Escape to clear.`
    : "Peak SWE and melt date charts. Choose a site from the list above to follow it through time.");

  function selectSite(site, year, byMouse = false) {
    selectedByMouse = byMouse;
    selected.value = site;
    const years = (rowsBySite.value.get(site.site_id) ?? []).map(d => d.water_year);
    selectedYear.value = years.includes(year) ? year : d3.max(years);
  }
  function clearSelection() {
    selectedByMouse = false;
    selected.value = null;
    selectedYear.value = null;
  }
  function onLeaveCharts(event) {
    if (event.pointerType === "mouse" && selectedByMouse) clearSelection();
  }
  function onSitePicked(event) {
    const site = sites.value.find(d => d.sntl_id === event.target.value);
    if (site) selectSite(site, selectedYear.value ?? info.value.water_year);
  }
  function onKey(event) {
    if (event.key === "Escape") { clearSelection(); return; }
    if (!selected.value || !["ArrowUp", "ArrowDown", "ArrowLeft", "ArrowRight", "Home", "End"].includes(event.key)) return;
    event.preventDefault();
    const years = selectedRows.value.map(d => d.water_year);
    const i = years.indexOf(selectedYear.value);
    const next = {
      ArrowDown: Math.max(0, i - 1),
      ArrowUp: Math.min(years.length - 1, i + 1),
      ArrowLeft: Math.max(0, i - 1),
      ArrowRight: Math.min(years.length - 1, i + 1),
      Home: 0,
      End: years.length - 1
    }[event.key];
    selectedYear.value = years[next];
    selectedByMouse = false;
  }

  // Drawing: years run down the page, newest at the top, and each measure
  // runs left (less, earlier) to right (more, later). Every site-year is a dot
  // on a canvas, with the summary, axes, and selected site drawn in SVG on top
  const box = ref(null);
  const canvases = {};
  const svgs = {};
  const stacks = {};
  const hitRadiusPx = 20;
  const y = d3.scaleLinear();
  const xScales = Object.fromEntries(panels.map(p => [p.key, d3.scaleLinear().domain(p.domain)]));
  let height = 0;
  let narrow = false;
  const sizes = {}; // per panel: width and margins
  const points = {}; // per panel: rows with a value, their pixel positions, and a Delaunay index

  // Each site sits at the same small offset within every year, so the dots
  // spread across the year's row and a site's line stays smooth
  const jitter = id => (((id * 2654435761) >>> 0) % 1000) / 1000 * 0.7 - 0.35;
  const clampTo = (panel, v) => Math.max(panel.domain[0], Math.min(panel.domain[1], v));

  function layout() {
    narrow = box.value.clientWidth < 600;
    const nYears = info.value.water_year - firstYear.value + 1;
    const rowPx = narrow ? 12 : 14;
    const top = 28;
    const bottom = 8;
    height = top + nYears * rowPx + bottom;
    y.domain([info.value.water_year + 0.5, firstYear.value - 0.5]).range([top, height - bottom]);
    panels.forEach((panel, k) => {
      // the first panel carries the year labels
      const m = { top, bottom, left: k === 0 ? 44 : 14, right: 14 };
      const width = stacks[panel.key].clientWidth;
      sizes[panel.key] = { width, m };
      const x = xScales[panel.key].range([m.left, width - m.right]);
      const list = rows.value.filter(d => d[panel.field] != null);
      const px = list.map(d => x(clampTo(panel, d[panel.field])));
      const py = list.map(d => y(d.water_year + jitter(d.site_id)));
      points[panel.key] = { list, px, py, delaunay: d3.Delaunay.from(list, (d, i) => px[i], (d, i) => py[i]) };
    });
  }

  function drawDots(panel) {
    const { width } = sizes[panel.key];
    const canvas = canvases[panel.key];
    const dpr = window.devicePixelRatio || 1;
    canvas.width = width * dpr;
    canvas.height = height * dpr;
    canvas.style.width = `${width}px`;
    canvas.style.height = `${height}px`;
    const ctx = canvas.getContext("2d");
    ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
    ctx.clearRect(0, 0, width, height);
    const { list, px, py } = points[panel.key];
    // colored by value in 24 steps, one path per step; dimmer while a site is
    // selected, so its line stands out
    const color = colorScales[panel.key];
    const [lo, hi] = d3.extent(panel.colorStops);
    const nBins = 24;
    const bin = v => Math.max(0, Math.min(nBins - 1, Math.floor((v - lo) / (hi - lo) * nBins)));
    const bins = Array.from({ length: nBins }, () => []);
    list.forEach((d, i) => bins[bin(d[panel.field])].push(i));
    ctx.globalAlpha = selected.value ? 0.18 : 0.45;
    bins.forEach((idx, b) => {
      if (!idx.length) return;
      ctx.fillStyle = color(lo + (b + 0.5) / nBins * (hi - lo));
      ctx.beginPath();
      for (const i of idx) {
        ctx.moveTo(px[i] + 1.6, py[i]);
        ctx.arc(px[i], py[i], 1.6, 0, 2 * Math.PI);
      }
      ctx.fill();
    });
    ctx.globalAlpha = 1;
  }

  function drawFrame(panel, k) {
    const { width, m } = sizes[panel.key];
    const x = xScales[panel.key];
    const focal = info.value.water_year;
    const svg = d3.select(svgs[panel.key])
      .attr("width", width)
      .attr("height", height)
      .attr("viewBox", `0 0 ${width} ${height}`);
    svg.selectAll("*").remove();

    // the focal year's row
    svg.append("rect")
      .attr("class", "ts-focal")
      .attr("x", m.left)
      .attr("width", width - m.left - m.right)
      .attr("y", y(focal + 0.5))
      .attr("height", y(focal - 0.5) - y(focal + 0.5));

    // value axis along the top, with gridlines down the chart and a dashed normal
    const xAxis = svg.append("g")
      .attr("class", "ts-axis")
      .attr("transform", `translate(0,${m.top})`)
      .call(d3.axisTop(x)
        .tickValues(narrow ? panel.ticksNarrow : panel.ticks)
        .tickFormat(panel.tickFormat)
        .tickSize(-(height - m.top - m.bottom))
        .tickPadding(6));
    xAxis.select(".domain").remove();
    xAxis.selectAll(".tick line").attr("class", d => d === panel.normal ? "ts-normal" : "ts-grid");

    // years down the first panel's left side, every five, and the focal year
    if (k === 0) {
      const years = d3.range(Math.ceil(firstYear.value / 5) * 5, focal + 1, 5)
        .filter(yr => Math.abs(yr - focal) > 2)
        .concat(focal);
      const yAxis = svg.append("g")
        .attr("class", "ts-axis")
        .attr("transform", `translate(${m.left},0)`)
        .call(d3.axisLeft(y).tickValues(years).tickFormat(d3.format("d")).tickSize(0).tickPadding(6));
      yAxis.select(".domain").remove();
      yAxis.selectAll(".tick text").classed("ts-focal-label", d => d === focal);
    }

    // the selected site's line takes the color of its values along the value axis
    const gradient = svg.append("defs").append("linearGradient")
      .attr("id", `ts-gradient-${panel.key}`)
      .attr("gradientUnits", "userSpaceOnUse")
      .attr("x1", x(panel.colorStops[0])).attr("x2", x(panel.colorStops[4]))
      .attr("y1", 0).attr("y2", 0);
    gradient.selectAll("stop")
      .data(panel.colorStops)
      .join("stop")
      .attr("offset", (d, i) => i / 4)
      .attr("stop-color", d => colorScales[panel.key](d));

    svg.append("g").attr("class", "ts-selected");
    svg.append("circle").attr("class", "ts-hover").attr("r", 5).attr("display", "none");
  }

  function drawSelected(panel) {
    const x = xScales[panel.key];
    const g = d3.select(svgs[panel.key]).select(".ts-selected");
    g.selectAll("*").remove();
    if (!selected.value) return;
    const offset = jitter(selected.value.site_id);
    // one entry per year from the first to the last, so gaps in the record break the line
    const byYear = new Map(selectedRows.value.map(d => [d.water_year, d]));
    const years = d3.range(d3.min(selectedRows.value, d => d.water_year), d3.max(selectedRows.value, d => d.water_year) + 1);
    const line = d3.line()
      .defined(yr => byYear.get(yr)?.[panel.field] != null)
      .x(yr => x(clampTo(panel, byYear.get(yr)[panel.field])))
      .y(yr => y(yr + offset));
    g.append("path")
      .attr("class", "ts-site-line")
      .attr("stroke", `url(#ts-gradient-${panel.key})`)
      .attr("d", line(years));
    const withValue = selectedRows.value.filter(d => d[panel.field] != null);
    g.selectAll("circle.ts-site-dot")
      .data(withValue)
      .join("circle")
      .attr("class", "ts-site-dot")
      .attr("fill", d => colorScales[panel.key](d[panel.field]))
      .attr("cx", d => x(clampTo(panel, d[panel.field])))
      .attr("cy", d => y(d.water_year + offset))
      .attr("r", 3);
    const row = withValue.find(d => d.water_year === selectedYear.value);
    if (row) {
      g.append("circle")
        .attr("class", "ts-site-year")
        .attr("fill", colorScales[panel.key](row[panel.field]))
        .attr("cx", x(clampTo(panel, row[panel.field])))
        .attr("cy", y(row.water_year + offset))
        .attr("r", 6);
    }
  }

  function drawAll() {
    if (!loaded.value || !box.value) return;
    layout();
    layoutVersion.value++;
    panels.forEach((panel, k) => {
      drawDots(panel);
      drawFrame(panel, k);
      drawSelected(panel);
    });
  }

  // Picking: the nearest dot within reach of the pointer
  function nearest(event, panel) {
    const rect = event.currentTarget.getBoundingClientRect();
    const mx = event.clientX - rect.left;
    const my = event.clientY - rect.top;
    const p = points[panel.key];
    if (!p) return null;
    const i = p.delaunay.find(mx, my);
    if (i < 0 || Math.hypot(p.px[i] - mx, p.py[i] - my) > hitRadiusPx) return null;
    return { i, row: p.list[i], site: sitesById.value.get(p.list[i].site_id), x: p.px[i], y: p.py[i] };
  }
  // A mouse selects the site of the nearest dot as it moves, highlighting all
  // its years, and the selection stays until another site is reached; a tap
  // or click selects too
  function onPointerMove(event, panel) {
    if (event.pointerType !== "mouse") return;
    const hit = nearest(event, panel);
    hover.value = hit ? { ...hit, panel: panel.key } : null;
    if (hit) {
      tipPanel.value = panel.key;
      if (hit.site !== selected.value || hit.row.water_year !== selectedYear.value) {
        selectSite(hit.site, hit.row.water_year, true);
      }
    }
  }
  function onClick(event, panel) {
    const hit = nearest(event, panel);
    if (!hit) return;
    tipPanel.value = panel.key;
    selectSite(hit.site, hit.row.water_year);
  }

  // The popup sits on the selected site's selected year, however it was
  // chosen (pointing, tapping, the arrow keys, or the list), in the panel last
  // used, or the other panel if that one has no value for the year
  const layoutVersion = ref(0);
  const tip = computed(() => {
    layoutVersion.value; // position again after the charts are laid out
    const row = selectedRow.value;
    if (!row || !height) return null;
    const order = tipPanel.value === "melt" ? [panels[1], panels[0]] : panels;
    const panel = order.find(p => row[p.field] != null);
    if (!panel) return null;
    return {
      panel: panel.key,
      row,
      site: selected.value,
      x: xScales[panel.key](clampTo(panel, row[panel.field])),
      y: y(row.water_year + jitter(selected.value.site_id))
    };
  });
  const tipStyle = computed(() => {
    if (!tip.value) return {};
    const width = sizes[tip.value.panel].width;
    const left = tip.value.x > width / 2;
    return {
      top: `${tip.value.y}px`,
      left: left ? "auto" : `${tip.value.x + 12}px`,
      right: left ? `${width - tip.value.x + 12}px` : "auto"
    };
  });
  watch(hover, h => {
    for (const panel of panels) {
      const ring = d3.select(svgs[panel.key]).select(".ts-hover");
      if (h && h.panel === panel.key) ring.attr("cx", h.x).attr("cy", h.y).attr("display", null);
      else ring.attr("display", "none");
    }
  });

  watch([selected, selectedYear], ([site], [oldSite]) => {
    if (!loaded.value) return;
    for (const panel of panels) {
      // the dots only dim or brighten as a selection starts or clears
      if (!site !== !oldSite) drawDots(panel);
      drawSelected(panel);
    }
  });

  // Load the data once the section is near the screen
  let resizeObserver = null;
  let loadObserver = null;
  let lastWidth = 0;
  async function load() {
    const [runInfo, siteRows, annualRows] = await Promise.all([
      d3.csv(publicPath + "data/snotel_run_info.csv", d3.autoType),
      d3.csv(publicPath + "data/snotel_sites.csv", d3.autoType),
      d3.csv(publicPath + "data/snotel_annual.csv", d3.autoType)
    ]);
    info.value = runInfo[0];
    sites.value = siteRows;
    // only years with a change from normal, at sites with a normal
    rows.value = annualRows.filter(d => d.peak_swe_pct != null || d.sm50_diff != null);
    loaded.value = true;
    await nextTick();
    drawAll();
    resizeObserver = new ResizeObserver(() => {
      if (box.value && box.value.clientWidth !== lastWidth) {
        lastWidth = box.value.clientWidth;
        drawAll();
      }
    });
    resizeObserver.observe(box.value);
  }
  onMounted(() => {
    loadObserver = new IntersectionObserver(([entry]) => {
      if (!entry.isIntersecting) return;
      loadObserver.disconnect();
      load();
    }, { rootMargin: "600px 0px" });
    loadObserver.observe(box.value);
  });
  onBeforeUnmount(() => {
    if (loadObserver) loadObserver.disconnect();
    if (resizeObserver) resizeObserver.disconnect();
  });
</script>

<style lang="scss" scoped>
  // Text sizes follow the map's scale: title 2.8rem, site name 2rem, panel
  // titles and details 1.6rem, axis and notes 1.4rem
  .snotel-ts {
    max-width: 1100px;
    min-height: 20rem;
    margin: 0 auto;
    padding: 0 10px;
    text-align: left;
  }
  .snotel-ts__title {
    margin: 0 0 0.75rem;
    padding: 0;
    font-size: 2.8rem;
    line-height: 1.2;
  }
  .ts-controls {
    display: flex;
    align-items: center;
    gap: 0.75rem;
  }
  .ts-picker {
    flex: 0 1 32rem;
    min-width: 0;
    margin: 0;
    padding: 0.2rem 0.25rem;
    font: inherit;
    font-size: 2rem;
    font-weight: 700;
    line-height: 1.3;
    color: var(--color-text);
    background-color: #fff;
    border: 1px solid #bbb;
    border-radius: 4px;
    cursor: pointer;
    option,
    optgroup {
      font-size: 1.6rem;
    }
  }
  .ts-clear {
    flex: none;
    padding: 0.4rem 1rem;
    font: inherit;
    font-size: 1.6rem;
    color: var(--color-text);
    background: transparent;
    border: 1px solid #bbb;
    border-radius: 4px;
    cursor: pointer;
  }
  // hold a line so the charts don't move as sites are selected
  .ts-details {
    min-height: 2.4rem;
    // the prompt wraps to two lines on phones
    @media screen and (max-width: 600px) {
      min-height: 4.8rem;
    }
    margin: 0.5rem 0 0.75rem;
    font-size: 1.6rem;
    line-height: 1.5;
    p {
      margin: 0;
      padding: 0;
    }
  }
  .ts-details__meta,
  .ts-details__prompt {
    color: var(--medium-grey-dark);
  }
  .ts-details__prompt {
    font-style: italic;
  }
  .sr-only {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip: rect(0, 0, 0, 0);
    white-space: nowrap;
    border: 0;
  }
  .ts-panels {
    display: grid;
    // the first panel is wider by its year labels
    grid-template-columns: minmax(0, calc(50% + 15px)) minmax(0, 1fr);
    &:focus-visible {
      outline: 2px solid var(--color-link);
      outline-offset: 4px;
    }
  }
  .ts-panel {
    margin: 0 0 1rem;
  }
  // titles line up over the chart area, past the first panel's year labels
  .ts-panel__title {
    min-height: 7rem;
    margin-bottom: 0.25rem;
    padding: 0 14px;
    font-size: 1.6rem;
    line-height: 1.5;
  }
  .ts-panel:first-child .ts-panel__title {
    padding-left: 44px;
  }
  // less on the left, more on the right, as on the chart
  .ts-key {
    display: flex;
    justify-content: space-between;
    font-size: 1.4rem;
    color: var(--medium-grey-dark);
  }
  .ts-key__swatch {
    display: inline-block;
    width: 1rem;
    height: 1rem;
    border-radius: 50%;
    vertical-align: middle;
  }
  .ts-stack {
    position: relative;
    cursor: pointer;
    // taps select dots; vertical scrolling still works
    touch-action: pan-y;
    canvas,
    svg {
      display: block;
    }
    svg {
      position: absolute;
      top: 0;
      left: 0;
    }
  }
  .ts-tip {
    position: absolute;
    z-index: 2;
    transform: translateY(-50%);
    max-width: 24rem;
    padding: 0.4rem 0.6rem;
    font-size: 1.4rem;
    line-height: 1.35;
    color: var(--color-text);
    background: var(--color-background);
    border: 1px solid #bbb;
    border-radius: 4px;
    box-shadow: 0 1px 4px rgba(0, 0, 0, 0.15);
    pointer-events: none;
  }
  // chart marks, drawn by d3
  .ts-stack :deep(.ts-axis text) {
    font-size: 1.4rem;
    fill: #5c5c5c;
  }
  .ts-stack :deep(.ts-axis .tick line) {
    stroke: #e3e3e3;
  }
  .ts-stack :deep(.ts-axis .tick line.ts-normal) {
    stroke: #5c5c5c;
    stroke-dasharray: 4 3;
  }
  .ts-stack :deep(.ts-focal) {
    fill: #000;
    fill-opacity: 0.05;
  }
  .ts-stack :deep(.ts-focal-label) {
    font-weight: 700;
    fill: var(--color-text);
  }
  .ts-stack :deep(.ts-site-line) {
    fill: none;
    stroke-width: 2.5px;
  }
  .ts-stack :deep(.ts-site-dot) {
    stroke: #fff;
    stroke-width: 1px;
  }
  .ts-stack :deep(.ts-site-year) {
    stroke: var(--color-text);
    stroke-width: 2px;
  }
  .ts-stack :deep(.ts-hover) {
    fill: none;
    stroke: var(--color-text);
    stroke-width: 1.5px;
  }
</style>
