#! bin/bash

# Basic pipeline for alingment and variant calling from a single bam containing paired end reads

# Arg1 = path to bamfile
# Arg2 = short name - for naming files if the bamfilename is long (optional)

# Initialize environment variables from config file
source config/ngs.conf

# Get filename and filepath from arg1
export bamfile=$(echo ${1##*/})
export bampath=$(dirname $1)
export filename=$(echo ${bamfile%.*})


# Make sure that directory with realigned bams exists
export output_dir=${runs_dir}/$2
if [ ! -d ${output_dir} ]
    exit 1
fi

# Check realigned bams 
# ./tasks/checkTumorNormal.sh

# Create intervals for realignment
# ./tasks/mergeBams.sh #
#./tasks/createIntervals.sh

# Realign
#./tasks/realign.sh

# Recalibrate
#./tasks/recalibrate.sh

# Get coverage
#./tasks/getCoverageDepth.sh
#./tasks/getGeneCoverage.sh
#./tasks/hsMetrics.sh

# # Cleanup
# ./tasks/cleanup.sh

# # Call Variants
#./tasks/varCall.sh 
#./tasks/varCallHC.sh 
#./tasks/varFilter.sh # For small numbers for exomes
#./tasks/VQSR.sh # For large numbers of exomes

# # Get Genotype
#./tasks/getGenotype.sh

# Annotate variants
./tasks/annotate.sh