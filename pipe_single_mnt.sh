#! bin/bash

# Basic pipeline for alignment to genome starting from a single bam containing paired end reads

# Arg1 = path to bamfile
# Arg2 = project (Name of directory in ~/mnt where files are mounted)
# Arg3 = short name - for naming files if the bamfilename is long (optional)
# Arg4 = sample type (Tumor or Normal)
# Arg5 = platform
# Arg6 = library (WXS, WGS, etc)

# Initialize environment variables from config file
source config/ngs.conf

# Get filename and filepath from arg1
export bamfile=$(echo ${1##*/})
export bampath=$1

# Overwrite data_dir in config file
export data_dir=/home/moores/mnt

export subjectID=$3"_"$4

# Create directory for storing output - FixMe: should probably include date
mkdir ${runs_dir}/$2 2> /dev/null
mkdir ${runs_dir}/$2/$3 2> /dev/null
export output_dir=${runs_dir}/$2/$3
echo $output_dir


# Mount bam file using gtfuse
./tasks/mountBam.sh $2 $(echo ${1##*/})
export bamfilename=$(find $bampath/$bamfile -name "*.bam") 
echo $bamfilename

# Strip reads from bam file
./tasks/bam2fastq.sh
./tasks/unmountBam.sh $2 $(echo ${1##*/})

# Align reads with bwa (or snap)
#./tasks/bwaAlignMemInt.sh
# #./tasks/snapAlignPE.sh
# #./tasks/checkAlignStats.sh

# # Clean up alignments
#./tasks/fixmate.sh
#./tasks/fixReadGroups.sh
# #./tasks/filter.sh

# # # Mark duplicates
#./tasks/removeDups.sh
# # ./tasks/filterMapQ.sh
# # ./tasks/checkDupStats.sh