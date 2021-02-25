<template>
  <div id="visualization">
    <Chapter
      id="chapter1"
      class="block"
      image="chapter1"
      :overlay-opacity=".5"
    >
      <template v-slot:chapterTitle>
        The timing and magnitude of snowmelt is changing across the western U.S.
      </template>
    </Chapter>
    <SNTLMap
      id="section1"
      class="block"
    />
    <Chapter
      id="chapter2"
      class="block"
      :height="40"
      image="chapter2"
    >
      <template v-slot:chapterTitle>
        The Second Chapter Title
      </template>
    </Chapter>
    <Diagrams
      id="section2"
      class="block"
    />
    <Chapter
      id="chapter3"
      class="block"
      :height="70"
      image="chapter3"
    >
      <template v-slot:chapterTitle>
        The Third Chapter Title
      </template>
    </Chapter>
    <SWEanim
      id="section3"
      class="block"
    />
    <Chapter
      id="chapter4"
      class="block"
      image="chapter4"
    >
      <template v-slot:chapterTitle>
        Elevation
      </template>
    </Chapter>
    <Elevation
      id="section4"
      class="block"
    />
    <References />
  </div>
</template>

<script>
import Chapter from "@/components/SectionTitle";
export default {
    name: 'Visualization',
    components: {
      // Splash: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "section"*/ "./../components/Splash"),
      SNTLMap: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "section"*/ "./../components/SNTLmap"),
      Diagrams: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "section"*/ "./../components/Diagrams"),
      SWEanim: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "section"*/ "./../components/SWEanim"),
      Elevation: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "section"*/ "./../components/Elevation"),
      References: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "References"*/ "./../components/References"),
      Chapter
    }
} 
</script>

<style lang="scss">
SNTLmap {
  z-index: 1;
}
</style>
