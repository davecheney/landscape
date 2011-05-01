#!/bin/bash

source ./env
source $1/env

(cd $WORKSPACE/src && ./make.bash)

