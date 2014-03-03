#! /bin/bash

${bamtools} filter \
    -mapQuality ">=60"    \
    -in ${output_dir}/${subjectID}.rmdup.bam   \
    -out ${output_dir}/${subjectID}.mq.srt.bam

${samtools} index ${output_dir}/${subjectID}.mq.srt.bam

${bamtools} stats \
    -insert \
    -in ${output_dir}/${subjectID}.mq.srt.bam \
    > ${output_dir}/${subjectID}.mq.srt.stats
