#! /bin/bash

# Remove files generated in grouped file alignment and variant calling

export output_dir=runs/$1/$2

rm -rf ${output_dir}/*.realigned.bam
rm -rf ${output_dir}/*.realigned.bai
#rm -rf ${output_dir}/*.realigned.recal.bam
#rm -rf ${output_dir}/*.realigned.recal.bai
rm -rf ${output_dir}/*.realigned.recal.bam.bai
#rm -rf ${output_dir}/$2_*.bam