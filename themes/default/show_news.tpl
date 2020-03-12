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
