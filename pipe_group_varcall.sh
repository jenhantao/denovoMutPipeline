#! /bin/bash

# Basic pipeline for alingment and variant calling from a single bam containing paired end reads

# Arg1 = project name
# Arg2 = file listing samples to call together

# Initialize environment variables from config file
source config/ngs.conf

# Get filename and filepath from arg1

# Make sure that directory with realigned bams exists
export output_dir=${runs_dir}/$1/grouped
if [ ! -d ${output_dir} ]
then
    mkdir ${output_dir}
fi

export sname=$(echo ${test##*/} | cut -d "." -f 1 -)


# Run Variant Caller
./tasks/varCallHC_group.sh $2

# VSQR - reduce false positives by recalibrating variant error based on hapmap snps
#./tasks/varFilter.sh
./tasks/VQSR.sh
