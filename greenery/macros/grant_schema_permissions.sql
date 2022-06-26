{% macro grant(role) %}

    {% set sql %}
      GRANT USAGE ON SCHEMA {{ schema }} TO {{ role }};
      GRANT SELECT ON {{ this }} TO ROLE {{ role }};
    {% endset %}

    {% set table = run_query(sql) %}

{% endmacro %}