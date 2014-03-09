#! /bin/bash

export output_dir=runs/$1/$2

rm -rf ${output_dir}/*.fastq.gz
rm -rf ${output_dir}/*.sam.gz
rm -rf ${output_dir}/*.srt.bam
rm -rf ${output_dir}/*.srt.bai
rm -rf ${output_dir}/*.fxmt.bam
rm -rf ${output_dir}/*.fxmt.bai
rm -rf ${output_dir}/*.fxmt.bam.bai
rm -rf ${output_dir}/*.rmdup.bam
rm -rf ${output_dir}/*.rmdup.bai
rm -rf ${output_dir}/*.rmdup.fxgrp.bam
rm -rf ${output_dir}/*.rmdup.fxgrp.bai
rm -rf ${output_dir}/*.realigned.bam
rm -rf ${output_dir}/*.realigned.bai
rm -rf ${output_dir}/*.realigned.recal.bam.bai
rm -rf ${output_dir}/*.bam
rm -rf ${output_dir}/*.bai
rm -rf ${output_dir}/coverage/*.depthofcoverage

# read in file paths
unMount_TP=$(echo $(sed -n '1p' < runs/$1/$2/bamFiles.txt))
unMount_NB=$(echo $(sed -n '2p' < runs/$1/$2/bamFiles.txt))
unMount_NT=$(echo $(sed -n '3p' < runs/$1/$2/bamFiles.txt))

# unmount bam files
/home/moores/projects/pipeline/tasks/unmountBam.sh $1 $unMount_TP
/home/moores/projects/pipeline/tasks/unmountBam.sh $1 $unMount_NB
/home/moores/projects/pipeline/tasks/unmountBam.sh $1 $unMount_NT
#
# remove file list
rm runs/$1/$2/bamFiles.txt
