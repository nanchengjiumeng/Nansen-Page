<template>
  <div
    class="nce-player"
    :class="{ 'is-collapsed': isCollapsed }"
    role="region"
    aria-label="音频播放器"
  >
    <audio
      ref="audioRef"
      :src="src"
      preload="metadata"
      @loadedmetadata="handleLoadedMetadata"
      @timeupdate="syncState"
      @play="isPlaying = true"
      @pause="isPlaying = false"
      @ended="isPlaying = false"
    />

    <button
      v-if="isCollapsed"
      class="nce-player__collapsed-tab"
      type="button"
      aria-label="展开播放器"
      title="展开播放器"
      @click="isCollapsed = false"
    >
      <span v-if="isPlaying" class="nce-player__playing-dot" aria-hidden="true"></span>
      <span aria-hidden="true">›</span>
    </button>

    <div v-else class="nce-player__body">
      <div class="nce-player__top">
      <button class="nce-player__play" type="button" @click="togglePlay">
        {{ isPlaying ? '暂停' : '播放' }}
      </button>

      <div class="nce-player__time">
        {{ formatTime(currentTime) }} / {{ formatTime(duration) }}
      </div>

      <input
        class="nce-player__range"
        type="range"
        min="0"
        :max="duration || 0"
        step="0.1"
        :value="currentTime"
        aria-label="播放进度"
        @input="seekTo"
      />

      <button
        class="nce-player__toggle"
        type="button"
        :aria-expanded="shortcutsOpen"
        @click="shortcutsOpen = !shortcutsOpen"
      >
        {{ shortcutsOpen ? '收起快捷' : '快捷按钮' }}
      </button>

      <button
        class="nce-player__collapse"
        type="button"
        aria-label="收起播放器"
        title="收起播放器"
        @click="collapsePlayer"
      >
        <svg
          aria-hidden="true"
          viewBox="0 0 24 24"
          width="20"
          height="20"
          fill="none"
          stroke="currentColor"
          stroke-width="2.5"
          stroke-linecap="round"
          stroke-linejoin="round"
        >
          <path d="M15 18l-6-6 6-6" />
        </svg>
      </button>
      </div>

      <div v-if="shortcutsOpen" class="nce-player__buttons" aria-label="快捷控制">
      <button
        v-for="rate in rates"
        :key="rate"
        class="nce-player__button"
        :class="{ 'is-active': playbackRate === rate }"
        type="button"
        @click="setRate(rate)"
      >
        {{ rate }}倍速
      </button>

      <button
        v-for="seconds in backwardSteps"
        :key="`back-${seconds}`"
        class="nce-player__button"
        type="button"
        @click="skip(-seconds)"
      >
        后退{{ seconds }}秒
      </button>

      <button
        v-for="seconds in forwardSteps"
        :key="`forward-${seconds}`"
        class="nce-player__button"
        type="button"
        @click="skip(seconds)"
      >
        前进{{ seconds }}秒
      </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue'

const props = defineProps({
  src: {
    type: String,
    required: true
  }
})

const STORAGE_KEY = 'nce-audio-player-state'

const audioRef = ref(null)
const isPlaying = ref(false)
const currentTime = ref(0)
const duration = ref(0)
const playbackRate = ref(1)
const shortcutsOpen = ref(false)
const isCollapsed = ref(false)
const savedTimeToRestore = ref(0)

const rates = [0.3, 0.5, 1]
const backwardSteps = [1, 3, 5]
const forwardSteps = [1, 3, 5]

const syncState = () => {
  const audio = audioRef.value
  if (!audio) return

  currentTime.value = audio.currentTime || 0
  duration.value = Number.isFinite(audio.duration) ? audio.duration : 0
  playbackRate.value = audio.playbackRate
  saveState()
}

const handleLoadedMetadata = () => {
  const audio = audioRef.value
  if (!audio) return

  duration.value = Number.isFinite(audio.duration) ? audio.duration : 0

  if (savedTimeToRestore.value > 0 && savedTimeToRestore.value < duration.value) {
    audio.currentTime = savedTimeToRestore.value
    currentTime.value = savedTimeToRestore.value
    savedTimeToRestore.value = 0
  }

  syncState()
}

const togglePlay = async () => {
  const audio = audioRef.value
  if (!audio) return

  if (audio.paused) {
    await audio.play()
  } else {
    audio.pause()
  }
}

const setRate = (rate) => {
  const audio = audioRef.value
  if (!audio) return

  audio.playbackRate = rate
  playbackRate.value = rate
  saveState()
}

const skip = (seconds) => {
  const audio = audioRef.value
  if (!audio) return

  const nextTime = Math.min(
    Math.max(audio.currentTime + seconds, 0),
    duration.value || audio.duration || 0
  )
  audio.currentTime = nextTime
  currentTime.value = nextTime
  saveState()
}

const seekTo = (event) => {
  const audio = audioRef.value
  if (!audio) return

  const nextTime = Number(event.target.value)
  audio.currentTime = nextTime
  currentTime.value = nextTime
  saveState()
}

const collapsePlayer = () => {
  shortcutsOpen.value = false
  isCollapsed.value = true
}

const readState = () => {
  if (typeof window === 'undefined') return null

  try {
    const raw = window.localStorage.getItem(STORAGE_KEY)
    return raw ? JSON.parse(raw) : null
  } catch {
    return null
  }
}

const saveState = () => {
  if (typeof window === 'undefined') return

  try {
    window.localStorage.setItem(
      STORAGE_KEY,
      JSON.stringify({
        src: props.src,
        currentTime: currentTime.value,
        playbackRate: playbackRate.value,
        shortcutsOpen: shortcutsOpen.value,
        isCollapsed: isCollapsed.value
      })
    )
  } catch {
    // localStorage may be unavailable in private/security-restricted contexts.
  }
}

