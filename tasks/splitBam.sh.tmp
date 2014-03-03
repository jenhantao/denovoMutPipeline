#! /bin/bash

java -Xmx${heap}m -jar $gatk \
   -T SplitSamFile \
   -I ${output_dir}/${subjectID}.realigned.recal.bam \
   -R $REF \
   --outputRoot ${output_dir}/

find ${output_dir}/ -regextype sed -regex ".*/[A-z0-9\-]*[/_]...bam" > ${output_dir}/indexlist

for file in $(cat ${output_dir}/indexlist)
do 
    ${samtools} index $file
done
rm ${output_dir}/indexlist