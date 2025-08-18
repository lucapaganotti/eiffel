#!/bin/bash

if [ "$1" == "" ]; then
    echo "Missing config file"
    exit
fi

config_file="$1"

echo "Melt $config_file"
ec -full -verbose -batch -config $config_file".ecf"
echo "Done Compile $1"

