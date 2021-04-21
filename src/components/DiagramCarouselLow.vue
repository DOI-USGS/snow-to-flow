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
              srcset="@/assets/diagrams/Diagram_low-winter.jpg"
              media="(max-width: 992px)"
              type="image/jpg"
            >
            <img 
              id="diagram-low-winter"
              v-img="{
                thumbnails: true,
                sourceButton: true,
                group: 'diagram-low', 
                title: 'A Low Snow Winter: If winter temperatures remain above freezing during precipitation events, or if there is not much precipitation at all, SWE accumulation in a given location can be quite low compared to other years. '
              }"
              class="sliderImage"
              src="@/assets/diagrams/Diagram_low-winter.jpg"
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
              srcset="@/assets/diagrams/Diagram_low-spring.jpg"
              media="(max-width: 992px)"
              type="image/jpg"
            >
            <img 
              id="diagram-low-early-spring"
              v-img="{
                thumbnails: true,
                sourceButton: true,
                group: 'diagram-low', 
                title: 'A Low Snow Spring: Warming winters can mean that there is not much snow accumulation. If those years also face an early, warm spring, the snowmelt season releases meltwater slowly and gradually, and there may not be a spring streamflow peak. Melting in this way means that the slow trickle of melt can be absorbed by the soil, which slows down meltwater on its journey over and through the soil towards streams.'
              }"
              class="sliderImage"
              src="@/assets/diagrams/Diagram_low-spring.jpg"
              alt="Diagram of a mountain watershed covered in snow in spring"
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
              srcset="@/assets/diagrams/Diagram_low-summer.jpg"
              media="(max-width: 992px)"
              type="image/png"
            >
            <img 
              id="diagram-normal-late-summer"
              v-img="{
                thumbnails: true,
                sourceButton: true,
                group: 'diagram-low', 
                title: 'A Low Snow Summer: Snowpack melts earlier and streamflow is diminished compared to high-snow conditions. Summer streamflow will be low, and downstream reservoirs may only receive a fraction of their usual water budget.'
              }"
              class="sliderImage"
              src="@/assets/diagrams/Diagram_low-summer.jpg"
              alt="Diagram of a mountain watershed covered in snow in summer"
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