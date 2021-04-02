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
              v-img:diagram-high
              class="sliderImage"
              src="@/assets/diagrams/Diagram_high-winter.jpg"
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
              srcset="@/assets/diagrams/Diagram_high-spring.jpg"
              media="(max-width: 992px)"
              type="image/jpg"
            >
            <img 
              id="diagram-high-early-spring"
              v-img:diagram-high
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
              id="diagram-high-late-spring"
              v-img:diagram-high
              class="sliderImage"
              src="@/assets/diagrams/Diagram_high-summer.jpg"
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
    background: rgb(0,0,0);
    background: rgba(0,0,0,.5);
    position: absolute;
    width: 100%;
    bottom: 0;
    z-index: 9000;
    text-align: center;
    padding: 30px 10px;
    color: #fff;
    .caption{
      margin: 0 auto;
      max-width: 700px;
    }
  }
</style>