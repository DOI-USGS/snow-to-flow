<template>
  <div id="app">
    <WindowSize v-if="checkTypeOfEnv === '-test build-'" />
    <HeaderUSGS />
    <InternetExplorerPage v-if="isInternetExplorer" />
    <WorkInProgressWarning v-if="checkTypeOfEnv !== '' & !isInternetExplorer" /> <!-- an empty string in this case means the 'prod' version of the application   -->
    <router-view
      v-if="!isInternetExplorer"
    />
    <PreFooterVisualizationsLinks v-if="!isInternetExplorer" />
    <PreFooterCodeLinks v-if="!isInternetExplorer" />
    <FooterUSGS />
  </div>
</template>

<script>
    import WindowSize from "./components/WindowSize";
    import HeaderUSGS from './components/HeaderUSGS';
    export default {
        name: 'App',
        components: {
            WindowSize,
            HeaderUSGS,
            InternetExplorerPage: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "internet-explorer-page"*/ "./components/InternetExplorerPage"),
            WorkInProgressWarning: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "work-in-progress-warning"*/ "./components/WorkInProgressWarning"),
            PreFooterVisualizationsLinks: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "pre-footer-links-visualizations"*/ "./components/PreFooterVisualizationsLinks"),
            PreFooterCodeLinks: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "pre-footer-links-code"*/ "./components/PreFooterCodeLinks"),
            FooterUSGS: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "usgs-footer"*/ "./components/FooterUSGS") // Have Webpack put the footer in a separate chunk so we can load it conditionally (with a v-if) if we desire
        },
        data() {
            return {
                isInternetExplorer: false,
                title: process.env.VUE_APP_TITLE,
                publicPath: process.env.BASE_URL, // this is need for the data files in the public folder
            }
        },
        computed: {
          checkTypeOfEnv() {
              return process.env.VUE_APP_TIER
          }
        },
        created() {
            // We are ending support for Internet Explorer, so let's test to see if the browser used is IE.
            this.$browserDetect.isIE ? this.isInternetExplorer = true : this.isInternetExplorer = false;
            // Add window size tracking by adding a listener and a way to store the values in the Vuex state
            window.addEventListener('resize', this.handleResize);
            this.handleResize();
        },
        destroyed() {
            window.removeEventListener('resize', this.handleResize);
        },
        methods:{
          handleResize() {
                this.$store.commit('recordWindowWidth', window.innerWidth);
                this.$store.commit('recordWindowHeight', window.innerHeight);
            },
        }
    }
</script>

<style lang="scss">
@import url('https://fonts.googleapis.com/css2?family=Noto+Serif:ital,wght@0,400;0,700;1,400;1,700&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Amatic+SC:wght@400;700&display=swap'); //'Amatic SC', cursive;
@import url('https://fonts.googleapis.com/css2?family=Karla:wght@200;300;500;600;700;800&display=swap');//'Karla', sans-serif;

 // IMPORT
$nearBlack: #1a1b1c; //#1a1b1c;
$frostyGreen: #76A28E; // good contrast against black (original was #5e8a76)
$deepGreen: #2A4C40; // good contrast against white
$frostyPurple: #C9ADE6;
$deepPurple: #301546; // good contrast against black
$skyBlue: #0e64bb;
$lightGrey: #c2c4c5;
$darkGrey: #212122;
$familyMain: 'Source Sans Pro', sans-serif;
$familySerif:  'Noto Serif', serif;
$familyTest: 'Amatic SC', cursive;


// Type
html,
body {
      height:100%;
      margin: 0;
      padding: 0;
      color: $nearBlack;
      background-color: white;
      line-height: 1.4;
      font-size: 12pt;
      font-family: $familyMain;
      font-weight: 300;
      -webkit-font-smoothing: antialiased;
      -moz-osx-font-smoothing: grayscale;
      width: 100%;
  }
