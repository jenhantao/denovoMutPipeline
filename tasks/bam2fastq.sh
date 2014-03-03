#! /bin/bash

# NOTE: Currently assumes that only one bamfile is stored in each mount directory

echo "${htscmd} bamshuf -Ou -n 128 ${bamfilename} ${output_dir}/tmp | ${htscmd} bam2fq -a - | gzip > ${output_dir}/${subjectID}_interleaved_reads.fastq.gz"

#${htscmd} bamshuf -Ou -n 128 ${bampath}/${bamfile}/*.bam ${output_dir}/tmp | ${htscmd} bam2fq -a - | gzip > ${output_dir}/${subjectID}_interleaved_reads.fastq.gz

${htscmd} bamshuf -Ou -n 128 ${bamfilename} ${output_dir}/tmp | ${htscmd} bam2fq -a - | gzip > ${output_dir}/${subjectID}_interleaved_reads.fastq.gz