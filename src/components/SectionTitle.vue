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
        <picture>
          <!-- 1x on phones, 2x otherwise; WebP where supported, with JPEG fallbacks.
               Media size suggestions https://developer.mozilla.org/en-US/docs/Learn/HTML/Multimedia_and_embedding/Responsive_images -->
          <source
            type="image/webp"
            media="(max-width: 799px)"
            :srcset="getImageUrl(image, '1', 'webp')"
          >
          <source
            type="image/webp"
            media="(min-width: 800px)"
            :srcset="getImageUrl(image, '2', 'webp')"
          >
          <source
            type="image/jpeg"
            media="(max-width: 799px)"
            :srcset="getImageUrl(image, '1', 'jpg')"
          >
          <img
            :src="getImageUrl(image, '2', 'jpg')"
            :alt="alt"
            loading="lazy"
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
    alt: {
        type: String,
        default: ''
    },
    height:{
        type: Number,
        default: 100
    },
    // .55 is the lightest overlay that keeps the white title at >= 4.5:1
    // contrast over 99% of the pixels behind it, for every chapter image
    overlayOpacity:{
        type: Number,
        default: .55
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
  .chapterContainer{
    margin-bottom: 3rem;
  }
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
    font-size: clamp(3em, 6vw, 5em); // kept smaller than the h1 at the top of the splash
    font-weight: 800;
    color: white;
    padding: 0 20px;
    text-align: center;
    max-width: 960px;
  }
</style>