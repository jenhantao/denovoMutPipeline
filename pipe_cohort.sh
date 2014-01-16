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

# If provided with a short name, use that rather than the bamfilename to name output files
if test -z "$2"
then
    export subjectID=$filename
else
    export subjectID=$2
fi

# Create directory for storing output - should probably include date
mkdir ${runs_dir}/$filename 2> /dev/null
export output_dir=${runs_dir}/$filename

# Names for fastq files stripped from paired-end bam
export fastq_for_gz=${subjectID}_forward.fq
export fastq_rev_gz=${subjectID}_reverse.fq

# Strip reads from bam file
#./tasks/bam2fastq.sh
#./tasks/picardBam2Fastq.sh

# Align reads with bwa (or snap)
#./tasks/bwaAlignMem.sh # two fastq files
#./tasks/bwaAlignMemInt.sh # interleaved
#./tasks/bwaAlignPE.sh
#./tasks/snapAlignPE.sh

# Clean up alignments
#./tasks/fixmate.sh
#./tasks/fixReadGroups.sh
#./tasks/filter.sh

# # Mark duplicates
#./tasks/removeDups.sh
#./tasks/filterMapQ.sh
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