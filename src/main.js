import './assets/css/main.css'

import { createApp } from 'vue'
import { createPinia } from 'pinia'
import { library } from "@fortawesome/fontawesome-svg-core";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";

// social icons
import { faSquareXTwitter, faFacebookSquare, faGithub, faFlickr, faYoutubeSquare, faInstagram } from "@fortawesome/free-brands-svg-icons";
library.add(faSquareXTwitter, faFacebookSquare, faGithub, faFlickr, faYoutubeSquare, faInstagram);

import App from './App.vue'
import router from './router'

const app = createApp(App)

app.use(createPinia())
app.use(router)
app.component("FontAwesomeIcon", FontAwesomeIcon)

app.mount('#app')
