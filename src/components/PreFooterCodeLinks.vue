<template>
  <div id="code-repository-link-container">
    <a
      :href="gitHubRepositoryLink"
      target="_blank"
      aria-label="github link"
    >Get the {{ projectTitle }} code
      <font-awesome-icon :icon="{ prefix: 'fab', iconName: 'github' }" />
    </a>
  </div>
</template>

<script>
  export default {
      name: 'PreFooterCodeLinks',
      data() {
          return {
              gitHubRepositoryLink: process.env.VUE_APP_GITHUB_REPOSITORY_LINK,
              projectTitle: process.env.VUE_APP_TITLE
          }
      }
  }

</script>

<style scoped lang="scss">
  #code-repository-link-container {
    display: flex;
    justify-content: center;
    width: 100%;
    background-color: #00264c;
    margin: 0 auto;
    padding-bottom: 0.4rem;
    a {
      color: white;
      font-family: 'Source Sans Pro',sans-serif;
      font-size: 12px;
      text-decoration: none
    }
  }

</style>
