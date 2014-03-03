#! /bin/bash

# Coordinate sort recalibrated bam files and convert to mpileup format

if [ ! -f ${output_dir}/$1.mpileup]
then
    java -Xmx${heap}m -Djava.io.tmpdir\=${tmp_folder}_varscan -jar ${picard}/SortSam.jar INPUT=${output_dir}/$1 OUTPUT=${output_dir}/$1.coordinate.srt.bam SORT_ORDER=coordinate VALIDATION_STRINGENCY=LENIENT 2> ${output_dir}/${subjectID}.srtsam.log
    ${samtools} mpileup -f $REF ${output_dir}/$1.coordinate.srt.bam > ${output_dir}/$1.mpileup
fi


