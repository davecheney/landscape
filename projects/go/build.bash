#!/bin/bash

TAG=$1
source ./env

TAG_DIR=$PROJECT_ROOT/tags/$TAG
source $TAG_DIR/env

function build-number() {
	hg identify $WORKSPACE -n
}

function build-dependents() {
	

export -f build-number
BUILD_DIR=$TAG_DIR/builds/$(build-number)
mkdir -p $BUILD_DIR

exec >$BUILD_DIR/stdout.err \
bash -c '
	cd $WORKSPACE/src 
	exec ./make.bash
'

