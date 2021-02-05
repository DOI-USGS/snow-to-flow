<template>
  <div class="usa-prose">
    <p
      v-if="buttonText === 'I understand'"
      class="warning-open"
    >
      This page is in active development and subject to change. <br/>
      <strong>Do not use</strong> information contained in this application for <strong>any</strong> purpose.
    </p>
  </div>
</template>

<script>
    export default {
        name: 'WorkInProgressWarning',
        data() {
            return {
                buttonText: 'I understand'
            }
        }
    }
</script>

<style scoped lang="scss">
  .usa-prose {
    background-color: #c2c4c5;
    padding-bottom: 0.3em;
    padding-top: 0.3em;
    p {
      max-width: 60em;
      text-align: center;
      margin: 0 auto;
    }
  }
</style>
