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

export subjectID=$2

# Run mutect
export normal=$3 
export tumor=$4
export sname=${subjectID}_${normal}_${tumor}

# Run Mutect
./tasks/mutect.sh

# Process mutect calls to VCF
./tasks/mutect2vcf ${output_dir}/${sname}.call_stats.out > ${output_dir}/${sname}.raw.snvs.vcf
./tasks/mutect2vcf ${output_dir}/${sname}.call_stats.out snpEff > ${output_dir}/${sname}.forSnpEff.snvs.vcf

# Get Indels
./tasks/somaticIndelDetect.sh

# Annotate mutect VCF
./tasks/runSnpEff.sh
./tasks/adjustSnpEff ${output_dir}/${sname}.snvs.snpeff.vcf > ${output_dir}/${sname}.snvs.snpeff.formatted.vcf

#./tasks/annotateMutect.sh
# #./tasks/annotateMutect.sh ${output_dir}/${sname}.snvs.PASS.vcf
# #./tasks/annotateMutect.sh ${output_dir}/${sname}.indels.PASS.vcf

# VSQR - reduce false positives by recalibrating variant error based on hapmap snps?
./tasks/VQSR_somatic.sh

# Get coverage
#./tasks/getCoverageDepth.sh
#./tasks/getGeneCoverage.sh
#./tasks/hsMetrics.sh

# # Cleanup
# ./tasks/cleanup.sh

# # Call Variants with GATK
#./tasks/varCall.sh 
#./tasks/varCallHC.sh 
#./tasks/varFilter.sh # For small numbers for exomes
#./tasks/VQSR.sh # For large numbers of exomes

# # Get Genotype
#./tasks/getGenotype.sh

