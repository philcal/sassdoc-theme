<div class="sidebar__header">
  <h1 class="sidebar__title">
      {{ view.packageName }} - {{ view.packageVersion }}
  </h1>
</div>

<div class="sidebar__body">
  {# No item documented #}
  {% if data.count == 0 %}
    <p class="sidebar__item  sidebar__item--heading">No documented item.</p>

  {# Some items documented #}
  {% else %}
    <button type="button" class="btn-toggle  js-btn-toggle" data-alt="Open all">Close all</button>

    {# Loop over the groups #}
    {% for group_name, group in data.byGroupAndType %}
      <p class="sidebar__item  sidebar__item--heading" data-slug="{{ group_name }}"><a href="#{{ group_name }}">{{ groups[group_name] }}</a></p>

      {# Loop over the types #}
      {% for type, items_from_type in group %}
        {% if loop.first %}<div>{% endif %}

        {# Filter items that should not be displayed #}
        {% set items_to_display = (items_from_type | groupby('display'))['true'] %}

        {# If items to be displayed in type #}
        {% if items_to_display.length > 0 %}
          <p class="sidebar__item  sidebar__item--sub-heading" data-slug="{{ group_name + '-' + type }}"><a href="#{{ group_name }}-{{ type }}">{{ (type + 's') }}</a></p>

          {# Loop over the items #}
          {% for item in items_to_display %}
            {% if loop.first %}<ul class="list-unstyled">{% endif %}
            <li class="sidebar__item  sassdoc__item" data-name="{{ item.context.name }}" data-type="{{ item.context.type }}">
              <a href="#{{ item.context.type }}-{{ item.context.name }}">{{ item.context.name }}
              {% if item.access[0] == "private" %}<span class="sidebar__annotation  sidebar__annotation--private">private</span>{% endif %}
              {% if item.alias != false %}<span class="sidebar__annotation  sidebar__annotation--alias">alias</span>{% endif %}
              </a>
            </li>
            {% if loop.last %}</ul>{% endif %}
          {% endfor %}
        {% endif %}
        {% if loop.last %}</div>{% endif %}
      {% endfor %}

    {% endfor %}
  {% endif %}
</div>
