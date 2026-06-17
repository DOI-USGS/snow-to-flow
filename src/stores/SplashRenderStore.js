import { defineStore } from 'pinia'

export const useSplashRenderStore = defineStore('SplashRenderStore', {
    state: () => {
        return {
            splashRenderedOnInitialLoad: false,
        }
    }
})
