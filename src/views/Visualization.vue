<template>
  <div id="visualization">
    <div
      class="parallax1 parallax fullImage"
    />
    <SNTLmap class="parallax" />
    <div
      class="parallax2 parallax midImage"
    />
    <Diagrams class="parallax" />
    <div
      class="parallax3 parallax midImage"
    />
    <SWEanim class="parallax" />
    <div
      class="parallax4 parallax fullImage"
    />
  </div>
</template>

<script>
    export default {
        name: 'Visualization',
        components: {
            Diagrams: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "diagrams"*/ "./../components/Diagrams"),
            SNTLmap: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "SNTLmap"*/ "./../components/SNTLmap"),
            SWEanim: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "SWEanim"*/ "./../components/SWEanim")
        }
    }
</script>

<style lang="scss">
  .parallax1{
    background: url(~@/assets/titleImages/image1.png);
  }
  .parallax2{
    background: url(~@/assets/titleImages/image2.png);
  }
  .parallax3{
    background: url(~@/assets/titleImages/image3.png);
  }
  .parallax4{
    background: url(~@/assets/titleImages/image4.png);
  }
  .parallax1,.parallax2, .parallax3, .parallax4{
    position: relative;
    background-position: center;
    background-size: cover;
    background-repeat: no-repeat;
    background-attachment:fixed;
  }
  .fullImage{
    min-height: 100vh;
  }
  .midImage{
    min-height: 60vh;
  }
  /* Portrait and Landscape */
@media only screen 
  and (min-device-width: 375px) 
  and (max-device-width: 667px) 
  and (-webkit-min-device-pixel-ratio: 2) { 
    .parallax1,.parallax2, .parallax3, .parallax4{
      background-attachment:scroll;
    }
}
</style>
