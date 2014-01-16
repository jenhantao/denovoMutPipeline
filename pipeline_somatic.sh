#! bin/bash

# Pipeline for calling somatic mutations from a matched tumor normal pair 
# Expects processed bamfiles

# Arg1 = path to normal bamfile
# Arg2 = path to tumor bamfile
# Arg3 = short name - for naming files if the bamfilename is long (optional)

# Initialize environment variables from config file
source config/ngs.conf

# Get filenames and filepaths from args 1 & 2
export bamfile1=$(echo ${1##*/})
export bampath1=$(dirname $1)
export filename1=$(echo ${bamfile%.*})

export bamfile2=$(echo ${2##*/})
export bampath2=$(dirname $2)
export filename2=$(echo ${bamfile%.*})

export normal=$1
export tumor=$2


# If provided with a short name, use that rather than the bamfilename to name output files
if test -z "$3"
then
    export subjectID=$filename2
else
    export subjectID=$3
fi

# Create directory for storing output - should probably include date
mkdir ${runs_dir}/${subjectID} 2> /dev/null
export output_dir=${runs_dir}/${subjectID}

#cp $1 ${output_dir}
#cp $2 ${output_dir}

#export normal=$filename1
#export tumor=$filename2

#echo $normal
#echo $tumor

# Run MuTect
./tasks/mutect.sh

# # Run VarScan
# ./tasks/varscan.sh


# # Run Strelka
# For strelka, should use unprocessed bam files
# ./tasks/strelka.sh