h1{
  font-size: 5em;
  font-weight: 400;
  font-family: $familyMain;
  line-height: 1;
  text-align: left;
  color: $deepPurple;
  @media screen and (max-width: 600px) {
    font-size: 5em;
  }
}

h2{
  color: $darkGrey;
  font-weight: 400;
  text-align: center;
  font-family:$familyMain;
  font-size: 1.8em;
  margin-top: 5px;
  line-height: 1.3;
  @media screen and (max-width: 600px) {
    font-size: 2em;
  }
}

h3{
  font-size: 1.5em;
  padding-top: .5em;
  font-family: $familyMain;
  font-weight: 300;
  @media screen and (max-width: 600px) {
      font-size: 1.4em;
  }  
}

p {
  padding: 1em 0 0 0; 
}

.overall-title {
  padding-top: 0vh;
  margin: 0;
  font-family: $familyTest;
  font-size: 7em;
  font-weight: 700;
  text-align: center;
  line-height: 1;
  overflow-x: hidden;
  @media screen and (max-width: 600px) {
    font-size: 5em;
    padding: 0 20px 0 20px;
  }
}
.big-statement {
  font-size: 2.75em;
  font-family: $familyTest;
  font-weight: 700;
  max-width: 670px;
  fill: black;
  color: $skyBlue;
  text-align: left;
}

.byline {
  font-style: italic;
  font-weight: 300;
  font-size: .8em;
  color: $nearBlack; 
}


  // General Layout  
  section {
    padding: 3em 0 3em 0;
  }


  .text-content {
    min-width: 300px;
    max-width: 700px;
    margin: 0 auto;
    padding: 10px;   
    @media screen and (max-width: 600px) {
        padding: 10px;
    }  
  }
  .flex-container {
    display: flex;
    flex-wrap: wrap;
    align-items: flex-start;
    justify-content: space-evenly;
    align-content: space-around;
    max-width: 30%;
    margin: auto;
    @media screen and (max-width: 600px) {
        max-width: 100%;
    }
  }

  .flex-item {
    padding: 20px;
    min-width: 400px;
    flex: 0 0 auto;
    align-self: center;
  }


  @media (max-width: 600px) {
    .flex-container {
      flex-direction: column;
    }
    .flex-item {
      flex: none;
      padding: 0 0 1em 0;
      height: 100%;
    }
  }

  .figure-content {
    border: 1px white;
    display: flex;
    flex-wrap: wrap;
    align-items: flex-start;
    justify-content: space-evenly;
    align-content: space-around;
    max-width: 100%;
    // padding: 0 100px;
    margin: auto;

    @media screen and (max-width: 600px) {
        padding: 0px; 
    }

  }


.viz-title-wrapper {
  max-width: 100%;
  z-index: 100;
  @media screen and (max-width: 600px) {
        max-width: 90%;
  }
}

.viz-title {
  // box-shadow: -5px -5px $monotoneBlue5;
  font-size: 1.4em;
  font-weight: 700;
  color: $darkGrey;
  margin-bottom: 0;
  @media screen and (max-width: 600px) {
       font-size: 1.2em;
       line-height: 1.2em;
  }
}

.viz-subtitle {
  color: $nearBlack;
  font-size: .8em;
  text-align: left;
  font-weight: 100;
  margin-bottom: 0;
  @media screen and (max-width: 600px) {
        font-size: .6em;
  }
}

.legend-text {
    fill: $deepPurple;
    font-family: $familyMain;
    font-size: 16px;
  }

.viz-comment {
  font-family: $familyMain;
  font-size: 26px;
  font-weight: 400;
  fill:rgb(224, 222, 222);
}
.viz-emph {
  font-weight:700;
  fill: white;
  font-family: $familyMain;
  font-size: 26px;
}

.emph {
  font-weight:700;
  fill: white;
  font-family: $familyMain;
  background: linear-gradient(180deg,rgba(255,255,255,0) 60%, $skyBlue 40%);
  line-height: 1.3em;
  padding: 0 5px;
}

</style>
