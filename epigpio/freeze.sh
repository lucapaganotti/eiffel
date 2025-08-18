#!/bin/bash

if [ "$1" == "" ]; then
    echo "Missing config file"
    exit
fi

config_file="$1"
pwd=`pwd`

echo "Freeze $config_file"
ec -freeze -verbose -batch -config $config_file".ecf"
cd ./EIFGENs/$config_file/W_code
finish_freezing
cd $pwd
echo "Done Freeze $1"

