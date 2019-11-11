#!/bin/bash

system="test_awc"
work_dir="/home/buck/dev/eiffel/$system"
f_code_dir="$work_dir/EIFGENs/$system/F_code"
PWD=`pwd`

cd work_dir
echo `date "+%Y-%m-%d %H:%M:%S"`" Finalize system ..."
echo `date "+%Y-%m-%d %H:%M:%S"`" Remove EIFGENs."
rm -fr ./EIFGENS
echo `date "+%Y-%m-%d %H:%M:%S"`" Build system."
ec -finalize -verbose -config $system.ecf
cd $f_code_dir
finish_freezing
echo `date "+%Y-%m-%d %H:%M:%S"`" Strip system."
cd $f_code_dir
strip -s $system
cd $PWD
echo `date "+%Y-%m-%d %H:%M:%S"`" Done."

