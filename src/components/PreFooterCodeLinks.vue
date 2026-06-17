<template>
  <div id="code-repository-link-container">
    <a
      :href=gitHubRepositoryLink
      target="_blank"
      aria-label="github link"
    >See the code behind this visualization
      <font-awesome-icon :icon="{ prefix: 'fab', iconName: 'github' }" />
    </a>
  </div>
</template>

<script setup>
  const gitHubRepositoryLink = import.meta.env.VITE_APP_GITHUB_REPOSITORY_LINK;
</script>

<style lang="scss">

  #code-repository-link-container {
    display: flex;
    justify-content: right;
    width: 100%;
    background-color: #c2c4c5;
    margin: 0 auto;
    padding: 0.4rem;
    a {
      color: #090211;
      margin-left: 10px;
      font-family: 'Source Sans Pro',sans-serif;
      text-decoration: none
    }
  }

</style>
