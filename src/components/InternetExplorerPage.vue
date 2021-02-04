<template>
  <div class="main-content">
    <div class="usa-prose">
      <h1>Dear Internet Explorer user,</h1>
    </div>

    <p>
      As of January of 2016, Microsoft no longer provides security updates or technical support for
      old versions of Internet Explorer, and while Internet Explorer 11 (the latest version) is still supported for security updates,
      compatibility fixes, and technical support, it is becoming increasingly difficult, time consuming, and costly
      to maintain backward compatibility with this aging browser.
    </p><p>
      In order to bring you &mdash; and the rest of the internet audience &mdash; the best possible user experience,
      the {{ title }} application no longer offers support for any version of Internet Explorer.
    </p>
    <p>
      We regret any inconvenience this may cause, but we encourage you to return with one of the many other browsers available.
      We are sure you will be happy you did.
    </p>
  </div>
</template>

<script>
    export default {
        name: "InternetExplorerPageVue",
        data() {
            return {
                title: process.env.VUE_APP_TITLE
            }
        }
    }
</script>

<style scoped>
  .main-content {
    margin-left: auto;
    margin-right: auto;
    max-width: 1200px;
    padding: 2em;
  }
</style>
