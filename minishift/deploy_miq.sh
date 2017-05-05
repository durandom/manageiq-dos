#!/usr/bin/env bash

set -x

oc login -u developer -p developer
oc process --parameters manageiq

NAME=$1
TAG=latest

oc new-app --template=manageiq \
-p NAME=$NAME \
-p APPLICATION_MEM_REQ=2Gi \
-p DATABASE_PASSWORD=hunter \
-p DATABASE_NAME=vmdb_$NAME \
-p POSTGRESQL_IMG_TAG=postgresql-$TAG \
-p MEMCACHED_IMG_TAG=memcached-$TAG \
-p APPLICATION_IMG_TAG=app-$TAG \
-l deployment=$NAME
