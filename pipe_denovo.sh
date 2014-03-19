#! bin/bash

# Basic pipeline for alignment to genome starting from a single bam containing paired end reads

# Arg1 = normal bam uuid
# Arg2 = tumor bam uuid
# Arg3 = project (Name of directory in ~/mnt where files are mounted)
# Arg4 = short name - for naming files if the bamfilename is long (optional) aka sample name
# Arg5 = normal sample type 1 NB or NT
# Arg6 = tumor sample type 2 NT or TP

# Initialize environment variables from config file
source config/ngs.conf

# Check to make sure data dir exists
if [ ! -d ${data_dir} ]
then
    mkdir ${data_dir}
fi

# Check to make sure project dir exists within data dir
if [ ! -d ${data_dir}/$3 ]
then
    mkdir ${data_dir}/$3
fi

# Make workspace directory to store tmp files
if [ ! -d ${tmp_dir} ]
then
    mkdir ${tmp_dir}
fi

# Make project output directory
if [ ! -d ${final_dir}/$3 ]
then
    mkdir ${final_dir}/$3
fi

# Make sample output directory
if [ ! -d ${final_dir}/$3/$4 ]
then
    mkdir ${final_dir}/$3/$
fi

# Get filename and filepath from arg1 and arg2
export bamfile1=$(echo ${1##*/})
export bampath1=$1
export bamfile2=$(echo ${2##*/})
export bampath2=$1
export subjectID=$4

# Create directory for storing output - FixMe: should probably include date
if [ ! -d ${runs_dir} ]
then
    mkdir ${runs_dir}
fi

mkdir ${runs_dir}/$3 2> /dev/null
mkdir ${runs_dir}/$3/$4 2> /dev/null
export output_dir=${runs_dir}/$3/$4

# Download bamfiles
./tasks/dlBam.sh $3 $(echo ${1##*/})
./tasks/dlBam.sh $3 $(echo ${2##*/})

#export bamfilename1=$(find ${data_dir}/$3/$(echo ${1##*/}) -name "*.bam") 
#export bamfilename2=$(find ${data_dir}/$3/$(echo ${2##*/}) -name "*.bam") 

export normalFile=$(find ${data_dir}/$3/$(echo ${1##*/}) -name "*.bam") 
export tumorFile=$(find ${data_dir}/$3/$(echo ${2##*/}) -name "*.bam") 
echo $normalFile
echo $tumorFile

# Run Mutect
./tasks/mutect_direct.sh

# Write to cellar
mv -r ${output_dir}/ ${final_dir}/$3/
