<template>
  <div class="videoContainer">
    <video
      controls
      muted
      preload="metadata"
    >
      <slot />
      Your browser does not support the video tag.
    </video>
  </div>
</template>
<script>
export default {
    name: "Video",
    mounted(){
        const options = {
            root: null,
            rootMargin: "0px",
            threshold:0.9 //90% of the target is in view
        }
        //Plays video if the threshold is met
        //Pauses if it is not.
        const callback = function(entries, observer){
            entries.forEach(function(entry){
                if(entry.isIntersecting){
                entry.target.play();
                }else{
                entry.target.pause();
                }
            });
        }
        let observer = new IntersectionObserver(callback, options)
        const videos = document.querySelectorAll("video");
        //Observe all video elements
        videos.forEach(function(video){
            observer.observe(video);
        });
    }
}
</script>
<style lang="scss" scoped>
.videoContainer{
    margin: 0 auto;
    video{
        width: 100%;
    }
}

@media screen and (min-width: 1024px){
    .crop{
        max-width: 80vw;
    }
}
</style>