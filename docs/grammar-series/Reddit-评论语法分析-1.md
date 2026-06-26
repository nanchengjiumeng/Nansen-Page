---
grammarHelper: true
titleHaveCopy: true
---

# reddit 评论语法分析（一）

---

# 1. 原句

<span class="grammar-word grammar-word--3">The(9)</span> <span class="grammar-word grammar-word--1">field(1)</span> <span class="grammar-word grammar-word--4">of(6)</span> <span class="grammar-word grammar-word--1">linguistics(1)</span> <span class="grammar-word grammar-word--2">is(2)</span> <span class="grammar-word grammar-word--4">not(4)</span> <span class="grammar-word grammar-word--4">for(6)</span> <span class="grammar-word grammar-word--1">those(5)</span> <span class="grammar-word grammar-word--2">looking(2)</span> <span class="grammar-word grammar-word--4">for(6)</span> <span class="grammar-word grammar-word--3">easy(3)</span> <span class="grammar-word grammar-word--1">answers(1)</span><span class="grammar-punct">;</span> <span class="grammar-word grammar-word--1">it(5)</span> <span class="grammar-word grammar-word--2">is(2)</span> <span class="grammar-word grammar-word--3">the(9)</span> <span class="grammar-word grammar-word--3">systematic(3)</span> <span class="grammar-word grammar-word--1">study(1)</span> <span class="grammar-word grammar-word--4">of(6)</span> <span class="grammar-word grammar-word--3">the(9)</span> <span class="grammar-word grammar-word--3">unique(3)</span> <span class="grammar-word grammar-word--3">mental(3)</span> <span class="grammar-word grammar-word--1">capacities(1)</span> <span class="grammar-word grammar-word--2">required(2)</span> <span class="grammar-word grammar-word--2">to acquire(2)</span> <span class="grammar-word grammar-word--7">and(7)</span> <span class="grammar-word grammar-word--2">to use(2)</span> <span class="grammar-word grammar-word--3">a(9)</span> <span class="grammar-word grammar-word--3">particular(3)</span> <span class="grammar-word grammar-word--1">language(1)</span><span class="grammar-punct">,</span> <span class="grammar-word grammar-word--7">or(7)</span> <span class="grammar-word grammar-word--4">indeed(4)</span> <span class="grammar-word grammar-word--3">any(11)</span> <span class="grammar-word grammar-word--3">human(3)</span> <span class="grammar-word grammar-word--1">language(1)</span><span class="grammar-punct">.</span>

---

# 2. 整体结构

这不是两个独立句子，而是一个句子，中间用分号连接两个完整分句。

## 2.1 第一个完整分句

> <span class="grammar-word grammar-word--3">The(9)</span> <span class="grammar-word grammar-word--1">field(1)</span> <span class="grammar-word grammar-word--4">of(6)</span> <span class="grammar-word grammar-word--1">linguistics(1)</span> <span class="grammar-word grammar-word--2">is(2)</span> <span class="grammar-word grammar-word--4">not(4)</span> <span class="grammar-word grammar-word--4">for(6)</span> <span class="grammar-word grammar-word--1">those(5)</span> <span class="grammar-word grammar-word--2">looking(2)</span> <span class="grammar-word grammar-word--4">for(6)</span> <span class="grammar-word grammar-word--3">easy(3)</span> <span class="grammar-word grammar-word--1">answers(1)</span>

主干是：

> The field of linguistics is not for those...

意思是：

> 语言学这个领域不是给那些人准备的。

## 2.2 第二个完整分句

> <span class="grammar-word grammar-word--1">it(5)</span> <span class="grammar-word grammar-word--2">is(2)</span> <span class="grammar-word grammar-word--3">the(9)</span> <span class="grammar-word grammar-word--3">systematic(3)</span> <span class="grammar-word grammar-word--1">study(1)</span> <span class="grammar-word grammar-word--4">of(6)</span> <span class="grammar-word grammar-word--3">the(9)</span> <span class="grammar-word grammar-word--3">unique(3)</span> <span class="grammar-word grammar-word--3">mental(3)</span> <span class="grammar-word grammar-word--1">capacities(1)</span>...

主干是：

> it is the study

意思是：

> 它是一种研究。

分号 <span class="grammar-punct">;</span> 的作用类似中文的"；"，表示前后两个分句都完整，但语义关系紧密。

