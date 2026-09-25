<template>
  <div class="usa-prose">
    <p
      v-if="buttonText === 'I understand'"
      class="warning-open"
    >
      ATTENTION! - You are viewing a prototype application that is in active development.
      Contents seen here are for placeholding and development only. <strong>DO NOT USE</strong> information
      contained in this application for ANY purpose.
    </p>
    <button @click="toggleWarning">
      {{ buttonText }}
    </button>
  </div>
</template>

<script setup>
  import { ref } from "vue";

  const buttonText = ref();
  buttonText.value = 'I understand';

  function toggleWarning() {
    buttonText.value === 'I understand' ? buttonText.value = 'read in progress warning' : buttonText.value = 'I understand';
  }
</script>

<style scoped lang="scss">
  .usa-prose {
    background-color: #b9c7d2;
    padding-bottom: 0.3em;
    padding-top: 0.3em;
    p {
      max-width: 60em;
      text-align: center;
      margin: 0 auto 5px auto;
    }
    button {
      display: block;
      margin: 0 auto;
      background: var(--color-USGS-header-footer);
      color: #ffffff;
      border: none;
      outline: none;
      padding: 6px 10px;
      border-radius: 5px;
      font-weight: bold;
      font-size: small;
    }
  }
</style>
