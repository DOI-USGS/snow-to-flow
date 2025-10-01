<template>
  <div class="usa-prose">
    <p
      class="warning-open"
    >
        Due to a lapse in government funding, this website is not currently being updated. For more information please visit: 
        <a 
          href="https://www.doi.gov/shutdown"
          target="_blank"
        >
          www.doi.gov/shutdown
        </a>
        .
    </p>
  </div>
</template>

<script>
    export default {
        name: 'ShutdownBanner',
    }
</script>

<style scoped lang="scss">
  .usa-prose {
    background-color: #9c3d10;
    color: #ffffff;
    padding-bottom: 0.3em;
    padding-top: 0.3em;
    p {
      max-width: 60em;
      text-align: center;
      margin: 0 auto;
      color: #ffffff !important;
      font-size: 20px;
      font-weight: 400;
    }
    a {
      font-size: 20px;
      color: #ffffff;
    }
  }
</style>
