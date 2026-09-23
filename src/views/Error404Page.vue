<template>
  <div class="usa-section">
    <div class="grid-container">
      <div class="grid-row grid-gap">
        <main
          id="main-content"
          class=""
        >
          <div class="usa-prose">
            <h1>Page not found</h1>
            <p class="usa-intro">
              We’re sorry, we can’t find the page you're looking for. The site
              administrator may have removed it, changed its location, or made
              it otherwise unavailable.
            </p>
            <p>
              If you typed the URL directly, check your spelling and
              capitalization. Our URLs look like this:
              <strong>&lt;water.usgs.gov/vizlab/{{ title }}&gt;</strong>.
            </p>
            <p>
              Visit the main page for this data visualization, or contact us
              and we’ll point you in the right direction.
            </p>
            <div class="margin-y-5">
              <ul class="usa-button-group">
                <li class="usa-button-group__item">
                  <RouterLink
                    to="/"
                    class="usa-button"
                  >
                    Visit {{ long_title }} main page
                  </RouterLink>
                </li>
                <li class="usa-button-group__item">
                  <a
                    href="mailto:gs-w_vizlab@usgs.gov"
                    target="_blank"
                    class="usa-button usa-button--outline"
                  >Contact us</a>
                </li>
              </ul>
            </div>
            <p class="text-base">
              <strong>Error code:</strong> 404
            </p>
          </div>
        </main>
      </div>
    </div>
  </div>
</template>

<script setup>
  import { RouterLink } from 'vue-router';

  const title = import.meta.env.VITE_APP_TITLE;
  const long_title = import.meta.env.VITE_APP_LONG_TITLE;
</script>

<style scoped lang="scss">
  @import '../../node_modules/@uswds/uswds/dist/css/uswds.css';
  .usa-section {
    height: max(500px, calc(100vh - 20.4px - 85.7px - 32px - 92.3px)); /* page height - USWDS banner - USGS header - prefooter code links - USGS footer */
  }
  .usa-prose h1 {
    font-size: 3.9rem;
  }
  .usa-prose p {
    font-size: 1.7rem;
  }
  
  .usa-intro {
    font-size: 2rem !important;
  }
  .usa-button {
    font-size: 1.7rem;
  }
  .grid-container {
    margin-left: auto !important;
    margin-right: auto !important;
    max-width: 87.5rem !important;
  }
</style>
