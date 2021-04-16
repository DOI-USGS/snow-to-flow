<template>
  <div
    class="carouselContainer"
  >
    <carousel
      id="diagrams-high"
      class="image-slider"
      :autoplay="true"
      :autoplay-hover-pause="true"
      :per-page="3"
    >
      <!-- Slide One -->
      <slide class="slide">
        <div class="slider-image-container">
          <picture>
            <source
              srcset="@/assets/diagrams/Diagram_high-winter.jpg"
              media="(max-width: 992px)"
              type="image/jpg"
            >
            <img 
              id="diagram-high-winter"
              v-img="{
                thumbnails: true,
                sourceButton: true,
                group: 'diagram-high', 
                title: 'A High Snow Winter: If soils are not dried out by previous years of drought and lots of snow begins to accumulate, the stage is set for a year with lots of meltwater availability.'
              }"
              class="sliderImage"
              src="@/assets/diagrams/Diagram_high-winter.jpg"
              alt="A diagram of a watershed with snowy mountain tops."
              loading="lazy"
            >
          </picture>
        </div>
      </slide>

      <!-- Slide Two -->
      <slide class="slide">
        <div class="slider-image-container">
          <picture>
            <source
              srcset="@/assets/diagrams/Diagram_high-spring.jpg"
              media="(max-width: 992px)"
              type="image/jpg"
            >
            <img 
              id="diagram-high-spring"
              v-img="{
                thumbnails: true,
                sourceButton: true,
                group: 'diagram-high', 
                title: 'A High Snow Spring: In a high snow year, SWE continues to accumulate late into the spring as temperatures stay cold.  Usually, high SWE goes hand-in-hand with a late melt date, since both are a result of temperatures staying cold late into the spring. The later the peak snowpack day occurs, the more likely it is that the snow will melt all at once in a rapid surge.'
              }"
              class="sliderImage"
              src="@/assets/diagrams/Diagram_high-spring.jpg"
              alt="Diagram of a mountain watershed covered in snow in early spring"
              loading="lazy"
            >
          </picture>
        </div>
      </slide>
      <!-- Slide Three -->
      <slide class="slide">
        <div class="slider-image-container">
          <picture>
            <source
              srcset="@/assets/diagrams/Diagram_high-summer.jpg"
              media="(max-width: 992px)"
              type="image/png"
            >
            <img 
              id="diagram-high-summer"
              v-img="{
                thumbnails: true,
                sourceButton: true,
                group: 'diagram-high', 
                title: 'A High Snow Summer: A late, large melt combined with good soil saturation means that the resulting surge of stream flow can be enormous. Even dry soils might not be able to absorb all the meltwater, and there can be flooding. But much of the water can be captured in reservoirs to provide lots of water for the rest of the year.'
              }"
              class="sliderImage"
              src="@/assets/diagrams/Diagram_high-summer.jpg"
              alt="Diagram of a mountain watershed covered in snow in the summer."
              loading="lazy"
            >
          </picture>
        </div>
      </slide>
      <!-- Add more slides here if necessary -->
    </carousel>
  </div>
</template>

<script>
    import { Carousel, Slide } from 'vue-carousel';

    export default {
        name: 'DiagramCarouselHigh',
        components:{
            Carousel,
            Slide
        }
    }
</script>

<style scoped lang="scss">
  .image-slider {
    *:focus{
      outline: none;
    }
  }
  .slide {
    margin: 0;
    padding: 0;
    select:focus{
      outline: none;
    }
  }
  .slider-image-container {
    display: block;
    height: auto;
    width: 30vw;
    object-fit: contain;
    margin: auto;
    img {
      height: auto; 
      width: 100%;
      margin: auto;
    }
  }
</style>
<style lang="scss">
// This is the globally scoped styling for the captions of images in the lightbox
.fullscreen-v-img{
  position: relative;
}
  #captionArea{
    background: rgba(255,255,255,1);
    position: absolute;
    width: 100%;
    bottom: 0px; // changed to raise it above the thumnail slider
    z-index: 9000;
    text-align: left;
    padding: 20px 10px;
    color: black;
    font-size: .9em;
    @media screen and (max-width: 600px) {
      padding: 20px 10px;
      font-size: .8em;
    }
    .caption{
      margin: 0 auto 70px auto;
      max-width: 700px;
      line-height: 1.5em;
    }
  }
</style>