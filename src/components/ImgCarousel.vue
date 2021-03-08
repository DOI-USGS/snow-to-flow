<template>
  <div>
    <carousel
      id="image-slider"
      :autoplay="true"
      :autoplay-hover-pause="true"
      :per-page="3"
    >
      <slide class="slide">
        <div class="slider-image-container">
          <picture>
            <source
              srcset="@/assets/images/snow-img1.png"
              media="(max-width: 992px)"
              type="image/png"
            >
            <img 
              id="field1"
              v-img:group
              src="@/assets/images/snow-img1.png"
              alt="Collecting snow depth data in the field"
              loading="lazy"
            >
          </picture>
        </div>
      </slide>
      <slide class="slide">
        <div class="slider-image-container">
          <picture>
            <source
              srcset="@/assets/images/snow-img2.png"
              media="(max-width: 992px)"
              type="image/png"
            >
            <img 
              id="field2"
              v-img:group
              src="@/assets/images/snow-img2.png"
              alt="Collecting snow depth data in the field"
              loading="lazy"
            >
          </picture>
        </div>
      </slide>
      <slide class="slide">
        <div class="slider-image-container">
          <picture>
            <source
              srcset="@/assets/images/snow-img3.png"
              media="(max-width: 992px)"
              type="image/png"
            >
            <img 
              id="field3"
              v-img:group
              src="@/assets/images/snow-img3.png"
              alt="Collecting snow depth data in the field"
              loading="lazy"
            >
          </picture>
        </div>
      </slide>
      <slide class="slide">
        <div class="slider-image-container">
          <picture>
            <source
              srcset="@/assets/images/snow-img1.png"
              media="(max-width: 992px)"
              type="image/png"
            >
            <img 
              id="field4"
              v-img:group
              src="@/assets/images/snow-img1.png"
              alt="Collecting snow depth data in the field"
              loading="lazy"
            >
          </picture>
        </div>
      </slide>
    </carousel>
  </div>
</template>

<script>
    import { Carousel, Slide } from 'vue-carousel';

    export default {
        name: 'ImgCarousel',
        components:{
            Carousel,
            Slide
        }
    }
</script>

<style scoped lang="scss">
  #image-slider {
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
    padding: 10px;
    display: block;
    margin: auto;
    max-width: 400px;
    img {
      width: 100%;
    }
  }
</style>