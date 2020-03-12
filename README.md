# MarkPress

A PHP based **Markdown File CMS**.

Markpress is a dynamic Markdown blogging CMS. Like Jekyll but dynamic website instead of a generated website. It is largely configuration based, which means: no admin panel, no installers.

#### Batteries not Included

This is basically the clean repo. Like an empty framework shell, with a few defaults to get most people started. You should just be able to fork the repo. And get started from there.

> There is code that will automatically look for ports and provide a base with the correct ports automatically before the CSS and JS variables. Although you may still have to "configure" correctly the base setting if you want the hrefs to accurate.

### Quick Start

- Define the settings in **settings.yaml**
    - Point to root directory: `root: /`
    - Point to a content directory: `content: posts`
    - Point to a Theme folder: `theme: cleanblog`
    - Set the Markdown Parser: `markdown: mfm`
    - Set the homepage dir/file: `homepage: blog`
        - Make sure that the folder exists if you pick a directory as your homepage.
    - Set the Base Directory: `base: http://localhost/`
- Routing is automatic single directory* **/blog/post** and **/post**
    - Routes to /blog/post.md and /post.md respectively
- Twig Templates, Theme basics
    - Template shown when pointing to a directory: **show_news.tpl**
    - Template shown when pointing to a document: **show_post.tpl**
    - See https://github.com/MarkPress/Themes for examples

Most of the default configurations can be used as-is. Although you might want to change the theme.

Themes can be found at [Here](https://github.com/MarkPress/Themes).

---

# Documentation:

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

## Templates Example:
MarkPress uses the amazing [Twig template engine](https://twig.symfony.com/doc/3.x/)

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