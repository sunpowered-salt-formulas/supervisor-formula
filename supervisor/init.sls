{% from "supervisor/map.jinja" import supervisor with context %}

install_supervisor:
  pkg.installed:
    - name: {{ supervisor.package }}

run_service:
  service.running:
    - name: supervisor
    - require:
      - pkg: install_supervisor

{#/var/log/supervisor: #}
{#  file.directory:#}
{#    - user: root#}
{#    - group: root#}
{#    - mode: 755#}
{#    - file_mode: 644#}
{#    - makedirs: True#}

/etc/supervisor/conf.d/{{ supervisor.get('name', 'processes') }}.conf:
  file.managed:
    - source: salt://supervisor/templates/processes.jinja
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - watch_in:
      - service: run_service

{#/etc/init/supervisor.conf:#}
{#  file.managed:#}
{#    - source: salt://supervisor/templates/supervisord_init.jinja#}
{#    - user: root#}
{#    - group: root#}
{#    - mode: 644#}
{#    - template: jinja#}

{#/etc/supervisor/supervisor.conf:#}
{#  file.managed:#}
{#    - source: salt://supervisor/templates/config.jinja#}
{#    - user: root#}
{#    - group: root#}
{#    - mode: 644#}
{#    - template: jinja#}

{#supervisor_service: #}
{#  service.running: #}
{#    - name: supervisor#}
{#    - enable: True#}
{#    - reload: True#}
{#    - watch: #}
{#      - file: /etc/supervisor/supervisor.conf#}
