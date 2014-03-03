#! /bin/bash

# Arg 1: project dir
# Arg 2: analysis id 

# Probably should make cghub url a variable

# Mount bamfile
rm -rf $data_dir/$1/$2 2> /dev/null
mkdir $data_dir/$1/$2 2> /dev/null
rm $cache_dir/$2* > /dev/null

gtfuse -c $cgkey --inactivity-timeout=2 --cache-dir=$cache_dir -l syslog:standard https://cghub.ucsc.edu/cghub/data/analysis/download/$2 $data_dir/$1/$2

#echo "gtfuse -c $cgkey --inactivity-timeout=2 --cache-dir=$cache_dir -l syslog:standard https://cghub.ucsc.edu/cghub/data/analysis/download/$2 $mnt_dir/$1/$2"



