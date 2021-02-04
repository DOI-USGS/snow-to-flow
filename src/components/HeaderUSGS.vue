<template>
  <section id="usgs-header">
    <header
      id="navbar"
      class="header-nav"
      role="banner"
    >
      <div class="tmp-container">
        <a
          class="logo-header"
          href="https://www.usgs.gov/"
          title="Home"
        >
          <img
            class="img"
            src="@/assets/usgsHeaderAndFooter/images/logo.png"
            alt="Home"
          >
        </a>
      </div>
    </header>
  </section>
</template>

<script>
export default {
  name: 'HeaderUSGS',
  mounted() {
    // The following code will only run after the entire 'intro' section has been rendered
    // it will change the Vuex state so that other components will know the 'intro' section has loaded
    this.$nextTick(function () {
      this.$store.commit('changeBooleanStateWhenUSGSHeaderRendered');
    });
  }
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
  background: #00264c;
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
