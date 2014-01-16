#! /bin/bash

# Run Mutect on tumor normal pair
# Arg1: Project ID
# Arg2: Sample name
# Arg3: Normal Bam
# Arg4: Tumor Bam

# Initialize environment variables from config file
source config/ngs.conf

# Make sure that directory with realigned bams exists
export output_dir=${runs_dir}/$1/$2
if [ ! -d ${output_dir} ]
then
    exit 1
fi

# Run mutect
export normal=$3 
export tumor=$4

# Run Mutect
./tasks/mutect.sh


# Process mutect calls to VCF

# Annotate mutect VCF
#./tasks/annotate.sh

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

