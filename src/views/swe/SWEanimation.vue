<template>
  <section id="swe-animation">
    <div class="text-content">
      <h2 class="big-statement">
        What is SWE?
      </h2>

      <div id="swe-animation-viz">
        <p>The Snow Water Equivalent (SWE) is the translation from snowpack to water, measured as a depth.</p>
        <div id="swe-viz">
          <svg
            id="swe-svg"
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 221 146"
          >
            <g>
              <path
                class="sketchy"
                d="M14.43,6V141"
              />
              <path
                class="sketchy"
                d="M8,137.3H211"
              />
              <g class="axes">
                <path d="M125.54,7.85v.92" />
                <path d="M125.54,10.59v123" />
                <path d="M125.54,134.53v.92" />
              </g>
              <path
                class="sketchy-blue"
                d="M15.81,132.22a15.18,15.18,0,0,0,8.26,0c2.93-.89,3.67-2,8.27-4.63,6.43-3.62,7.15-2.45,9.18-4.62,3.57-3.83,1.19-7.34,4.59-11.1s6.66-1.17,10.1-4.62c3.79-3.8.88-8,5.51-16.64,1.88-3.52,3.42-4.82,4.59-5.55,3.46-2.17,5.24-.4,8.27-1.85,5.72-2.74,3.28-11,10.1-15.72,3.16-2.18,3.9-.59,6.43-2.77,5.2-4.51,2.78-10.32,7.34-15.72,4.37-5.17,8.43-1.59,12.86-6.48,4.79-5.28,1.35-10.94,7.35-21.26,3-5.26,4.94-5.52,5.51-5.55,4.15-.24,7.7,7.79,9.18,11.09,9.25,20.61,21.48,39.73,31.22,60.11,3.22,6.74-1.42-1.73,15.61,27.74,3.14,5.43,4.86,8.3,8.27,11.09,7.34,6,16.42,6.67,22,6.48"
              />
            </g>
          </svg>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
    export default {
        name: 'SWE',
        data() {
            return {
              title: process.env.VUE_APP_TITLE
            }
        },
        computed: {
            windowHeight: function () {
                const usgsBannerHeight = 85;
                return Number(this.$store.state.windowHeight - this.$store.state.warningHeight - usgsBannerHeight) + 'px';
            }
        },
        mounted() {
        }
    }
</script>

<style scoped lang="scss">


#swe-animation-viz {
    height: 500px;
}
.sketchy {
    stroke-width: 2px;
    fill: none;
    stroke: black;

}
.sketchy-blue {
    stroke-width:10px;
    fill: none;
    stroke: #0e64bb;

}
.axes {
    fill: none;
    stroke-width: 1px;
    stroke-dasharray: 2px;
    stroke: black;
}
#swe-viz {
    position: relative;
    width: 60%;
}

</style>