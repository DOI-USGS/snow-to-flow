<template>
  <div id="header">
    <header
      id="navbar"
      class="header-nav"
      role="banner"
    >
      <div class="tmp-container">
        <a
          class="logo-header"
          href="https://www.usgs.gov/mission-areas/water-resources/science/water-data-visualizations?qt-science_center_objects=0#qt-science_center_objects"
          title="Home"
          target="_blank"
        >
          <img
            class="img"
            src="@/assets/usgsHeaderAndFooter/images/usgsvizlab-logo-wordmark-white.png"
            alt="Home"
          >
        </a>
      </div>
    </header>
  </div>
</template>

<script>
    export default {
        name: 'HeaderUSGS'
    }
</script>

<style scoped lang="scss">
  header {
    display: block;
  }
  .tmp-container {
    margin-right: auto;
    margin-left: auto;
    padding-left: 15px;
    padding-right: 15px;
  }
  .tmp-container a {
    text-decoration: none;
    background: transparent;
  }
  .tmp-container:after {
    clear: both;
  }
  @media only screen and (max-width:490px) {
    hr {
      margin-top: 60px;
    }
  }
  /* header (only) nav */
  .header-nav {
    background: #292b30;
  }
  .logo-header img {
    margin-top: 8px;
    margin-bottom: 8px;
    border: 0;
    max-width: 100%;
    height: auto;
  }
  .logo-header img {
    height: 65px;
  }
</style>