---

# 3. 第一部分结构分析

原文：

> The field of linguistics is not for those looking for easy answers.

结构：

1. <span class="grammar-word grammar-word--1">The field of linguistics</span> = 主语，名词性成分
2. <span class="grammar-word grammar-word--2">is</span> <span class="grammar-word grammar-word--4">not</span> = 系动词 + 否定
3. <span class="grammar-word grammar-word--4">for</span> <span class="grammar-word grammar-word--1">those</span> <span class="grammar-word grammar-word--2">looking</span> <span class="grammar-word grammar-word--4">for</span> <span class="grammar-word grammar-word--3">easy</span> <span class="grammar-word grammar-word--1">answers</span> = 介词短语，作表语 / 主语补足语

## 3.1 主语内部

> <span class="grammar-word grammar-word--3">The(9)</span> <span class="grammar-word grammar-word--1">field(1)</span> <span class="grammar-word grammar-word--4">of(6)</span> <span class="grammar-word grammar-word--1">linguistics(1)</span>

结构：

1. <span class="grammar-word grammar-word--3">The</span> = 限定词 / 冠词
2. <span class="grammar-word grammar-word--1">field</span> = 核心名词
3. <span class="grammar-word grammar-word--4">of linguistics</span> = 介词短语，修饰 field

意思：

> 语言学这个领域

## 3.2 those looking for easy answers

> <span class="grammar-word grammar-word--1">those(5)</span> <span class="grammar-word grammar-word--2">looking(2)</span> <span class="grammar-word grammar-word--4">for(6)</span> <span class="grammar-word grammar-word--3">easy(3)</span> <span class="grammar-word grammar-word--1">answers(1)</span>

结构：

1. <span class="grammar-word grammar-word--1">those</span> = 那些人
2. <span class="grammar-word grammar-word--2">looking for easy answers</span> = 现在分词短语，作后置定语，修饰 those
3. <span class="grammar-word grammar-word--4">for easy answers</span> = 介词短语，作 looking 的补足内容
4. <span class="grammar-word grammar-word--3">easy</span> = 形容词，修饰 answers
5. <span class="grammar-word grammar-word--1">answers</span> = 名词

可以还原成：

> those who are looking for easy answers

意思是：

> 那些寻找简单答案的人

第一部分整体意思：

> 语言学这个领域不是给那些寻找简单答案的人准备的。

---

# 4. 第二部分结构分析

原文：

> it is the systematic study of the unique mental capacities required to acquire and to use a particular language, or indeed any human language.

结构：

1. <span class="grammar-word grammar-word--1">it</span> = 主语，指代 the field of linguistics
2. <span class="grammar-word grammar-word--2">is</span> = 系动词
3. <span class="grammar-word grammar-word--1">the systematic study...</span> = 表语

核心结构：

> it is the study

意思：

> 它是一种研究。

---

# 5. 长名词短语分析

长名词短语：

> <span class="grammar-word grammar-word--3">the(9)</span> <span class="grammar-word grammar-word--3">systematic(3)</span> <span class="grammar-word grammar-word--1">study(1)</span> <span class="grammar-word grammar-word--4">of(6)</span> <span class="grammar-word grammar-word--3">the(9)</span> <span class="grammar-word grammar-word--3">unique(3)</span> <span class="grammar-word grammar-word--3">mental(3)</span> <span class="grammar-word grammar-word--1">capacities(1)</span> <span class="grammar-word grammar-word--2">required(2)</span> <span class="grammar-word grammar-word--2">to acquire(2)</span> <span class="grammar-word grammar-word--7">and(7)</span> <span class="grammar-word grammar-word--2">to use(2)</span> <span class="grammar-word grammar-word--3">a(9)</span> <span class="grammar-word grammar-word--3">particular(3)</span> <span class="grammar-word grammar-word--1">language(1)</span>

核心是：

> the study of mental capacities

意思：

> 对心智能力的研究

内部结构：

1. <span class="grammar-word grammar-word--3">systematic</span> = 形容词，修饰 study
2. <span class="grammar-word grammar-word--1">study</span> = 核心名词
3. <span class="grammar-word grammar-word--4">of the unique mental capacities...</span> = 介词短语，说明研究对象
4. <span class="grammar-word grammar-word--3">unique</span> = 形容词，修饰 mental capacities
5. <span class="grammar-word grammar-word--3">mental</span> = 形容词，修饰 capacities
6. <span class="grammar-word grammar-word--1">capacities</span> = 名词，表示"能力"
7. <span class="grammar-word grammar-word--2">required to acquire and to use...</span> = 过去分词短语，作后置定语，修饰 capacities

