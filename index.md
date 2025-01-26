---
layout: default
title: SumitPati7
flashcards: 
  - question: Academic Qualification?
    answer: Bachelor in CSIT
            
  - question: What is your name?
    answer: My name is **Sumit Pati**.
            
  - question: Question
    answer: Answer
            
  - question: What is your current ruby version?
    answer: 3\.3.4
            
---
# Hello There, I am Sumit Pati.

#### Diligent | Adaptable | Curious
Enthusiastic student majoring in Computer Science and Information Technology. Passionate about coding, problem-solving, and staying up-to-date with industry trends. During my studies, I collaborated on several group projects, honing my teamwork and communication skills. Eager to contribute my knowledge and learn from experienced professionals, I am committed to making a positive impact in the field.

My coursework has equipped me with a solid foundation in Data Structures and Algorithm, Database, Web Design, etc and I'm actively seeking opportunities to gain real-world experience in this field.

### Here are some of my posts till date 

{% for post in site.posts limit: 5 %}
  * {{ post.date | date: '%Y %b %d'}} >> [{{ post.title }}]({{site.baseurl}}{{ post.url }})
{% endfor %}

{% include flashcard.html %}
      