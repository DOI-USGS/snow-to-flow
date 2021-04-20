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
              v-img="{
                thumbnails: true,
                group: 'group', 
                title: 'USGS Research Hydrologist Graham Sexstone completes snowpit measurement at Buffalo Pass, CO. Photographer: Colin Penn.'
              }"
              class="sliderImage"
              src="@/assets/methods/person1.jpg"
              alt="USGS Research Hydrologist Graham Sexstone completes snowpit measurement at Buffalo Pass, CO. Photographer: Colin Penn."
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
              v-img="{
                group: 'group',
                thumbnails: true
              }"
              class="sliderImage"
              src="@/assets/methods/drone1.jpg"
              alt="USGS scientists flying UAS near Winter Park, CO under a DOI readiness waiver. Lidar and photogrammetry were used to map snow depth. Photographer: Mark Bauer "
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
              v-img="{
                group: 'group',
                thumbnails: true
              }"
              class="sliderImage"
              src="@/assets/methods/person2.jpg"
              alt="USGS Research Hydrologist Graham Sexstone measures the snow depth at Molas Pass, CO. Photographer: Joe Mills"
              loading="lazy"
            >
          </picture>
        </div>
      </slide>
      <slide class="slide">
        <div class="slider-image-container">
          <picture>
            <source
              srcset="@/assets/methods/station4.jpg"
              media="(max-width: 992px)"
              type="image/jpg"
            >
            <img 
              id="field4"
              v-img="{
                group: 'group',
                thumbnails: true
              }"
              class="sliderImage"
              src="@/assets/methods/station4.jpg"
              alt="USGS NGWOS snow test bed site (Ranch Creek Meadow) in Winter Park, Colorado shown recording snow water equivalent, snow depth, soil moisture, and other meteorological variables. Photographer: Graham Sexstone"
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
              v-img="{
                group: 'group',
                thumbnails: true
              }"
              class="sliderImage"
              src="@/assets/methods/station2.jpg"
              alt="NRCS SNOTEL site (Lake Irene, CO) shown recording snow water equivalent, snow depth, and other meteorological variables. Photographer: Graham Sexstone"
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
              v-img="{
                group: 'group',
                thumbnails: true
              }"
              class="sliderImage"
              src="@/assets/methods/person4.jpg"
              alt="USGS scientists Graham Sexstone and Colin Penn collecting a snow sample to analyze for snow chemistry in Rocky Mountain National Park, CO. Photographer: Garrett Akie."
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
              v-img="{
                group: 'group',
                thumbnails: true
              }"
              class="sliderImage"
              src="@/assets/methods/station3.jpg"
              alt="USGS snow monitoring site (Loch Vale – Andrews Meadow) in Rocky Mountain National Park, Colorado shown recording snow sublimation and other meteorological variables. Photographer: Graham Sexstone"
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
              id="field9"
              v-img="{
                group: 'group',
                thumbnails: true
              }"
              class="sliderImage"
              src="@/assets/methods/person3.jpg"
              alt="USGS Hydrologist Colin Penn measures the snow density and snow temperature of the snowpack at Noisy Basin, MT. Photographer: Evan Gohring"
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