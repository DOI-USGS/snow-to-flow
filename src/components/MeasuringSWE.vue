<template>
  <!---VizSection-->
  <VizSection
    id="measuring-swe"
    :take-away="false"
  >
    <template #aboveExplanation>
      <p>Using high-quality manual and station observations of snowpack and streamflow, USGS scientists are conducting research on trends in snowfall, snow cover, snow versus rain<sup class="citation"><a href="#ref-10">10</a></sup>, snow water equivalent, snowmelt runoff<sup class="citation"><a href="#ref-11">11</a></sup>, snowmelt timing<sup class="citation"><a href="#ref-12">12</a></sup> and snow chemistry in the U.S. USGS scientists are also evaluating the influence of changing climate on hydrological processes and runoff in snowmelt dominated basins<sup class="citation"><a href="#ref-13">13</a></sup>.</p>
    </template>
    <!-- FIGURES -->
    <template #figures>
      <div class="group single maxWidth">
        <figure id="swe-photos-container">
          <CarouselGallery
            :items="methodsPhotos"
            layout="centered"
          />
        </figure>
      </div>
    </template>
    <!-- FIGURE CAPTION -->
    <template #figureCaption>
      <p>
        Click on the images to learn more about how USGS snow hydrologists measure SWE in the field. 
      </p>
    </template>
    <!-- EXPLANATION -->
    <template #belowExplanation>
      <p>
        The <a
          href="https://www.nrcs.usda.gov/"
          target="_blank"
        >Natural Resources Conservation Service (NRCS)</a> operates a snow monitoring program that includes over 800 automated <a
          href="https://www.nrcs.usda.gov/programs-initiatives/sswsf-snow-survey-and-water-supply-forecasting-program"
          target="_blank"
        >Snow Telemetry (SNOTEL)</a> data collection sites that monitor SWE, snow depth, precipitation, temperature, and other related meteorological variables.
      </p>
      <p>
        Streamflow measurements from the <a
          href="https://labs.waterdata.usgs.gov/visualizations/gages-through-the-ages/index.html#/"
          target="_blank"
        >USGS streamgaging network</a> are used to further our understanding of snowmelt processes. Some of the oldest USGS streamgages in the Western U.S. (100-125 year records) derive their streamflow from seasonal snowmelt, contributing to a long record of data to analyze seasonal and historical runoff patterns.
      </p>
    </template>
  </VizSection>
</template>

<script setup>
  import VizSection from '@/components/VizSection.vue';
  import CarouselGallery from '@/components/CarouselGallery.vue';
  import methodsPhotos from '@/assets/text/methodsPhotos.js';
</script>

<style lang="scss" scoped>
  #swe-photos-container {
    width: 100%;
    height: auto;
  }
</style>
