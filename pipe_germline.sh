#! /bin/bash

# Run Mutect on tumor normal pair
# Arg1: Project ID
# Arg2: Sample name
# Arg3: Normal Bam

# Initialize environment variables from config file
source config/ngs.conf

# Make sure that directory with realigned bams exists
export output_dir=${runs_dir}/$1/$2
if [ ! -d ${output_dir} ]
then
    exit 1
fi

export subjectID=$2

# Run mutect
export normal=$3 
export sname=${subjectID}_${normal}

# Run Variant Caller
./tasks/varCallHC.sh

# VSQR - reduce false positives by recalibrating variant error based on hapmap snps?
./tasks/varFilter.sh
./tasks/VQSR.sh

# Annotate VCF
./tasks/runSnpEffGermline.sh
./tasks/annotate.sh


# Get coverage
#./tasks/getCoverageDepth.sh
#./tasks/getGeneCoverage.sh
#./tasks/hsMetrics.sh

# # Cleanup
# ./tasks/cleanup.sh

# # Call Variants with GATK
#./tasks/varCall.sh 
#./tasks/varCallHC.sh 

# # Get Genotype
#./tasks/getGenotype.sh

