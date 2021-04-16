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
          <!--Media size suggestions https://developer.mozilla.org/en-US/docs/Learn/HTML/Multimedia_and_embedding/Responsive_images-->
          <source
            media="(max-width: 799px)"
            :data-srcset="require(`@/assets/titleImages/1x/${image}-1x.jpg`)"
          >
          <source
            media="(min-width: 800px)"
            :data-srcset="require(`@/assets/titleImages/2x/${image}-2x.jpg`)"
          >
          <img 
            :srcset="require(`@/assets/titleImages/lazy.jpg`)"
            :data-srcset="require(`@/assets/titleImages/2x/${image}-2x.jpg`)"
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
<script>
export default {
    name: "TestImage",
    props:{
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
    },
    computed:{
        chaptersVars(){
            return{
                "--height": `${this.height}vh`,
            }
        },
        overlayVars(){
            return{
                "--overlay-opacity": `${this.overlayOpacity}`
            }
        }
    }
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
.lazy{
  filter: blur(50px);
}
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
    font-family: $familyMain;
    font-size:clamp(3em, 20vw, 2em); // changed to not be bigger than the h1 at the top of the splash
    font-weight: 800;
    color: white;
    padding: 0 20px;
    text-align: center;
    max-width: 960px;
}
</style>