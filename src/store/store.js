import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

export const store = new Vuex.Store({
    state: {
        usgsHeaderRendered: false,
        windowWidth: 0,
        windowHeight: 0,
        splashRenderedOnInitialLoad: false
    },
    mutations: {
        recordWindowWidth (state, payload) {
            state.windowWidth = payload
        },
        recordWindowHeight (state, payload) {
            state.windowHeight = payload
        },
        changeBooleanStateOnSplashRender (state) {
            state.splashRenderedOnInitialLoad = true
        }
    }
});
