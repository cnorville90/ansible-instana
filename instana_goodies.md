## Spin up a SNO Cluster in RHPDS
- Login as admin to the console 
- Login as admin to the cli
  - run basic commands - oc get nodes, oc get pods, etc

## INstall Helm if needed
$ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
$ chmod 700 get_helm.sh
$ ./get_helm.sh

## Deploy Robot-shop
- git clone https://github.com/instana/robot-shop.git
- export KUBECONFIG=/home/lab-user/.kube/config
- oc adm new-project robot-shop
- oc adm policy add-scc-to-user anyuid -z default -n robot-shop
- oc adm policy add-scc-to-user privileged -z default -n robot-shop
- cd robot-shop/K8s
- helm install robot-shop --set openshift=true -n robot-shop helm

## Expose the robot-shop service
- OCP -> Networking -> Routes -> Create Route
- name: robot-shop-web
- service: web
- target port 8080
- Set secure route with edge termination and redirect 
- Test out the route - should land on RobotShop

## Deploy memory-leak-simulator
- git clone https://github.com/shankar-sundar/memory-leak-simulator.git
- cd memory-leak-simulator-app
- export OCP_API_URL (oc cluster-info)
- export OCP_TOKEN (oc whoami -t)
- ./setup-app.sh $OCP_API_URL $OCP_TOKEN
- Test out the app -> curl $(oc get route memory-leak-simulator -o=jsonpath='{.spec.host}')/getMemoryDetails
- Start rge memory leak and crash pod -> curl $(oc get route memory-leak-simulator -o=jsonpath='{.spec.host}')/startMemoryLeak

## Install the Quote of the Day Application
- https://gitlab.com/quote-of-the-day/quote-of-the-day
- helm repo add qotd https://gitlab.com/api/v4/projects/26143345/packages/helm/stable
- helm repo update
- oc new-project qotdb3U6y6PuG6IX
- oc adm policy add-scc-to-user anyuid -z default
- oc new-project qotd-load
- oc adm policy add-scc-to-user anyuid -z default
- helm install qotd-chart qotd/qotd \
    --set enableInstana=true \
    --set host=apps.cluster-5vlh6.dynamic.redhatworkshops.io
- Set Route TLS Edge Termination / Redirect on both routes

## INstall PAcman
- git clone https://github.com/dav1x/pacman-ocp/
- cd pacman-ocp
- oc create -f .
- oc get route -n pacman
- Monitoring issue: nodejs_collector_not_installed



## Install the INstana agent to the bastion host & Controller / EDA 
- curl -o setup_agent.sh https://setup.instana.io/agent && chmod 700 ./setup_agent.sh && sudo ./setup_agent.sh -a X44_1VoFR7G6L0RuCtKTpQ -d X44_1VoFR7G6L0RuCtKTpQ -t dynamic -e ingress-red-saas.instana.io:443  -y -s

## Install the INstana Agent on the OCP Cluster using Helm
[lab-user@bastion ~]$ helm install instana-agent \
    --repo https://agents.instana.io/helm \
    --namespace instana-agent \
    --create-namespace \
    --set openshift=true \
    --set agent.key=X44_1VoFR7G6L0RuCtKTpQ \
    --set agent.downloadKey=X44_1VoFR7G6L0RuCtKTpQ \
    --set agent.endpointHost=ingress-red-saas.instana.io \
    --set agent.endpointPort=443 \
    --set zone.name='norville-ocp' \
    --set cluster.name='red-hat-ocp-norville' \
    instana-agent

## Add Ansible Automation

## Force an event

## Add Application Perspectives
- Robot Shop
- Quote of the Day
- Memory Leak Simulator
- 

## User Cases
- Robot Shop
  - Container Removed
  - LoadGen
- Quote of the Day
  - Something
- Memory Leak Simulator
  - Memory Leak to Crash
- Bastion Host Agent
  - High CPU
- Controller Node Agent
  - Website up/down# ansible-instana
