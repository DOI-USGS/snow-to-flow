<template>
  <header id="navbar" class="header-nav"  role="banner">
    <div class="tmp-container">
        <!-- primary navigation bar -->
        <!-- search bar-->
        <div class="header-search">
        <a class="logo-header" href="https://www.usgs.gov/" target="_blank" title="USGS.gov homepage" aria-label="USGS.gov homepage">
            <img class="img"  src="@/assets/usgsHeaderAndFooter/images/usgsLogo_white-01.png"  alt="USGS logo. Science for a changing world." target="_blank"/>
          </a>
          <form action="https://www.usgs.gov/science-explorer-results" method="GET" id="search-box">
          <div class="fa-wrapper"><label for="se_search" class="only">Search</label>
            <input id="se_search" type="search" name="es" placeholder="Search">
            <button class="fa fa-search" type="submit">
              <span class="only">Search</span>
        </button></div>
          </form>
        </div>
        <!-- end search bar-->
    </div> 
    <!-- end header-container-->
  </header>
</template>

<script setup>
</script>

<style scoped>
</style>
