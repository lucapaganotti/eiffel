#!/bin/bash

#
# create a tar gz file of msg library
# accepts these parameters
#   1. file name in the current path
#   

GZIP=/bin/gzip
RM=/bin/rm
TAR=/bin/tar
TEXT=tar
GEXT=gz
WC=/usr/bin/wc
ITEMSNUM="4"

if [ "$1" == "" ]; then
  echo "You must provide a file name"
  echo "Usage: createtargz.sh <filename>"
  echo "  filename with no extension"
  exit
fi

TARFN=$1.$TEXT
TGZFN=$TARFN.$GEXT

if [ -f "$TARFN" ]; then
  $RM -f ./$TARFN
  echo "./$TARFN removed."
fi

if [ -f "$TGZFN" ]; then
  $RM -f ./$TGZFN
  echo "./$TGZFN removed."
fi

clear
$TAR -cvf $TARFN ./*.e*
$TAR rvf $TARFN ./collect.rc

if [ -f "$TARFN" ]; then
  $GZIP -v1 $TARFN
else
  echo "ERROR: unable to find $TARFN."
  exit
fi

ITEMS=`tar tf $TGZFN | $WC -l`

if [ ! "$ITEMS" == "$ITEMSNUM" ]; then
  echo "ERROR: Check $TGZFN, some item(s) may be missing."
  exit
fi

echo "Done: $TGZFN created."

