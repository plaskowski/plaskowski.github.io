---
layout: default
title: Piotr Laskowski
---

{% assign essay = site.pages | where: "path", "essays/build-the-harness-or-go-home.md" | first %}
<p class="section-label">Essays</p>

<div class="essay-card">
  <a class="card-link" href="/essays/build-the-harness-or-go-home/" aria-label="{{ essay.title }}"></a>
  <h2>{{ essay.title }}</h2>
  <p class="subtitle">{{ essay.subtitle }}</p>
  <p class="meta">{{ essay.date | date: "%B %-d, %Y" }} &nbsp;·&nbsp; {{ essay.status }}</p>
</div>

{% assign note = site.pages | where: "path", "notes/agentic-coding-pains-catalog.md" | first %}
<p class="section-label" style="margin-top: 2.5rem;">Notes</p>

<div class="essay-card">
  <a class="card-link" href="/notes/agentic-coding-pains-catalog/" aria-label="{{ note.title }}"></a>
  <h2>{{ note.title }}</h2>
  <p class="subtitle">{{ note.description }}</p>
  <p class="meta">{{ note.date | date: "%B %-d, %Y" }} &nbsp;·&nbsp; {{ note.status }}</p>
</div>
