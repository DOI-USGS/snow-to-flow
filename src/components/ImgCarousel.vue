<template>
  <div class="maxWidth carouselContainer">
    <carousel
      class="image-slider"
      :autoplay="true"
      :autoplay-hover-pause="true"
      :per-page="4"
    >
      <slide class="slide">
        <div class="slider-image-container">
          <picture>
            <source
              srcset="@/assets/methods/person1.jpg"
              media="(max-width: 992px)"
              type="image/png"
            >
            <img 
              id="field1"
              v-img="{group: 'group', title: 'Test title'}"
              class="sliderImage"
              src="@/assets/methods/person1.jpg"
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
              srcset="@/assets/methods/drone1.jpg"
              media="(max-width: 992px)"
              type="image/jpg"
            >
            <img 
              id="field2"
              v-img:group
              class="sliderImage"
              src="@/assets/methods/drone1.jpg"
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
              srcset="@/assets/methods/person2.jpg"
              media="(max-width: 992px)"
              type="image/jpg"
            >
            <img 
              id="field3"
              v-img:group
              class="sliderImage"
              src="@/assets/methods/person2.jpg"
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
              srcset="@/assets/methods/station1.jpg"
              media="(max-width: 992px)"
              type="image/jpg"
            >
            <img 
              id="field4"
              v-img:group
              class="sliderImage"
              src="@/assets/methods/station1.jpg"
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
              srcset="@/assets/methods/person3.jpg"
              media="(max-width: 992px)"
              type="image/jpg"
            >
            <img 
              id="field5"
              v-img:group
              class="sliderImage"
              src="@/assets/methods/person3.jpg"
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
              srcset="@/assets/methods/station2.jpg"
              media="(max-width: 992px)"
              type="image/jpg"
            >
            <img 
              id="field6"
              v-img:group
              class="sliderImage"
              src="@/assets/methods/station2.jpg"
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
              srcset="@/assets/methods/person4.jpg"
              media="(max-width: 992px)"
              type="image/jpg"
            >
            <img 
              id="field7"
              v-img:group
              class="sliderImage"
              src="@/assets/methods/person4.jpg"
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
              srcset="@/assets/methods/station3.jpg"
              media="(max-width: 992px)"
              type="image/jpg"
            >
            <img 
              id="field8"
              v-img:group
              class="sliderImage"
              src="@/assets/methods/station3.jpg"
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
              srcset="@/assets/methods/person5.jpg"
              media="(max-width: 992px)"
              type="image/jpg"
            >
            <img 
              id="field9"
              v-img:group
              class="sliderImage"
              src="@/assets/methods/person5.jpg"
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
    padding: 10px;
    display: block;
    height: 400px;
    width: auto;
    object-fit: contain;
    img {
      height: 400px; 
      width: auto;
    }
  }
</style>