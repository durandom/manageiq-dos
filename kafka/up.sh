#!/usr/bin/env bash

set -x
set -e

oc login -u developer -p developer -n myproject
if ! oc get template apache-kafka; then
  oc create -f https://raw.githubusercontent.com/durandom/openshift-kafka/master/resources.yaml
fi
oc new-app --template apache-kafka
oc rollout status -w dc/apache-kafka
oc expose dc apache-kafka --type=LoadBalancer --name=apache-kafka-ingress
oc export svc apache-kafka-ingress

echo "use nodePort to connect locally to service, e.g. kafkacat -b $(minishift ip):<nodePort> -L"
