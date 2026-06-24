import { defineConfig } from "vitepress";
import imagemin from "unplugin-imagemin/vite";

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "南城的网络小站",
  description: "A Programmer's Web Log",
  themeConfig: {
    nav: false,
    sidebar: false,
    socialLinks: [],
  },
  vite: {
    plugins: [
      imagemin({
        // 打包时压缩图片
      }),
    ],
  },
});
