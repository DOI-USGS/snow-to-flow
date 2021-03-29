<template>
  <!---VizSection-->
  <VizSection
    id="intro"
    :figures="false"
    :fig-caption="false"
  >
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>Most of our water supply in the Western U.S. comes from snowmelt.</h2>
    </template>
    <template v-slot:aboveExplanation>
      <p>For most of the Western U.S., water from melting snow makes up the <a href="https://agupubs.onlinelibrary.wiley.com/doi/full/10.1002/2017GL073551" target="_blank">majority</a> of the water supply available for the entire year.</p>
      <p>In the western U.S., a large fraction of the annual water supply is produced in a comparatively small portion of the region.  Mountains, where snow accumulates all winter and stays frozen late into the spring, function as frozen water towers which store water in the form of snow.  Normally, meltwater from the thick mountain snowpack generally produce huge streamflows in the spring, generally more flow per unit area than lower lying terrain. Seasonal snow and melt dynamics are critical components of the surface energy balance and water cycle in mountainous areas, for the environments and for the humans that rely on the water. <a href="https://onlinelibrary.wiley.com/doi/full/10.1002/hyp.13735#hyp13735-bib-0018" target="_blank">Cite</a>, <a href="https://onlinelibrary.wiley.com/doi/full/10.1002/hyp.13735#hyp13735-bib-0052" target="_blank">cite</a>, <a href="https://onlinelibrary.wiley.com/doi/full/10.1002/hyp.13735#hyp13735-bib-0101" target="_blank">cite.</a></p>
    </template>
    <!-- EXPLANATION -->
    <template v-slot:belowExplanation>
      <p>With warmer, shorter winters and less snow accumulation, how will water availability change?</p>
      <p>Changes to snowmelt duration, timing and magnitude in these areas may substantially alter other water cycle components downstream. Snowpack magnitudes have <a href="https://onlinelibrary.wiley.com/doi/full/10.1002/hyp.13735#hyp13735-bib-0020" target="_blank">declined</a> across the western U.S. in recent years. Both observations and models show snowpack magnitude decline may lead to <a href="https://onlinelibrary.wiley.com/doi/full/10.1002/hyp.13735#hyp13735-bib-0020" target="_blank">reduced streamflow</a>.  Research from the U.S. Geological Survey suggests that approximately <a href="https://onlinelibrary.wiley.com/doi/full/10.1002/hyp.13735#hyp13735-bib-0020" target="_blank">2 billion</a> people are expected to experience diminished water supplies due to seasonal snowpack decline this century. </p>
      <p>Seasonal snowpacks <a href="https://onlinelibrary.wiley.com/doi/full/10.1002/hyp.13735#hyp13735-bib-0020" target="_blank">vary widely</a> from place to place, and from year to year. This variability can have a <a href="https://onlinelibrary.wiley.com/doi/full/10.1002/hyp.13735#hyp13735-bib-0020" target="_blank">strong influence on timing and magnitude</a> of snowmelt, <a href="https://onlinelibrary.wiley.com/doi/full/10.1002/hyp.13735#hyp13735-bib-0020" target="_blank">delivery</a> to a watershed, and its <a href="https://onlinelibrary.wiley.com/doi/full/10.1002/hyp.13735#hyp13735-bib-0020" target="_blank">streamflow response</a>.</p>
      <p>Now, with this winter’s snow accumulation nearing its end and moving into the spring snowmelt season, the Western U.S. is about to enter an important phase in their water cycle.  Peak snowpack storage conditions and the dynamics of spring snowmelt can tell us a lot about water availability in the summer and fall.</p>
    </template>
  </VizSection>
</template>
<script>
import VizSection from '@/components/VizSection';
export default {
    name: "Intro",
    components:{
        VizSection
    }
}
</script>
<style lang="scss" scoped>
</style>