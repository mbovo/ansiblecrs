[Unit]
Description={{ service.description }}
After={{ service.after }}

[Service]
{% if service.type in ['notify','forking'] %}
Type={{ service.type }}
{% endif %}
{% if 'environmentFile' in service %}
EnvironmentFile={{ service.environmentFile }}
{% endif %}
{% if 'startPre' in service.commands %}
ExecStartPre= {{ service.commands.startPre }}
{% endif %}
{% if 'start' in service.commands %}
ExecStart={{ service.commands.start }}
{% endif %}
{% if 'reload' in service.commands %}
ExecReload={{ service.commands.reload }}
{% endif %}
{% if 'stop' in service.commands %}
ExecStop={{ service.commands.stop }}
{% endif %}
{% if 'KillSignal' in service %}
KillSignal={{ service.KillSignal }}
{% endif %}
{% if 'PIDFile' in service %}
PIDFile={{ service.PIDFile }}
{% endif %}
{% if 'user' in service %}
User={{ service.user }}
{% endif %}
{% if 'group' in service %}
Group={{ service.group }}
{% endif %}
PrivateTmp=true

[Install]
WantedBy=multi-user.target