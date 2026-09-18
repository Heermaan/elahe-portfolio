---
layout: default
title: About
---
<section class="page page--narrow about">
  <header class="page__head"><h1>About</h1></header>
  {%- assign portrait = site.static_files | where: "path", "/assets/portrait.jpg" -%}
  {%- if portrait.size > 0 -%}
  <img class="about__portrait" src="{{ '/assets/portrait.jpg' | relative_url }}" alt="{{ site.title }}">
  {%- endif -%}
<div class="about__text" markdown="1">

I'm Elahe, a digital artist with over ten years of experience in motion graphics, animation, character design, illustration and storyboarding.

*(Replace this text with your own bio. Keep it to two or three short paragraphs. To add a photo, save it as `assets/portrait.jpg`.)*

**Get in touch**
Email: [{{ site.email }}](mailto:{{ site.email }})
{% if site.linkedin != "" %}LinkedIn: [{{ site.linkedin }}]({{ site.linkedin }}){% endif %}

</div>
</section>
