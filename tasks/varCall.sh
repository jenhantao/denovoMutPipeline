#! /bin/bash

mkdir ${output_dir}/variants
 
java -Xmx${heap}m  \
    -jar $gatk \
    -R $REF \
    -T UnifiedGenotyper \
    --dbsnp $DBSNP \
    -I ${output_dir}/${subjectID}.realigned.recal.bam \
    -o ${output_dir}/variants/${subjectID}.snps.raw.vcf \
    -stand_call_conf 30.0 \
    -stand_emit_conf 10.0 \
    -out_mode EMIT_VARIANTS_ONLY \
    -l INFO \
    -dcov 200 \
    -nt 1  \
    -glm SNP \
    -L $ExonFile \
    -A HaplotypeScore \
    -A InbreedingCoeff \

rm -f ${output_dir}/variants/*.idx

java -Xmx${heap}m  \
    -jar $gatk \
    -R $REF \
    -T UnifiedGenotyper \
    --dbsnp $DBSNP \
    -I ${output_dir}/${subjectID}.realigned.recal.bam \
    -o ${output_dir}/variants/${subjectID}.indels.raw.vcf \
    -stand_call_conf 30.0 \
    -stand_emit_conf 10.0 \
    -out_mode EMIT_VARIANTS_ONLY \
    -l INFO \
    -dcov 200 \
    -nt 1  \
    -glm INDEL  \
    -L $ExonFile \
    -A HaplotypeScore \
    -A InbreedingCoeff \
 
rm -f ${output_dir}/variants/*.idx


