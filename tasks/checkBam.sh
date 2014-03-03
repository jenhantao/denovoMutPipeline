#! /bin/bash

mkdir -p ${tmp_folder}_checkbam 

java -Xmx${heap}m -Djava.io.tmpdir\=${tmp_folder}_checkbam -jar ${picard}/ValidateSamFile.jar INPUT\=${bampath}/${bamfile} OUTPUT\=${output_dir}/${subjectID}.valid.bam 

${bamtools} stats -insert -in ${output_dir}/${subjectID}.bam > ${output_dir}/${subjectID}.stats

rm -rf ${tmp_folder}_checkbam

