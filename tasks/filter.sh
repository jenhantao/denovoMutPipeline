#! /bin/bash

${bamtools} filter -isMapped true -isPaired true -isProperPair true -in  ${output_dir}/${subjectID}.fxmt.bam -out ${output_dir}/${subjectID}.fxmt.flt.bam

${bamtools} stats -insert -in ${output_dir}/${subjectID}.fxmt.flt.bam > ${output_dir}/${subjectID}.fxmt.flt.stats

${samtools} index ${output_dir}/${subjectID}.fxmt.flt.bam


