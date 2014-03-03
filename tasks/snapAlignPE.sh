#! /bin/bash

echo "pe alignment"
${snap} paired $snap_index -t $CPUs ${output_dir}/$fastq_for_gz ${output_dir}/$fastq_rev_gz -o ${output_dir}/${subjectID}.sam 2> ${output_dir}/${subjectID}.pe.log 

${samtools} view -uS ${output_dir}/${subjectID}.sam |  ${samtools} sort -m 3000000000 - ${output_dir}/${subjectID}.srt

${samtools} index ${output_dir}/${subjectID}.srt.bam

${bamtools} stats -insert -in ${output_dir}/${subjectID}.srt.bam > ${output_dir}/${subjectID}.srt.stats
