<template>
  <div class="chapterContainer">
    <div
      class="chapter"
      :height="height"
      :style="chaptersVars"
    >
      <div class="chapterTitle">
        <slot name="chapterTitle">
          Chapter Title
        </slot>
      </div>
      <div
        class="bg"
        :style="overlayVars"
      >
        <picture class="lazy">
          <!-- Media size suggestions https://developer.mozilla.org/en-US/docs/Learn/HTML/Multimedia_and_embedding/Responsive_images -->
          <source
            type="image/webp"
            media="(max-width: 799px)"
            :srcset="getImageUrl(image, '1', 'webp')"
            :data-srcset="getImageUrl(image, '1', 'webp')"
          >
          <source
            type="image/webp"
            media="(min-width: 800px)"
            :data-srcset="getImageUrl(image, '2', 'webp')"
          >
          <!--BACKUP IF BROWSER DOESN'T ACCEPT WEBP (TESTED AND WORKING ON SAFARI)-->
          <source
            type="image/jpg"
            media="(max-width: 799px)"
            :data-srcset="getImageUrl(image, '1', 'jpg')"
          >
          <source
            type="image/jpg"
            media="(min-width: 800px)"
            :data-srcset="getImageUrl(image, '2', 'jpg')"
          >
          <img 
            :srcset="getImageUrl(image, '2', 'jpg')"
          >
        </picture>
        <div
          v-if="overlay"
          class="overlay"
        />
      </div>
    </div>
  </div>
</template>

<script setup>
  import {computed} from 'vue'

  const props = defineProps({
    overlay: {
        type: Boolean,
        default: true
    },
    image: {
        type: String,
        default: `chapter1`
    },
    height:{
        type: Number,
        default: 100
    },
    overlayOpacity:{
        type: Number,
        default: .7
    }
  })
  
  const chaptersVars = computed(() => {
    return { "--height": `${props.height}vh` }
  })

  const overlayVars = computed(() => {
    return { "--overlay-opacity": `${props.overlayOpacity}` }
  })

  function getImageUrl(image, zoom_level, suffix) {
    return new URL(`../assets/titleImages/${zoom_level}x/${image}-${zoom_level}x.${suffix}`, import.meta.url).href
  }
</script>

<style lang="scss" scoped>
  $familyMain: 'Public sans', sans-serif;
  $familySerif:  'Noto Serif', serif;
  $darkGrey: #212122;

  .chapter{
    position: relative;
    height: var(--height);
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
  }
  /* force the source element to be full height*/
  picture, source{
    position: absolute;
    top: 0;
    width: 100%;
    height: 100%;
  }
  picture{
    transition: filter 0.5s;
  }
  // .lazy{
  //   filter: blur(50px);
  // }
  .overlay{
    position: absolute;
    width: 100%;
    height: 100%;
    background: black;
    opacity: var(--overlay-opacity);
    top:0;
    left: 0;
  }
  .bg{
    position: absolute;
    top: 0;
    left: 0;
    width:100%;
    height:100%;
    overflow: hidden;
    img{
      object-fit: cover;
      width: 100%;
      height: 100%;
    }
  }
  .chapterTitle{
    position: relative;
    z-index: 2;
    font-family: sans-serif; // fallback for old browsers
    font-family: var(--title-font);
    font-size:clamp(3em, 20vw, 2em); // changed to not be bigger than the h1 at the top of the splash
    font-weight: 800;
    color: white;
    padding: 0 20px;
    text-align: center;
    max-width: 960px;
  }
</style>