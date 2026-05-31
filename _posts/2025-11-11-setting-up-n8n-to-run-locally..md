---
layout: post
title: Setting up n8n to run locally.
date: 2025-11-11
flashcards:

labels:
- name: n8n
  color: green_light

---
## Introduction

**n8n** is an open-source automation tool that allows you to connect different applications, APIs, and services to create automated workflows. These workflows can be triggered by various events such as receiving an email, a webhook, or a scheduled time (cron job), enabling seamless data processing and integration across platforms like GitHub, Slack, and Google Sheets. n8n provides a visual interface for building complex automation while also allowing custom scripting in JavaScript (and integrations with Python), giving users full control and flexibility—though it may require more time to build and maintain compared to fully managed automation tools.

## Installation

**n8n** can be configured to run in three different ways:

1. **Using npx**
   Run n8n directly without installing it permanently.
   ```bash
   npx n8n
   ```
2. **Using npm (global installation)**
   Install n8n globally on your system so it can be run from anywhere.
   ```shell
   npm install -g n8n
   n8n
   ```
3. **Using Docker (recommended and discussed further)**

##
