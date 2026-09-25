<template>
  <footer class="footer">
    <div class="tmp-container">
      <!-- .footer-wrap -->
      <!-- .footer-doi -->
      <div class="footer-doi">
        <!-- footer nav links -->
        <ul class="menu nav">
          <li class="first leaf menu-links menu-level-1">
            <a
              href="https://www.doi.gov/privacy"
              target="_blank"
            >DOI Privacy Policy</a>
          </li>
          <li class="leaf menu-links menu-level-1">
            <a
              href="https://www.usgs.gov/policies-and-notices"
              target="_blank"
            >Legal</a>
          </li>
          <li class="leaf menu-links menu-level-1">
            <a
              href="https://www.usgs.gov/accessibility"
              target="_blank"
            >Accessibility</a>
          </li>
          <li class="leaf menu-links menu-level-1">
            <a
              href="https://www.usgs.gov/sitemap"
              target="_blank"
            >Site Map</a>
          </li>
          <li class="last leaf menu-links menu-level-1">
            <a
              href="https://answers.usgs.gov/"
              target="_blank"
            >Contact USGS</a>
          </li>
        </ul>
        <!--/ footer nav links -->      
      </div>
      <!-- /.footer-doi -->

      <hr>

      <!-- .footer-utl-links -->
      <div class="footer-doi">
        <ul class="menu nav">
          <li class="first leaf menu-links menu-level-1">
            <a
              href="https://www.doi.gov/"
              target="_blank"
            >U.S. Department of the Interior</a>
          </li>
          <li class="leaf menu-links menu-level-1">
            <a
              href="https://www.doioig.gov/"
              target="_blank"
            >DOI Inspector General</a>
          </li>
          <li class="leaf menu-links menu-level-1">
            <a
              href="https://www.whitehouse.gov/"
              target="_blank"
            >White House</a>
          </li>
          <li class="leaf menu-links menu-level-1">
            <a
              href="https://www.doi.gov/pmb/eeo/no-fear-act"
              target="_blank"
            >No Fear Act</a>
          </li>
          <li class="last leaf menu-links menu-level-1">
            <a
              href="https://www.usgs.gov/foia"
              target="_blank"
            >FOIA</a>
          </li>
        </ul>
      </div>			
      <!-- /.footer-utl-links -->
      <!-- .footer-social-links -->
      <div class="footer-social-links">
        <ul class="social">
          <li class="follow">
            Follow
          </li>
          <li class="twitter">
            <a
              href="https://x.com/usgs_water"
              target="_blank"
              aria-label="twitter link"
            >
              <font-awesome-icon
                :icon="{ prefix: 'fab', iconName: 'square-x-twitter' } "
                class="fa fa-square-x-twitter"
              ><span class="only">Twitter</span></font-awesome-icon>
            </a>
          </li>
          <li class="facebook">
            <a
              href="https://facebook.com/USGSWater/"
              target="_blank"
              aria-label="facebook link"
            >
              <font-awesome-icon
                :icon="{ prefix: 'fab', iconName: 'facebook-square' }"
                class="fa fa-facebook-square"
              ><span class="only">Facebook</span></font-awesome-icon>
            </a>
          </li>
          <li class="github">
            <a
              href="https://github.com/DOI-USGS"
              target="_blank"
              aria-label="github link"
            >
              <font-awesome-icon
                :icon="{ prefix: 'fab', iconName: 'github' }"
                class="fa fa-github"
              ><span class="only">GitHub</span></font-awesome-icon>
            </a>
          </li>
          <li class="flickr">
            <a
              href="https://flickr.com/usgeologicalsurvey"
              target="_blank"
              aria-label="flickr link"
            >
              <font-awesome-icon
                :icon="{ prefix: 'fab', iconName: 'flickr' }"
                class="fa fa-flickr"
              ><span class="only">Flickr</span></font-awesome-icon>
            </a>
          </li>
          <li class="youtube">
            <a
              href="http://youtube.com/usgs"
              target="_blank"
              aria-label="youtube link"
            >
              <font-awesome-icon
                :icon="{ prefix: 'fab', iconName: 'youtube-square' }"
                class="fa fa-youtube-play"
              ><span class="only">YouTube</span></font-awesome-icon>
            </a>
          </li>
          <li class="instagram">
            <a
              href="https://instagram.com/usgs_water"
              target="_blank"
              aria-label="instagram link"
            >
              <font-awesome-icon
                :icon="{ prefix: 'fab', iconName: 'instagram' }"
                class="fa fa-instagram"
              ><span class="only">Instagram</span></font-awesome-icon>
            </a>
          </li>
        </ul>
      </div>
      <!-- /.footer-social-links -->
    </div>
    <!-- /.footer-wrap -->	
  </footer>
</template>

<script setup>
</script>

<style scoped lang="scss">
/* USGS Viz ID default css in src/assets/common.css and src/assets/custom.csss */
/* custom edit to style font-awesome icons like template <i> elements */
footer p, text, li {
  padding: 0;
}
.fa {
  color:#fff;
	font-size: 24px;
}
/* custom edit to get margins to match example */
ul {
  margin-top: 15px;
}
ul.social {
  margin-bottom: 1rem;
}
/* Moved from common.js so that it doesn't affect USWDS banner css */
footer, header, main, nav, div {
  display: block;
}
</style>
