#!/bin/bash

BASE_DIR=`dirname $0`

echo ""
echo "Starting Karma Server (http://vojtajina.github.com/testacular)"
echo "-------------------------------------------------------------------"

karma start $BASE_DIR/../spec/webapp/config/testacular.conf.js $*
