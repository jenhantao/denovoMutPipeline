#! /bin/bash

# Run Mutect on tumor normal pair
# Arg1: Project ID
# Arg2: Sample name
# Arg3: Normal Bam path
# Arg4: Tumor Bam path

# Initialize environment variables from config file
source config/ngs_direct.conf

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
if [ $normal = "TP" ]
then
	export normalFile=$(sed -n '1p' < ${output_dir}/bamFiles.txt)
elif [ $normal = "NB" ]
then
	export normalFile=$(sed -n '2p' < ${output_dir}/bamFiles.txt)
else
	export normalFile=$(sed -n '3p' < ${output_dir}/bamFiles.txt)
fi

if [ $tumor = "TP" ]
then
	export tumorFile=$(sed -n '1p' < ${output_dir}/bamFiles.txt)
elif [ $tumor = "NB" ]
then
	export tumorFile=$(sed -n '2p' < ${output_dir}/bamFiles.txt)
else
	export tumorFile=$(sed -n '3p' < ${output_dir}/bamFiles.txt)
fi

# Run Mutect
./tasks/mutect_direct.sh

# Process mutect calls to VCF
echo "mutect2vcf"
echo ${output_dir}/${sname}
./tasks/mutect2vcf ${output_dir}/${sname}.call_stats.out > ${output_dir}/${sname}.raw.snvs.vcf
./tasks/mutect2vcf ${output_dir}/${sname}.call_stats.out snpEff > ${output_dir}/${sname}.forSnpEff.snvs.vcf

## Get Indels
#./tasks/somaticIndelDetect.sh
#
## Annotate mutect VCF
#./tasks/runSnpEff.sh
#./tasks/adjustSnpEff ${output_dir}/${sname}.snvs.snpeff.vcf > ${output_dir}/${sname}.snvs.snpeff.formatted.vcf


