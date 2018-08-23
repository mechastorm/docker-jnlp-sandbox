#!/bin/bash

# Verify labels - docker image inspect jenkins-master-base | jq -r '.[0].Config.Labels'

DO_DOCKER_LOGIN="1"
VERBOSE="0"
DRY_RUN="0"
TAG=""
NAMESPACE=""

while true; do
  case "$1" in
    -v | --verbose ) VERBOSE="1"; shift ;;
    -n | --dry-run ) DRY_RUN="1"; shift ;;
    --skip-login ) DO_DOCKER_LOGIN="0"; shift ;;
    -r | --registry ) REGISTRY="$2"; shift; shift ;;
    -n | --namespace ) NAMESPACE="$2"; shift; shift ;;
    -t | --tag ) TAG="$2"; shift; shift ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

# If tag is empty, set it to latest
if [ -z "$TAG" ];
then
    TAG=":latest"
else
    TAG=":"$TAG
fi

# If namespace is not empty, set it to latest
if [ -z "$NAMESPACE" ];
then
    NAMESPACE=""
else
    NAMESPACE="/"$NAMESPACE"/"
fi

DATE_TIME=`date '+%Y%m%d%H%M%S'`
COMMIT_ID=$(git rev-parse HEAD)

if [ "$VERBOSE" -eq "1" ]; then
    echo VERBOSE=$VERBOSE
    echo DO_DOCKER_LOGIN=$DO_DOCKER_LOGIN
    echo REGISTRY=$REGISTRY
    echo NAMESPACE=$NAMESPACE
    echo TAG=$TAG
    echo DATE_TIME=$DATE_TIME
    echo COMMIT_ID=$COMMIT_ID
fi

# docker registry login
if [ "$DO_DOCKER_LOGIN" -eq "1" ];
then
   docker login $REGISTRY
fi

DOCKER_REGISTRY_URL=$REGISTRY DOCKER_REGISTRY_NAMESPACE=$NAMESPACE IMAGE_TAG=:latest TIMESTAMP=$DATE_TIME COMMIT_ID=$COMMIT_ID docker-compose build

DOCKER_REGISTRY_URL=$REGISTRY DOCKER_REGISTRY_NAMESPACE=$NAMESPACE IMAGE_TAG=:latest TIMESTAMP=$DATE_TIME COMMIT_ID=$COMMIT_ID docker-compose push jnlp-slave-sandbox