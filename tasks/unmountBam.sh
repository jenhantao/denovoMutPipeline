#! /bin/bash

# Arg 1: project dir
# Arg 2: analysis uid

# Mount bamfile

fusermount -u $data_dir/$1/$2

rm $cache_dir/$2*
rm -rf $data_dir/$1/$2
