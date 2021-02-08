<template>
  <div class="pre-footer-links">
    <div class="inner-pre-footer-links-container">
      <p>See our other visualizations:</p>
      <div class="footer-viz-links">
        <a
          :href="LinkOne"
          target="_blank"
        >
          <figure>
            <img
              src="@/assets/components/PreFooterVisualizationsLinks/images/DRBthumb.png"
              alt=""
            >
            <figcaption>Water science and management in the Delaware River Basin</figcaption>
          </figure>
        </a>
        <a
          :href="LinkTwo"
          target="_blank"
        >
          <figure>
            <img
              src="@/assets/components/PreFooterVisualizationsLinks/images/fire-hydro.jpg"
              alt=""
            >
            <figcaption>How wildfires threaten U.S. water supplies</figcaption>
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
    font-size: 16px;
    font-weight: 400;
    padding-top: .25em;
    p {
      color: white;
      font-size: 1.3em;
    }
    background-color: #292b30;

    .footer-viz-links {
      margin: 0 auto;
      display: flex;
      flex-direction: column;
      justify-content: center;

      img {
        width: 200px;
        height: 200px;
        top: 0;
        left: 0;
      }
      a {
        figcaption {
          color: white;
          text-align: center;
          padding-bottom: 0.5em;
        }
        padding: 0.5em;
        max-width: 25rem;
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
