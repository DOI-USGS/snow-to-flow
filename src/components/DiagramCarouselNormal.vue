<template>
  <div class="carouselContainer">
    <carousel
      id="diagrams-normal"
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
              srcset="@/assets/diagrams/Diagrams_normal-winter.jpg"
              media="(max-width: 992px)"
              type="image/jpg"
            >
            <img 
              id="diagram-normal-winter"
              v-img="{group: 'diagram-normal', title: 'A Normal Winter: Soil saturation sets the stage for the coming snow season - whether it was wet or dry the year before determines how saturated it is.  Around October, snow begins to fall and SWE begins to accumulate. Especially in high elevations, snowpacks can be several feet thick and store several inches worth of water.'}"
              class="sliderImage"
              src="@/assets/diagrams/Diagram_normal-winter.jpg"
              alt="Diagram of a mountain watershed covered in snow in winter"
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
              srcset="@/assets/diagrams/Diagram_normal-spring.jpg"
              media="(max-width: 992px)"
              type="image/jpg"
            >
            <img 
              id="diagram-normal-early-spring"
              v-img="{group: 'diagram-normal', title: 'A Normal Spring:  At some point, snowpack SWE reaches its peak and then tips downward as the snow begins to melt.  The date of peak SWE determines the melt timing, and the melt duration measures how long it takes for all the snow to melt from that peak.'}"
              class="sliderImage"
              src="@/assets/diagrams/Diagram_normal-spring.jpg"
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
              srcset="@/assets/diagrams/Diagram_normal-summer.jpg"
              media="(max-width: 992px)"
              type="image/png"
            >
            <img 
              id="diagram-normal-late-spring"
              v-img="{group: 'diagram-normal', title: 'A Normal Summer: During the melt season, soils soak up some of the meltwater, but not all of it. The rest moves quickly over and through the soil, filling streams with a surge of water that can be captured in reservoirs downstream.  For many places in the Western U.S., this meltwater makes up the majority of their water budget for the year.'}"
              class="sliderImage"
              src="@/assets/diagrams/Diagram_normal-summer.jpg"
              alt="Diagram of a mountain watershed covered in snow in late spring"
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
        name: 'DiagramCarouselNormal',
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