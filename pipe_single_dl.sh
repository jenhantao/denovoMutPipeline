#! bin/bash

# Basic pipeline for alignment to genome starting from a single bam containing paired end reads

# Arg1 = path to bamfile
# Arg2 = project (Name of directory in ~/mnt where files are mounted)
# Arg3 = short name - for naming files if the bamfilename is long (optional)
# Arg4 = sample type (Tumor or Normal)


# Initialize environment variables from config file
source config/ngs.conf

# Get filename and filepath from arg1
export bamfile=$(echo ${1##*/})
export bampath=$1
export subjectID=$3"_"$4

# Create directory for storing output - FixMe: should probably include date
mkdir ${runs_dir}/$2 2> /dev/null
mkdir ${runs_dir}/$2/$3 2> /dev/null
export output_dir=${runs_dir}/$2/$3

# Download bam file using gtdownload
#./tasks/dlBam.sh $2 $(echo ${1##*/})

export bamfilename=$(find ${data_dir}/$2/$(echo ${1##*/}) -name "*.bam") 

# Strip reads from bam file
./tasks/bam2fastq.sh
./tasks/rmBam.sh $2 $(echo ${1##*/})

# Align reads with bwa (or snap)
./tasks/bwaAlignMemInt.sh
#./tasks/snapAlignPE.sh
#./tasks/checkAlignStats.sh

# # Clean up alignments
./tasks/fixmate.sh
./tasks/fixReadGroups.sh $4
# #./tasks/filter.sh

# # # Mark duplicates
./tasks/removeDups.sh
# # ./tasks/filterMapQ.sh
# # ./tasks/checkDupStats.sh