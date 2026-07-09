# Skill: assets 课文文本整理为 Markdown

## 适用场景

当需要把 `docs/assets/.../lessons/.../*.txt` 这类原始课文文本整理成站内 Markdown 文章时，使用本规范。

目标是：只整理文本格式，让页面在 PC 和手机上都容易阅读；不重写、不扩写、不改动原文内容本身。

## 核心原则

1. 保留原文内容，不做二次创作。
2. 删除明显广告、推广、公众号引流等无关内容。
3. 优先使用 Markdown 语法，不用大段 HTML 包裹正文。
4. 只在 Markdown 无法满足交互或布局时使用少量 HTML 标签。
5. 页面应简约、清晰、适合移动端阅读。
6. 每次修改后运行 `npm run docs:build` 验证。

## 推荐文件位置

课程文章放在：

```txt
docs/new-concept-english/
```

示例：

```txt
docs/new-concept-english/Lesson001_Excuse-me.md
```

栏目索引放在：

```txt
docs/new-concept-english/index.md
```

## Frontmatter

保持简单：

```md
---
title: Lesson 1 Excuse me!
---
```

不要保留原始抓取时间、来源时间等突兀信息，除非用户明确要求。

## 标题处理

文章顶部使用一级标题：

```md
# Lesson 1 Excuse me!
```

不要保留类似下面这种机械抓取标题：

```md
## （单词翻译）
```

如果标题本身没有阅读价值，应删除。

## 广告清理

删除类似内容：

```txt
搜索关注在线英语听力室公众号：tingroom，领取免费英语资料大礼包。
```

原则：广告、推广、引流内容都不进入文章正文。

## 英文与译文处理

所有“英文 + 中文译文”的句子对，默认只显示英文，中文译文折叠隐藏。

推荐格式：

```html
<details class="nce-translation">
<summary>Is this your handbag?</summary>
<p>这是您的手提包吗？</p>
</details>
```

要求：

- 默认不加 `open`。
- 英文放在 `summary`。
- 中文译文放在 `p`。
- 不要再单独保留整段“参考译文”，否则中文会默认暴露。

## 课文处理

原始课文如果是英文对话加参考译文，应整理成逐句折叠：

```html
<details class="nce-translation">
<summary>Excuse me!</summary>
<p>对不起</p>
</details>

<details class="nce-translation">
<summary>Yes?</summary>
<p>什么事？</p>
</details>
```

不要把整篇课文和整篇译文分成两个大块，这样手机阅读时对照成本高。

## 生词表处理

生词和短语适合整理成 Markdown 表格：

```md
| 单词 / 短语 | 释义 |
| --- | --- |
| excuse | v. 原谅 |
| handbag | n. （女用）手提包 |
```

注意：

- 词汇释义表不是“英文句子 + 译文”，不需要折叠。
- 不要擅自改词性、改释义。

## 普通说明文字

自学导读、语法说明、课堂笔记等中文说明，使用正常 Markdown 标题和段落：

```md
## 自学导读

### Excuse me!

Excuse me!这是常用于表示道歉的客套话……
```

原则：

- 不要为了“好看”把正文塞进大量 `<div>`。
- 能用 `##`、`###`、表格、引用块解决的，就不用 HTML。

## 例句处理

如果例句是英文 + 中文译文，也用折叠：

```html
<details class="nce-translation">
<summary>This is my pen.</summary>
<p>这是我的钢笔。</p>
</details>
```

如果只有英文，没有译文，可以保留普通引用块：

```md
> Is this your handbag?
```

## 表格中的译文

如果表格里有英文例句和中文译文，不要单独用“译文”列暴露中文。可以把英文和译文合并到一个可折叠单元格中：

```md
| 句式 | 例句 |
| --- | --- |
| 陈述句 | <details class="nce-translation"><summary>This is your watch.</summary><p>这是你的手表。</p></details> |
```

## 补充材料处理

补充材料不折叠，直接作为普通章节显示：

```md
## 补充材料
```

用户已明确偏好：不要把“课堂笔记”“补充材料”等大块内容折叠。

只有英文译文对需要折叠。

## 样式建议

可以在页面底部放少量局部 CSS，让译文折叠更简约。

推荐样式方向：

```css
.vp-doc._new-concept-english_Lesson001_Excuse-me .nce-translation {
  margin: 8px 0;
}

.vp-doc._new-concept-english_Lesson001_Excuse-me .nce-translation summary {
  cursor: pointer;
  display: inline;
  color: var(--vp-c-brand-1);
  font-weight: 600;
  line-height: 1.7;
}

.vp-doc._new-concept-english_Lesson001_Excuse-me .nce-translation p {
  margin: 4px 0 0 18px;
  padding: 0;
  color: var(--vp-c-text-2);
}
```

避免：

- 给折叠译文加厚边框。
- 大面积卡片化所有正文。
- 过度使用背景色。

## 移动端注意事项

表格需要能横向滚动：

```css
@media (max-width: 640px) {
  .vp-doc._new-concept-english_Lesson001_Excuse-me table {
    display: block;
    overflow-x: auto;
    white-space: nowrap;
  }
}
```

正文宽度控制在舒适范围：

```css
.vp-doc._new-concept-english_Lesson001_Excuse-me {
  max-width: 840px;
}
```

## 首页和索引

如果新增栏目，应维护索引：

```md
# 新概念英语第一册

- [Lesson 1 Excuse me!](./Lesson001_Excuse-me.md)
```

如果首页已有入口风格，可以加简洁入口；不要破坏已有栏目。

## 验证

完成后运行：

```bash
npm run docs:build
```

检查：

- Markdown 能正常构建。
- 没有广告内容残留。
- 英文译文对默认折叠。
- 没有不必要的大块折叠。
- 表格在移动端不会撑破页面。

## 不包含内容

本规范不包含播放器组件、播放器按钮、音频状态缓存等实现细节。
