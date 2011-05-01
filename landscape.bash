#!/bin/bash

source $(dirname $0)/env

BUILDTASK=$LANDSCAPE_ROOT/build-task
export BUILDTASK

function find-all-roots() {
	find $LANDSCAPE_ROOT/roots -mindepth 1 -maxdepth 1 -type l
}

function find-dependent-tasks() {
	find $(task-root)/dependents -mindepth 1 -maxdepth 1 -type l 
}

function build-dependent-tasks() {
	find-dependent-tasks | xargs -P 2 -n 1 bash $BUILDTASK
}

function build-log-root() {
	echo $(task-root)/builds
}

function stdout() {
	echo $(build-log-root)/$(build-number)/stdout
}

function stderr() {
	echo $(build-log-root)/$(build-number)/stderr
}

function build-task() {
	echo "Building task $1"
	(
		cd $1
		source ./env
		build-cmd 2> stderr > stdout && build-dependent-tasks
	)
}

function build-all() {
	find-all-roots | xargs -P 2 -n 1 bash $BUILDTASK
}

GO=$(basename $0)
$GO $@
