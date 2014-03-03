#! /bin/bash

# Arg 1: project dir
# Arg 2: analysis uid list

# Mount bamfile

for name in $(cat $2)
do
    export UUID=$(echo ${name##*/})
    fusermount -u $data_dir/$1/$UUID
done
