# MarkPress

An easy to use **Markdown File CMS**.

# Quick Documentation:

## Quick How to:

### Install:
- Copy the Files into **public_html**


### Gotcha's:
- All themes are stored in **themes**
- There is no Admin Panel
    - manage your content using MarkDown Files
- All the content is stored in **posts** by default
    - Use subfolders for blog type posts (/blog/post)
    - Use the main folder for pages
    - Folder Structure:
        - /file
            - posts/file.md
        - /blog
            - posts/blog/
        - /blog/one
            - posts/blog/one.md

## Basic Usage:

A page or Post uses [Yaml FrontMatter](https://github.com/Modularr/YAML-FrontMatter). The date will be used to sort posts in archive pages.

### Yaml Frontmatter Post/Page:

    ---
    title: Hello World!
    route: hello-world
    date: 2015-09-15 09:10:00
    ---
    # Hello World!
    
    ## Lorem Ipsum
    
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.

## The Power of Templates:
We make use of the amazing Twig template engine. Which makes it easy for designers to build cool designs as easy as possible with MarkPress.

### themes/{theme_name}/show_news.tpl:

    {% extends "themes/default/base.tpl" %}
    {% block title %}Archive{% endblock %}
    {% block content %}
    <table>
        <tr>
            <td><strong>Post</strong></td>
            <td><strong>Date</strong></td>
        </tr>
        {% for post in posts %}
            <tr>
                <td><a href="{{ post.route }}">{{ post.title }}</a></td>
                <td>{{ post.date|date(null, "Europe/Brussels") }}</td>
            </tr>
        {% endfor %}
    </table>
    {% endblock %}

### themes/{theme_name}/show_post.tpl:

    {% extends "themes/default/base.tpl" %}
    {% block title %}{{ title }}{% endblock %}
    {% block content %}
    <h1>{{ title }}</h1>
    {{ content }}
    {% endblock %}

### themes/{theme_name}/base.tpl
    <!DOCTYPE html>
    <html>
    <head>
    {% block head %}
        <title>{% block title %}{% endblock %}</title>
            <link rel="stylesheet" href="style.css" />
    {% endblock %}
    </head>
    <body>
        <div id="content">{% block content %}{% endblock %}</div>
        <div id="footer">
            {% block footer %}{% endblock %}
        </div>
    </body>
    </html>