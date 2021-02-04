<template>
  <div class="pre-footer-links">
    <div class="inner-pre-footer-links-container">
      <p>Other visualizations of interest</p>
      <div class="footer-viz-links">
        <a
          :href="LinkOne"
        >
          <figure>
            <figcaption>Enter appropriate caption</figcaption>
            <img
              src="@/assets/components/PreFooterVisualizationsLinks/images/thumbnailGeneric.png"
              alt=""
            >
          </figure>
        </a>
        <a
          :href="LinkTwo"
        >
          <figure>
            <figcaption>Enter appropriate caption</figcaption>
            <img
              src="@/assets/components/PreFooterVisualizationsLinks/images/thumbnailGeneric.png"
              alt=""
            >
          </figure>
        </a>
      </div>
    </div>
  </div>
</template>

<script>
    export default {
        name: 'PreFooterVisualizationsLinks',
        data() {
            return {
                LinkOne: process.env.VUE_APP_FOOTER_LINK_1,
                LinkTwo: process.env.VUE_APP_FOOTER_LINK_2
            };
        }
    }
</script>

<style scoped lang="scss">
/* for mobile */
#app {
  .pre-footer-links {
    display: flex;
    justify-content: center;
    text-align: center;
    font-family: 'Source Sans Pro',sans-serif;
    font-size: 12px;
    font-weight: 600;
    p {
      color: white;
    }
    background-color: #00264c;
    .footer-viz-links {
      margin: 0 auto;
      display: flex;
      flex-direction: column;
      justify-content: center;
      a {
        figcaption {
          color: white;
          text-align: center;
          padding-bottom: 0.5em;
        }
        padding: 0.5em;
        max-width: 20rem;
      }
    }
  }
}

/* for everything but mobile */
@media only screen and (min-width: 700px) {
  #app {
    .pre-footer-links {
      .footer-viz-links {
        flex-direction: row;
        justify-content: center;
      }
    }
  }
}

#code-repository-link-container {
  a {
    color:white;
  }
}
</style>
