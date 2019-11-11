#!/bin/bash

current_folder=`pwd`
f_code_folder=$HOME/dev/eiffel/collect/EIFGENs/collect/F_code

echo `date "+%Y-%m-%d %H:%M:%S"`" finalize system"
ec -verbose -finalize -config ./collect.ecf
echo `date "+%Y-%m-%d %H:%M:%S"`" finish freezing"
cd $f_code_folder
finish_freezing
echo `date "+%Y-%m-%d %H:%M:%S"`" strip exectable"
strip -s collect
echo `date "+%Y-%m-%d %H:%M:%S"`" rename executable to remwsgwyd"
mv collect remwsgwyd
cd $current_folder

