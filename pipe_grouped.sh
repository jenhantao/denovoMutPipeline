#! bin/bash

# Basic pipeline for alingment and variant calling from a single bam containing paired end reads

# Arg1 = project name
# Arg2 = short name - for naming files if the bamfilename is long (optional)

# Initialize environment variables from config file
source config/ngs.conf

# Get filename and filepath from arg1

# Make sure that directory with realigned bams exists
export output_dir=${runs_dir}/$1/$2
if [ ! -d ${output_dir} ]
then
    exit 1
fi

export subjectID=$2

# Generate list of bams
find ${output_dir} -name "*.rmdup.bam" > ${output_dir}/bam.list
export bamfileloc=${output_dir}/bam.list 

# Create intervals for realignment
./tasks/createIntervals.sh ${bamfileloc}

# Realign
./tasks/realign.sh ${bamfileloc}

# Recalibrate
./tasks/recalibrate.sh

# Split into individual bamfiles
./tasks/splitBam.sh

# Get coverage
find ${output_dir} -name "*.realigned.recal.bam" > ${output_dir}/bam.list.2
for bam in $(cat ${output_dir}/bam.list)
do
    ./tasks/getCoverageDepth.sh $(echo ${bam##*/} | cut -d "." -f1)
    ./tasks/getGeneCoverage.sh $(echo ${bam##*/} | cut -d "." -f1)
done
rm ${output_dir}/bam.list.2
# Cleanup?