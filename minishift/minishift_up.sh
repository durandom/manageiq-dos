#!/usr/bin/env bash

set -x
set -e

minishift delete

minishift addons install --force minishift-addons/manageiq-app
minishift addons install --force minishift-addons/manageiq-infra
minishift addons enable --priority 10 manageiq-infra
minishift addons enable --priority 20 manageiq-app

minishift config set memory 8192
minishift config set cpus 4
minishift config set show-libmachine-logs true

minishift start

minishift openshift config set --target master --patch '{"imagePolicyConfig": {"maxImagesBulkImportedPerRepository": 100}}'


