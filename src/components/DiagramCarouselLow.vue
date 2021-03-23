<template>
  <div class="carouselContainer">
    <carousel
      id="diagrams-low"
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
              id="diagram-low-winter"
              v-img:diagram-low
              src="@/assets/diagrams/Diagrams_normal-winter.jpg"
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
              srcset="@/assets/diagrams/Diagrams_normal-early-spring.jpg"
              media="(max-width: 992px)"
              type="image/jpg"
            >
            <img 
              id="diagram-low-early-spring"
              v-img:diagram-low
              src="@/assets/diagrams/Diagrams_normal-early-spring.jpg"
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
              srcset="@/assets/diagrams/Diagrams_normal-late-spring.jpg"
              media="(max-width: 992px)"
              type="image/png"
            >
            <img 
              id="diagram-normal-late-spring"
              v-img:diagram-low
              src="@/assets/diagrams/Diagrams_normal-late-spring.jpg"
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
    height: 15vh;
    width: auto;
    object-fit: contain;
    img {
      height: 100%; 
      width: auto;
    }
  }
</style>