<template>
  <div v-if="isEnabled"></div>
</template>

<script setup>
import { computed, onMounted, watch, nextTick } from 'vue'
import { useData } from 'vitepress'

// 使用 ?raw 查询参数绕过 VitePress 的 markdown 转换，获取原始字符串
const mdFiles = import.meta.glob('/**/*.md', {
  query: '?raw',
  import: 'default',
  eager: true
})

const { page, frontmatter } = useData()

const isEnabled = computed(() => {
  return frontmatter.value?.titleHaveCopy === true
})

const COPY_ICON = `<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path></svg>`

const CHECK_ICON = `<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"></polyline></svg>`

const getMarkdownSource = () => {
  const relativePath = page.value.relativePath
  if (!relativePath) {
    console.warn('[TitleCopy] No relativePath')
    return ''
  }

  const key = '/' + relativePath
  let content = mdFiles[key]

  if (!content) {
    console.warn('[TitleCopy] No md found for key:', key)
    console.log('[TitleCopy] Available keys:', Object.keys(mdFiles))
    return ''
  }

  // 移除 frontmatter
  content = content.replace(/^---\n[\s\S]*?\n---\n/, '')
  return content
}

const addCopyButtons = () => {
  const headings = document.querySelectorAll('.vp-doc h1, .vp-doc h2')
  if (!headings.length) return

  headings.forEach(heading => {
    if (heading.querySelector('.title-copy-btn')) return

    const btn = document.createElement('button')
    btn.className = 'title-copy-btn'
    btn.innerHTML = COPY_ICON
    btn.title = '复制此部分 Markdown 原文'
    btn.addEventListener('click', async (e) => {
      e.preventDefault()
      e.stopPropagation()
      await copySection(heading, btn)
    })

    heading.appendChild(btn)
  })
}

const copySection = async (heading, btn) => {
  const headingText = heading.cloneNode(true)
  // 移除复制按钮
  const b = headingText.querySelector('.title-copy-btn')
  if (b) b.remove()
  // 移除 VitePress 添加的锚点链接
  const anchors = headingText.querySelectorAll('.header-anchor')
  anchors.forEach(a => a.remove())
  // 清理零宽空格等不可见字符
  const headingTitle = headingText.textContent
    .replace(/[​-‍﻿]/g, '')
    .trim()

  const headingLevel = parseInt(heading.tagName[1])
  const prefix = '#'.repeat(headingLevel)

  const markdownSource = getMarkdownSource()

  let content = ''

  if (markdownSource) {
    const lines = markdownSource.split('\n')
    let startIndex = -1

    for (let i = 0; i < lines.length; i++) {
      const line = lines[i]
      const match = line.match(/^(#{1,6})\s+(.+)$/)
      if (match) {
        const level = match[1].length
        const title = match[2].replace(/[​-‍﻿]/g, '').trim()
        if (level === headingLevel && title === headingTitle) {
          startIndex = i
          break
        }
      }
    }

    if (startIndex >= 0) {
      let endIndex = lines.length
      for (let i = startIndex + 1; i < lines.length; i++) {
        const line = lines[i]
        const match = line.match(/^(#{1,6})\s+/)
        if (match) {
          const level = match[1].length
          if (level <= headingLevel) {
            endIndex = i
            break
          }
        }
      }

      content = lines.slice(startIndex, endIndex).join('\n').trim()
    } else {
      console.warn('[TitleCopy] Heading not found in markdown:', JSON.stringify(headingTitle))
    }
  }

  if (!content) {
    console.error('[TitleCopy] Failed to get markdown content')
    return
  }

  try {
    await navigator.clipboard.writeText(content)

    btn.innerHTML = CHECK_ICON
    btn.classList.add('copied')

    setTimeout(() => {
      btn.innerHTML = COPY_ICON
      btn.classList.remove('copied')
    }, 1500)
  } catch (err) {
    console.error('[TitleCopy] Failed to copy:', err)
  }
}

onMounted(() => {
  if (!isEnabled.value) return
  nextTick(() => {
    setTimeout(addCopyButtons, 300)
  })
})

watch(() => page.value.relativePath, () => {
  nextTick(() => {
    setTimeout(addCopyButtons, 300)
  })
})
</script>

<style>
.title-copy-btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  margin-left: 8px;
  padding: 4px;
  background: transparent;
  border: none;
  border-radius: 4px;
  color: var(--vp-c-text-3);
  cursor: pointer;
  opacity: 0;
  transition: all 0.2s ease;
  vertical-align: middle;
}

.vp-doc h1:hover .title-copy-btn,
.vp-doc h2:hover .title-copy-btn {
  opacity: 1;
}

.title-copy-btn:hover {
  background: var(--vp-c-bg-soft);
  color: var(--vp-c-brand-1);
}

.title-copy-btn.copied {
  opacity: 1;
  color: #22c55e;
}
</style>
