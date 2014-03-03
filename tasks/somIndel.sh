#! /bin/bash

#Call somatic indels
java -Xmx${heap}m -jar $gatk \
   -T SomaticIndelDetector \
   -R $REF \
   -o ${output_dir}/${subjectID}_somatic_indels.vcf \
   -verbose ${output_dir}/${subjectID}_somatic_indels.txt \
   -I:normal ${output_dir}/${subjectID}_normal.realigned.recal.bam \
   -I:tumor ${output_dir}/${subjectID}_tumor.realigned.recal.bam
 
rm -f ${output_dir}/variants/*.idx