---

# 6. required to acquire and to use...

> <span class="grammar-word grammar-word--2">required(2)</span> <span class="grammar-word grammar-word--2">to acquire(2)</span> <span class="grammar-word grammar-word--7">and(7)</span> <span class="grammar-word grammar-word--2">to use(2)</span> <span class="grammar-word grammar-word--3">a(9)</span> <span class="grammar-word grammar-word--3">particular(3)</span> <span class="grammar-word grammar-word--1">language(1)</span>

这里的 <span class="grammar-word grammar-word--2">required</span> 不是过去式，而是过去分词，表示被动含义。

原结构：

> mental capacities required...

可以还原成：

> mental capacities that are required...

意思是：

> 被需要的心智能力

完整还原：

> mental capacities that are required to acquire and to use a particular language

意思：

> 习得并使用某种特定语言所需要的心智能力

---

# 7. acquire and use

> <span class="grammar-word grammar-word--2">to acquire(2)</span> <span class="grammar-word grammar-word--7">and(7)</span> <span class="grammar-word grammar-word--2">to use(2)</span> <span class="grammar-word grammar-word--3">a(9)</span> <span class="grammar-word grammar-word--3">particular(3)</span> <span class="grammar-word grammar-word--1">language(1)</span>

<span class="grammar-word grammar-word--7">and</span> 连接两个同级动作：

1. <span class="grammar-word grammar-word--2">to acquire</span> a particular language
2. <span class="grammar-word grammar-word--2">to use</span> a particular language

意思：

> 习得并使用某种特定语言

这里两个动作共享同一个宾语：

> a particular language

---

# 8. or indeed any human language

> <span class="grammar-word grammar-word--7">or(7)</span> <span class="grammar-word grammar-word--4">indeed(4)</span> <span class="grammar-word grammar-word--3">any(11)</span> <span class="grammar-word grammar-word--3">human(3)</span> <span class="grammar-word grammar-word--1">language(1)</span>

这里是对前面的 <span class="grammar-word grammar-word--3">a(9)</span> <span class="grammar-word grammar-word--3">particular(3)</span> <span class="grammar-word grammar-word--1">language(1)</span> 的补充扩大。

结构：

1. <span class="grammar-word grammar-word--7">or</span> = 连词，表示"或者"
2. <span class="grammar-word grammar-word--4">indeed</span> = 副词，表示强调，可以理解为"甚至可以说"
3. <span class="grammar-word grammar-word--3">any</span> = 限定词，表示"任何"
4. <span class="grammar-word grammar-word--3">human</span> = 形容词，修饰 language
5. <span class="grammar-word grammar-word--1">language</span> = 名词

意思：

> 某种特定语言，或者甚至可以说，任何人类语言

---

# 9. 整句意思

这句话可以翻译为：

> 语言学这个领域不是给那些寻找简单答案的人准备的；它系统研究的是人类习得并使用某种特定语言，甚至任何人类语言，所需要的独特心智能力。

更自然一点：

> 语言学并不适合那些想要寻找简单答案的人；它研究的是人类为了习得并使用某种特定语言，甚至任何人类语言，所必须具备的独特心智能力。

---

# 10. 语法难点总结

这句话难在以下几个地方：

1. <span class="grammar-punct">分号 ;</span> 连接两个完整分句
2. <span class="grammar-word grammar-word--2">looking for...</span> 现在分词短语作后置定语
3. <span class="grammar-word grammar-word--1">the systematic study of...</span> 是一个较长的名词短语
4. <span class="grammar-word grammar-word--2">required to acquire...</span> 过去分词短语作后置定语
5. <span class="grammar-word grammar-word--2">to acquire</span> 和 <span class="grammar-word grammar-word--2">to use</span> 是两个并列不定式动作
6. <span class="grammar-word grammar-word--7">or</span> <span class="grammar-word grammar-word--4">indeed</span> 用来补充并扩大表达范围
7. 整个句子虽然很长，但主干其实很清楚：

   * The field is not for those...
   * it is the study...
