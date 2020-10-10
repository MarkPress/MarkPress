{% extends "themes/wikitten/base.tpl" %}
{% block title %}{{ title }}{% endblock %}
{% block content %}
{% include 'themes/wikitten/infobox.tpl' %}
{{ content }}
{% endblock %}
