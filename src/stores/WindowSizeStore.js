import { defineStore } from 'pinia'

export const useWindowSizeStore = defineStore('WindowSizeStore', {
    state: () => {
        return {
            windowWidth: 0,
            windowHeight: 0,
        }
    }
})
