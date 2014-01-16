#! /bin/bash

# Script to automate mounting of bam files 
# This script assumes that you have a list of analysis data uris
# To generate a list of analysis data uri's
#   1) Query cghub to get xml files for samples
#   2) Run getDataUri.sh on the list of xml files to retrieve the analysis data uri for each file

# Arg1 = project directory 
# Arg2 = path to list of data analysis uris

source config/ngs.conf

mkdir $mnt_dir/$2 2> /dev/null
for file in $(cat $2)
do
    ./tasks/mountBam.sh $1 $file
done


