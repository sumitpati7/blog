---
layout: post
title: Console syntax to run a command multiple times
date: 2025-03-27
flashcards:

labels:
- name: Linux
  color: purple

---
Sometimes, when you are working on some projects, there may arise a situation where you have to run a specific command for a number of times. The command below comes in handy on these conditions. Here, you can run the specific command for a number of times as per your requirement.

```
for i in `seq <<no.of times>>`; do bundle exec <<your command here>>; done
```