const restoreState = () => {
  const state = readState()
  if (!state) return

  if (typeof state.playbackRate === 'number' && rates.includes(state.playbackRate)) {
    playbackRate.value = state.playbackRate
  }

  shortcutsOpen.value = Boolean(state.shortcutsOpen)
  isCollapsed.value = Boolean(state.isCollapsed)

  if (state.src === props.src && typeof state.currentTime === 'number') {
    savedTimeToRestore.value = Math.max(state.currentTime, 0)
    currentTime.value = savedTimeToRestore.value
  }
}

const formatTime = (seconds) => {
  if (!Number.isFinite(seconds) || seconds <= 0) return '0:00'

  const minutes = Math.floor(seconds / 60)
  const rest = Math.floor(seconds % 60)
  return `${minutes}:${String(rest).padStart(2, '0')}`
}

onMounted(() => {
  restoreState()

  const audio = audioRef.value
  if (audio) {
    audio.playbackRate = playbackRate.value
  }
})

watch([shortcutsOpen, isCollapsed], saveState)
</script>

<style scoped>
.nce-player {
  position: fixed;
  left: 50%;
  bottom: 18px;
  z-index: 20;
  width: min(880px, calc(100vw - 48px));
  transform: translateX(-50%);
  padding: 12px;
  border: 1px solid var(--vp-c-divider);
  border-radius: 18px;
  box-shadow: 0 14px 40px color-mix(in srgb, #000, transparent 82%);
  background: color-mix(in srgb, var(--vp-c-bg), transparent 4%);
  backdrop-filter: blur(16px);
}

.nce-player.is-collapsed {
  left: 0;
  top: calc(var(--vp-nav-height) + 24px);
  bottom: auto;
  width: auto;
  padding: 0;
  border: 0;
  box-shadow: none;
  background: transparent;
  backdrop-filter: none;
  transform: none;
}

.nce-player__collapsed-tab {
  position: relative;
  width: 30px;
  height: 54px;
  padding: 0;
  border: 1px solid var(--vp-c-divider);
  border-left: 0;
  border-radius: 0 999px 999px 0;
  box-shadow: 8px 8px 24px color-mix(in srgb, #000, transparent 86%);
  background: color-mix(in srgb, var(--vp-c-bg), transparent 4%);
  color: var(--vp-c-text-1);
  font-size: 28px;
  line-height: 1;
  cursor: pointer;
  backdrop-filter: blur(16px);
}

.nce-player__playing-dot {
  position: absolute;
  top: 10px;
  right: 7px;
  width: 6px;
  height: 6px;
  border-radius: 999px;
  background: var(--vp-c-brand-1);
}

.nce-player__collapse {
  width: 34px;
  padding: 0;
  background: var(--vp-c-bg-soft);
  color: var(--vp-c-text-3);
  display: inline-flex;
  align-items: center;
  justify-content: center;
}

.nce-player__collapse:hover,
.nce-player__collapsed-tab:hover {
  color: var(--vp-c-brand-1);
}

.nce-player__top {
  display: grid;
  grid-template-columns: auto auto minmax(160px, 1fr) auto auto;
  gap: 10px;
  align-items: center;
}

.nce-player__play,
.nce-player__toggle,
.nce-player__collapse,
.nce-player__button {
  height: 34px;
  border: 1px solid var(--vp-c-divider);
  border-radius: 999px;
  background: var(--vp-c-bg-soft);
  color: var(--vp-c-text-1);
  font-size: 13px;
  font-weight: 650;
  white-space: nowrap;
  cursor: pointer;
  transition:
    border-color 0.16s ease,
    background 0.16s ease,
    color 0.16s ease;
}

.nce-player__play {
  min-width: 64px;
  background: var(--vp-c-brand-1);
  color: #fff;
  border-color: var(--vp-c-brand-1);
}

.nce-player__button {
  padding: 0 12px;
}

.nce-player__toggle {
  padding: 0 12px;
  background: transparent;
}

.nce-player__button:hover,
.nce-player__toggle:hover,
.nce-player__play:hover,
.nce-player__button.is-active {
  border-color: var(--vp-c-brand-1);
  background: var(--vp-c-brand-soft);
  color: var(--vp-c-brand-1);
}

.nce-player__play:hover {
  background: var(--vp-c-brand-2);
  color: #fff;
}

.nce-player__time {
  color: var(--vp-c-text-2);
  font-size: 13px;
  font-variant-numeric: tabular-nums;
  white-space: nowrap;
}

.nce-player__range {
  width: 100%;
  accent-color: var(--vp-c-brand-1);
}

.nce-player__buttons {
  display: grid;
  grid-template-columns: repeat(9, minmax(0, 1fr));
  gap: 8px;
  margin-top: 10px;
}

@media (max-width: 640px) {
  .nce-player {
    bottom: 10px;
    width: calc(100vw - 24px);
    padding: 10px;
    border-radius: 16px;
  }

  .nce-player.is-collapsed {
    left: 0;
    top: calc(var(--vp-nav-height) + 16px);
    bottom: auto;
    width: auto;
    padding: 0;
  }

  .nce-player__top {
    grid-template-columns: auto 1fr auto auto;
  }

  .nce-player__time {
    justify-self: end;
  }

  .nce-player__range {
    grid-column: 1 / -1;
    grid-row: 2;
  }

  .nce-player__buttons {
    grid-template-columns: repeat(3, minmax(0, 1fr));
    gap: 7px;
  }

  .nce-player__button {
    width: 100%;
    height: 36px;
    padding: 0 6px;
    font-size: 12px;
  }

  .nce-player__toggle {
    padding: 0 10px;
    font-size: 12px;
  }
}
</style>
