#! /bin/bash

# Arg 1: project dir
# Arg 2: analysis uid

# Mount bamfile
rm -rf $mnt_dir/$1/$2 2> /dev/null
mkdir $mnt_dir/$1/$2
rm $cache_dir/$2*

fusermount -u $mnt_dir/$1/$2
gtfuse -c $cgkey --inactivity-timeout=2 --cache-dir=$cache_dir -l syslog:standard https://cghub.ucsc.edu/cghub/data/analysis/download/$2 $mnt_dir/$1/$2

