<template>
  <div class="main-content">
    <div class="usa-prose">
      <h1>
        Whoa, we have a problem.
      </h1>
    </div>
    <p>
      In techie terms, what has happened is called a 404 Error.
    </p>
    <p>
      It means the web page for which you are looking cannot be found in the
      place where you told the computer to look. Perhaps this elusive item really does not exist or perhaps while manually
      entering the URL something didn't go quite right. Either way, a good option is to give it one more shot.
    </p>
    <p>
      If that fails, the other option is to click the button below, which will take you to the {{ title }} main page. You can probably find the
      item for which you are looking there.
    </p>
    <router-link to="/">
      <button
        v-ga="$ga.commands.trackName.bind(this, 'Button - 404', 'click', 'user went from error page to index')"
        class="usa-button--inverse"
      >
        {{ title }} main page
      </button>
    </router-link>
    <p>
      Good luck, and sorry for the inconvenience.
    </p>
  </div>
</template>

<script>
    export default {
        name: 'Error404',
        props: {
            title: {
                type: String,
                default: process.env.VUE_APP_TITLE
            }
        }
    }
</script>

<style scoped lang="scss">
  .main-content {
    margin-left: auto;
    margin-right: auto;
    max-width: 1200px;
    padding: 2em;
  }
</style>
