<template>
  <div id="visualization">
    <Chapter
      id="chapter1"
      class="block"
      image="image2.png"
    >
      <template v-slot:chapterTitle>
        The First Chapter Title
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
    >
      <template v-slot:chapterTitle>
        The Second Chapter Title
      </template>
    </Chapter>
    <SWE />
    <DiagramsGood 
      id="diagrams-good"
      class="block" 
    />
    <DiagramsBad 
      id="diagrams-bad"
      class="block"
    />
    <Chapter
      id="chapter3"
      class="block"
      image="image3.png"
      :height="70"
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
      image="image4.png"
    >
      <template v-slot:chapterTitle>
        The Fourth Chapter Title
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
      SWE: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "SWE"*/ "./../components/SWE"),
      DiagramsGood: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "diagramsgood"*/ "./../components/DiagramsGood"),
      DiagramsBad: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "diagramsbad"*/ "./../components/DiagramsBad"),
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
