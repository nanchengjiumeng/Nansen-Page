<template>
  <Teleport to="body">
    <div v-if="isEnabled" class="grammar-helper">
      <!-- 展开状态：面板在按钮上方 -->
      <div v-if="isExpanded" class="grammar-helper__panel">
        <div class="grammar-helper__content">
          <GrammarLegend />
        </div>
      </div>

      <!-- 固定位置的切换按钮 -->
      <button
        class="grammar-helper__toggle"
        @click="toggle"
        :title="isExpanded ? '收起语法图例' : '展开语法图例'"
      >
        <!-- 收起状态：显示展开图标 -->
        <svg v-if="!isExpanded" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path>
          <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path>
        </svg>
        <!-- 展开状态：显示收起图标 -->
        <svg v-else width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <line x1="18" y1="6" x2="6" y2="18"></line>
          <line x1="6" y1="6" x2="18" y2="18"></line>
        </svg>
      </button>
    </div>
  </Teleport>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useData } from 'vitepress'

const { page } = useData()
const isExpanded = ref(false)

const isEnabled = computed(() => {
  return page.value.frontmatter?.grammarHelper === true
})

const toggle = () => {
  isExpanded.value = !isExpanded.value
}
</script>

<style scoped>
.grammar-helper {
  position: fixed;
  bottom: 24px;
  right: 24px;
  z-index: 100;
  display: flex;
  flex-direction: column;
  align-items: flex-end;
}

.grammar-helper__toggle {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  background: var(--vp-c-brand-1);
  border: none;
  color: #ffffff;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  transition: all 0.2s ease;
}

.grammar-helper__toggle:hover {
  transform: scale(1.05);
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.2);
}

.grammar-helper__panel {
  width: 280px;
  background: var(--vp-c-bg);
  border: 1px solid var(--vp-c-divider);
  border-radius: 12px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
  overflow: hidden;
  margin-bottom: 12px;
  animation: grammar-slide-in 0.3s ease;
}

@keyframes grammar-slide-in {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.grammar-helper__content {
  padding: 1rem;
  max-height: 70vh;
  overflow-y: auto;
}
</style>
