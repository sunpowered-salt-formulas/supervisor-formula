{% from "supervisor/map.jinja" import supervisor with context %}

install_supervisor:
  pkg.installed:
    - name: {{ supervisor.package }}

supervisor_service:
  service.running:
    - name: supervisor
    - require:
      - pkg: install_supervisor


/etc/supervisor/conf.d/{{ supervisor.get('name', 'processes') }}.conf:
  file.managed:
    - source: salt://supervisor/templates/processes.jinja
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - watch_in:
      - service: supervisor_service

