#! /bin/bash

echo "pe alignment from interleaved bam"
$bwa mem -M -t $CPUs $hg19_ref_bwa -p ${output_dir}/${subjectID}_interleaved_reads.fastq.gz | gzip > ${output_dir}/${subjectID}.sam.gz 2> ${output_dir}/${subjectID}.pe.log


# NOTE: -u specifies uncompressed bam file - these DO NOT have an EOF marker 
${samtools} view -uS ${output_dir}/${subjectID}.sam.gz |  ${samtools} sort -m 3000000000 - ${output_dir}/${subjectID}.srt

${samtools} index ${PWDS}/${subjectID}.srt.bam

${bamtools} stats -insert -in ${output_dir}/${subjectID}.srt.bam > ${output_dir}/${subjectID}.srt.stats

