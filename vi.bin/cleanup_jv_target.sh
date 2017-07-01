#!/bin/sh

top_dir=${1}
if [ -z ${top_dir} ]
then
  top_dir=`echo ${PWD}`
fi
top_dir=${top_dir%/}

echo "Removing files from $top_dir"

find ${top_dir} -name "target" > /tmp/$$.log
find ${top_dir} -name "target" | xargs rm -rf

echo "List of removed files present in dir=/tmp/$$.log "

