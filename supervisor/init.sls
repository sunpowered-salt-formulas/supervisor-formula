{% from supervisor/map.jinja import supervisor with context %}
python-pip:
  pkg:
    - installed
    - name: {{ supervisor.pip }}
