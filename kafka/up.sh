#!/usr/bin/env bash

set -x
set -e

oc login -u developer -p developer -n myproject
if ! oc get template apache-kafka; then
  oc create -f https://raw.githubusercontent.com/durandom/openshift-kafka/master/resources.yaml
fi
oc new-app --template apache-kafka
