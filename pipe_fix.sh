#! /bin/bash

# Script to automate fix stale bam file mounts
# This script assumes that you have a list of analysis data uris and have previously mounted the corresponding bams

# Arg1 = project directory 
# Arg2 = path to list of data analysis uris

source config/ngs.conf

mkdir $mnt_dir/$2 2> /dev/null
for file in $(cat $2)
do
    ./tasks/fixMounts.sh $1 $file
done


