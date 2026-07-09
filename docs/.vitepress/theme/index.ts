// https://vitepress.dev/guide/custom-theme
import { h } from 'vue'
import type { Theme } from 'vitepress'
import DefaultTheme from 'vitepress/theme'
import GrammarLegend from './components/GrammarLegend.vue'
import GrammarHelper from './components/GrammarHelper.vue'
import TitleCopy from './components/TitleCopy.vue'
import NceAudioPlayer from './components/NceAudioPlayer.vue'
import './style.css'
import './grammar.css'

export default {
  extends: DefaultTheme,
  Layout: () => {
    return h(DefaultTheme.Layout, null, {
      // https://vitepress.dev/guide/extending-default-theme#layout-slots
      'doc-after': () => [h(GrammarHelper), h(TitleCopy)]
    })
  },
  enhanceApp({ app, router, siteData }) {
    // 注册全局组件
    app.component('GrammarLegend', GrammarLegend)
    app.component('GrammarHelper', GrammarHelper)
    app.component('TitleCopy', TitleCopy)
    app.component('NceAudioPlayer', NceAudioPlayer)
  }
} satisfies Theme
