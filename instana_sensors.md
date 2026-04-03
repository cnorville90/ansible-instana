## Install thw Instana agent to the Controller
- curl -o setup_agent.sh https://setup.instana.io/agent && chmod 700 ./setup_agent.sh && sudo ./setup_agent.sh -a X44_1VoFR7G6L0RuCtKTpQ -d X44_1VoFR7G6L0RuCtKTpQ -t dynamic -e ingress-red-saas.instana.io:443  -y -s

## Turn on the Ansible Sensor

com.instana.plugin.action.command:
  enabled: true
com.instana.plugin.action.script:
  enabled: true
  runAs: ec2-user
  scriptExecutionHome: /tmp
com.instana.plugin.action.http:
  enabled: true
com.instana.plugin.action.ansible:
  enabled: true
  url: https://controller.thenorvilles.com
  token: kyObaSEucsq3U9bivHuUsVWldoz0Sc
  connector:
    container_mgmt_engine: podman
    host_port: 9080
    ready_timeout: 300

## Turn on the HTTP Sensor
cd /opt/instana/agent/etc/instana/configuration.yaml

com.instana.plugin.action:
  enabled: true # by default is false

com.instana.plugin.action.http:
  enabled: true # by default is false