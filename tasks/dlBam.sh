#! /bin/bash

# Arg 1: project dir
# Arg 2: analysis id 

# Probably should make cghub url a variable

# Download bamfile

gtdownload -c $cgkey -d https://cghub.ucsc.edu/cghub/data/analysis/download/$2 -p ${data_dir}/$1/



