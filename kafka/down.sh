#!/usr/bin/env bash

oc login -u developer -p developer
oc delete all -l app=apache-kafka

