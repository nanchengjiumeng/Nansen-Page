<template>
  <div class="grammar-legend">
    <h3 class="grammar-legend__title">词性颜色图例</h3>
    <div class="grammar-legend__items">
      <span class="grammar-pill grammar-pill--noun">名词性成分</span>
      <span class="grammar-pill grammar-pill--adj">形容词性成分</span>
      <span class="grammar-pill grammar-pill--adv">副词性成分</span>
    </div>

    <h4 class="grammar-legend__subtitle">词性编号</h4>
    <ul class="grammar-legend__list">
      <li><span class="grammar-pill grammar-word--1">1 = 名词 Noun</span></li>
      <li><span class="grammar-pill grammar-word--2">2 = 动词 Verb</span></li>
      <li><span class="grammar-pill grammar-word--3">3 = 形容词 Adjective</span></li>
      <li><span class="grammar-pill grammar-word--4">4 = 副词 Adverb</span></li>
      <li><span class="grammar-pill grammar-word--5">5 = 代词 Pronoun</span></li>
      <li><span class="grammar-pill grammar-word--6">6 = 介词 Preposition</span></li>
      <li><span class="grammar-pill grammar-word--7">7 = 连词 Conjunction</span></li>
      <li><span class="grammar-pill grammar-word--8">8 = 感叹词 Interjection</span></li>
      <li><span class="grammar-pill grammar-word--9">9 = 冠词 Article</span></li>
      <li><span class="grammar-pill grammar-word--10">10 = 数词 Numeral</span></li>
      <li><span class="grammar-pill grammar-word--11">11 = 限定词 Determiner</span></li>
    </ul>
  </div>
</template>

<style scoped>
.grammar-legend {
  margin: 0;
}

.grammar-legend__subtitle {
  font-size: 0.8125rem;
  font-weight: 600;
  color: var(--vp-c-text-1);
  margin: 1rem 0 0.5rem 0;
}

.grammar-legend__list {
  list-style: none;
  padding: 0;
  margin: 0;
}

.grammar-legend__list li {
  margin: 0.375rem 0;
  font-size: 0.8125rem;
}
</style>
