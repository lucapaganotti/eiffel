#!/bin/bash

if [ "$1" == "" ]; then
    echo "Missing config file"
    exit
fi

config_file="$1"
pwd=`pwd`

echo "Finalize $config_file"
ec -finalize -verbose -batch -config $config_file".ecf"
cd ./EIFGENs/$config_file/F_code
finish_freezing
cd $pwd
echo "Done Finalize $1"

