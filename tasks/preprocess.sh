#! /bin/bash

# Arg 1: name of directory with bam files

# Example: ./preprocess.sh CESC_test

#TCGA data
cd $data_dir
find $1 -name *.bam > $data_dir/$1.list