<style>
.row {
     padding: 5px !important;
}
</style>
{% if infobox %}
<div style="margin: 10px; float: right; clear: right; border: 1px solid #a2a9b1; padding: 0.2em;">
    <table class="infobox" style="width:20.5em; border-spacing: 2px 5px;">
        <tbody>
            {% if infobox.header %}
            <tr>
                <th colspan="2" style="text-align:center;font-size:125%; font-weight:bold;background: Black; color: white;">
                    {{ infobox.header }}
                </th>
            </tr>
            {% endif %}
            {% if infobox.subheader %}
            <tr>
                <td colspan="2" style="text-align:center; padding: 5px;"><i>
                    {{ infobox.subheader }}
                </td>
            </tr>
            {% endif %}
            {% if infobox.image %}
            <tr>
                <td colspan="2" style="text-align:center">
                    <img alt="{{ infobox.image.alt }}" src="{{ infobox.image.href }}" decoding="async">
                    <div>
                    {% if infobox.image_header %}
                    {{ infobox.image_header }}
                    {% endif %}
                    </div>
                </td>
            </tr>
            {% endif %}
            {% if infobox.table %}
                {% for row in infobox.table %}
                    {% if row.type == "header" %}
                        <tr>
                            <th colspan="2" style="text-align:center;background: Black; color: white ;">In-universe information</th>
                        </tr>
                    {% else %}
                        <tr>
                            {% if row.header %}
                            <th class="row" scope="row" valign="top">{{ row.header }}</th>
                            {% endif %}
                            <td>
                                {% if not row.content.list %}
                                    {{ row.content }}
                                {% else %}
                                    <div class="plainlist">
                                        <ul style="text-align: left; padding: 0; margin: 0; list-style-type: none;">
                                        {% for entry in row.content.list %}
                                            <li>{{ entry }}</li>
                                        {% endfor %}
                                        </ul>
                                    </div>
                                {% endif %}
                            </td>
                        </tr>
                    {% endif %}
                {% endfor %}
            {% endif %}
        </tbody>
    </table>
</div>
{% endif %}
