#!/bin/bash
​
RELEASE=newjitsu
NAMESPACE=jitsu
​
source ./.env
export HOST_URL="warehouse2.trendstyle.com.au"
export STORAGE_CLASS="mayastor-3"
envsubst "$(env | cut -d= -f1 | sed -e 's/^/$/')" < chart/jitsu/values.yaml > chart/jitsu/values-with-secrets.yaml
​
microk8s helm upgrade --cleanup-on-fail \
  --install $RELEASE ./chart/jitsu \
  --namespace $NAMESPACE \
  --create-namespace \
  --values ./chart/jitsu/values-with-secrets.yaml
​
rm ./chart/jitsu/values-with-secrets.yaml