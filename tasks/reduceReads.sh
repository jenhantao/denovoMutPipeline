#! /bin/bash 

java -Xmx${heap}m -jar $gatk \
   -R $REF \
   -T ReduceReads \
   -I ${output_dir}/${SubjectID}.recal.bam \
   -o ${output_dir}/${SubjectID}.recal.reduced.bam
 