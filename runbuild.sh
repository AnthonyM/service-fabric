#!/bin/bash
set -x
# get the current directory
CDIR=/home/anmccan/jenkins/data/workspace/linux_build
DOCKER_VERSION=`cat DOCKER_VERSION`

OUT_DIR=$CDIR/out

mkdir -p "$OUT_DIR"

BUILD_PARAMS=""
while (( "$#" )); do
    if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
        cat <<EOF
Usage:
runbuild.sh [build arguments] [-h]
    -h, --help: Displays this help text

This script starts a container then calls src/build.sh within it. It 
accepts all build.sh arguments except -d. See below for the arguments
to build.sh.
EOF
        $CDIR/src/build.sh -h
        exit -1
    else
        BUILD_PARAMS="$BUILD_PARAMS $1"
    fi
    shift
done

docker run \
    --rm \
    --net=host \
    --cap-add=NET_ADMIN \
    -i \
    -v "$OUT_DIR":/out \
    -v "$CDIR"/deps:/deps \
    -v "$CDIR"/src:/src \
    -e "BUILD_PARAMS=$BUILD_PARAMS" \
    microsoft/service-fabric-build-ubuntu:$DOCKER_VERSION \
    bash -c 'ls && pwd && ls /src && echo $BUILD_PARAMS && cd /out/ && /src/build.sh -all -d $BUILD_PARAMS'
