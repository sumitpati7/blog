---
layout: post
title: Web Scraping using scrapy
date: 2025-08-05
flashcards: 
---

## Prerequisites :

- Install Python, pip, and scrapy.

## Project Initialization

To create a project using Scrapy, you can run the following command in your terminal.

```shell
scrapy startproject project_name
```

Here, You can set the project name to your liking.

This will create a directory structure in your current directory with the same name as your `project_name`. This will also create a directory structure within your directory. with the folder structure as:

```
project_name/
    scrapy.cfg            # deploy configuration file

    project_name/             # project's Python module, you'll import your code from here
        __init__.py

        items.py          # project items definition file

        middlewares.py    # project middlewares file

        pipelines.py      # project pipelines file

        settings.py       # project settings file

        spiders/          # a directory where you'll later put your spiders
            __init__.py
```

## Creating a Spider

Inside the spiders folder, we create our spider. `Spider` are the classes that crawls our website to gather the information from our website. Any spider we create must subclass the `Spider` and define the initial request.
To create a spider, we create a file with `spider_name.py` inside the `project_name/spiders` folder with the code:

```python
from pathlib import Path

import scrapy

class ProductsSpider(scrapy.Spider):
    name = "products"

    async def start(self):
        url = "https://site.tovisit.com"

        yield scrapy.Request(url = url, callback = self.parse, headers = headers)

    def parse(self, response):
        page = response.url.split("/")[-2]
        filename = f"products-{page}.html"
        Path(filename).write_bytes(response.body)
        self.log(f"Saved file {filename}")
```

Save this file and run `scrapy crawl products` in your terminal and observe.

If you observe the output you will see various requests made by the scrapy. Now, if you check the root directory of the project you will see that the page that the html file of the page that you wanted to visit have been written as `products-1.html`.
When we run the program, the `start()` method is called. This is the entry point of our program. Then the `scrapy.Request` is yielded by the `start()` method and the callback method, `parse()`in this case is called. The `parse()` method is Scrapy’s default callback method.

## References

- [https://docs.scrapy.org/en/latest/intro/tutorial.html#storing-the-scraped-data](https://docs.scrapy.org/en/latest/intro/tutorial.html#storing-the-scraped-data "smartCard-inline")
        