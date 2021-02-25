<template>
  <div
    class="chapter"
    :height="height"
    :style="cssVars"
  >
    <div class="chapterTitle">
      <slot name="chapterTitle">
        Chapter Title
      </slot>
    </div>
    <div
      class="bg"
      :image="image"
      :style="cssVars"
    >
      <div
        v-if="overlay"
        class="overlay"
      />
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
            default: `image1.png`
        },
        height:{
            type: Number,
            default: 100
        }
    },
    computed:{
        cssVars(){
            return{
                "--bg-image": `url(${require(`@/assets/titleImages/${this.image}`)})`,
                "--height": `${this.height}vh`
            }
        }
    }
}
</script>
<style lang="scss" scoped>
.chapter{
    position: relative;
    height: var(--height);
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
}
.overlay{
    position: absolute;
    width: 100%;
    height: 100%;
    background: #000;
    opacity: .3;
    z-index: 1;
}
.bg{
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-image: var(--bg-image);
    background-position: center;
    background-size: cover;
    background-repeat: no-repeat;
}
.chapterTitle{
    position: relative;
    z-index: 2;
    font-size: 2em;
    color: #fff;
    padding: 0 20px;
    text-align: center;
}
</style>