---
layout: articles
---


{% for post in site.posts %}
  {{ post.date | date: '%Y %b %d'}} >> [{{ post.title }}]({{site.baseurl}}{{ post.url }})
{% endfor %}