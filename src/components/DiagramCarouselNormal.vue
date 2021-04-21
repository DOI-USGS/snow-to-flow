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
              srcset="@/assets/diagrams/Diagram_typical-winter.jpg"
              media="(max-width: 992px)"
              type="image/jpg"
            >
            <img 
              id="diagram-normal-winter"
              v-img="{
                thumbnails: true,
                sourceButton: true,
                group: 'diagram-normal', 
                title: 'A Typical Winter: Soil saturation sets the stage for the coming snow season - whether the prior year was wet or dry determines soil saturation for the current year. Around October, snow begins to fall and SWE begins to accumulate. Especially at high elevations, the snowpack can be several feet thick and store several inches of water (SWE).'
              }"
              class="sliderImage"
              src="@/assets/diagrams/Diagram_typical-winter.jpg"
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
              srcset="@/assets/diagrams/Diagram_typical-spring.jpg"
              media="(max-width: 992px)"
              type="image/jpg"
            >
            <img 
              id="diagram-normal-spring"
              v-img="{
                thumbnails: true,
                sourceButton: true,
                group: 'diagram-normal', 
                title: 'A Typical Spring: At some point, snowpack SWE reaches its peak and then begins to decline as the snow begins to melt. The date of peak SWE marks the beginning of the melt timing, and the melt duration is the time required for one-half of the peak SWE to melt (SM50). '
              }"
              class="sliderImage"
              src="@/assets/diagrams/Diagram_typical-spring.jpg"
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
              srcset="@/assets/diagrams/Diagram_typical-summer.jpg"
              media="(max-width: 992px)"
              type="image/png"
            >
            <img 
              id="diagram-normal-summer"
              v-img="{
                thumbnails: true,
                sourceButton: true,
                group: 'diagram-normal', 
                title: 'A Typical Summer: During the melt season, infiltration of meltwater increases soil saturation and runoff to streams. Streamflow often peaks in the early summer in response to spring snowmelt, filling streams with a surge of water that can be captured by downstream diversions or in reservoirs. For many places in the Western U.S., spring snowmelt composes the majority of the annual water budget.'
              }"
              class="sliderImage"
              src="@/assets/diagrams/Diagram_typical-summer.jpg"
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
