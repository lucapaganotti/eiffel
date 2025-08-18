#!/bin/bash

if [ "$1" == "" ]; then
    echo "Missing config file"
    exit
fi

config_file="$1"

echo "Build all $config_file"
compile.sh $config_file
freeze.sh $config_file
finalize.sh $config_file
echo "Done Build all"

