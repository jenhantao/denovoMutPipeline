#! /bin/bash

mkdir -p ${tmp_folder}_checkbam 

java -Xmx${heap}m -Djava.io.tmpdir\=${tmp_folder}_checkbam -jar ${picard}/ValidateSamFile.jar INPUT\=${output_dir}/${subjectID}.fxmt.bam OUTPUT\=${output_dir}/${subjectID}.fxmt.valid.bam 

rm -rf ${tmp_folder}_checkbam

