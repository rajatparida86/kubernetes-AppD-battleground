#!/bin/bash
KUBE_TOKEN=$(</var/run/secrets/kubernetes.io/serviceaccount/token)
echo $KUBE_TOKEN
APPDYNAMICS_AGENT_UNIQUE_HOST_ID=$(curl -sS --cacert /var/run/secrets/kubernetes.io/serviceaccount/ca.crt  -H "Authorization: Bearer $KUBE_TOKEN"       https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_PORT_443_TCP_PORT/api/v1/namespaces/default/pods/$HOSTNAME | grep nodeName | awk -F\" '{print $4}')
echo "Unique Host ID should be: $APPDYNAMICS_AGENT_UNIQUE_HOST_ID"
echo "Hostname is $HOSTNAME"
APPD_NODE_NAME=${HOSTNAME}
cd /application
source venv/bin/activate
pip install flask
pip install -U appdynamics==4.2.11.0
pip install redis
export APPDYNAMICS_AGENT_UNIQUE_HOST_ID
export APPD_NODE_NAME
sed -i' ' '218s/$/\
cmdLine[${#cmdLine[@]}]="-Dappdynamics.agent.uniqueHostId=/' venv/lib/python2.7/site-packages/appdynamics_bindeps/proxy/runProxy
sed -i' ' "219s/$/${APPDYNAMICS_AGENT_UNIQUE_HOST_ID}\"/" venv/lib/python2.7/site-packages/appdynamics_bindeps/proxy/runProxy
pyagent run -c appdynamics.cfg -- python app.py
#pyagent proxy start -c appdynamics.cfg -- -Dappdynamics.agent.uniqueHostId=$APPDYNAMICS_AGENT_UNIQUE_HOST_ID
