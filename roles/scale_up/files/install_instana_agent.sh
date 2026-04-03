#! /bin/bash

rm -fr /var/lib/.rpm.lock
curl -o setup_agent.sh https://setup.instana.io/agent && chmod 700 ./setup_agent.sh && sudo ./setup_agent.sh -a 5fkVYVSVS8O7S9wWgAtUgQ -d 5fkVYVSVS8O7S9wWgAtUgQ -t dynamic -e ingress-coral-saas.instana.io:443  -y -s