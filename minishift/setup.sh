#!/usr/bin/env bash

set -e
set -x

oc login -u developer -p developer

if ! oc get project myproject; then
    oc new-project myproject
fi
oc project myproject

oc login -u system:admin
if ! oc describe scc privileged | grep "Users.*system:serviceaccount:myproject:default"; then
    oc adm policy add-scc-to-user privileged system:serviceaccount:myproject:default
fi

if ! oc get template manageiq; then
    oc create -f manageiq-pods/templates/miq-template.yaml
fi
