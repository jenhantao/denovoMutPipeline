#! /bin/bash

# Variant Annotator
java -Xmx${heap}m -jar $gatk \
    -T VariantAnnotator \
    -R $REF \
    -I ${output_dir}/${subjectID}_${tumor}.bam \
    -A QualByDepth \
    -A Coverage \
    --variant ${output_dir}/${sname}.raw.snvs.vcf \
    -o ${output_dir}/${sname}.ann1.snvs.vcf \
    -L ${output_dir}/${sname}.raw.snvs.vcf \
    --dbsnp $DBSNP

java -Xmx${heap}m -jar $gatk \
    -T VariantAnnotator \
    -R $REF \
    -A SnpEff \
    --variant ${output_dir}/${sname}.ann1.snvs.vcf \
    --snpEffFile ${output_dir}/${sname}.snvs.snpeff.formatted.vcf \
    -o ${output_dir}/${sname}.ann.snvs.vcf \
    -L ${output_dir}/${sname}.ann1.snvs.vcf \
    --dbsnp $DBSNP


java -Xmx${heap}m -jar $gatk \
    -T VariantAnnotator \
    -R $REF \
    -I ${output_dir}/${subjectID}_${tumor}.bam \
    -A QualByDepth \
    -A Coverage \
    -A SnpEff \
    --variant ${output_dir}/${sname}.raw.indels.vcf \
    --snpEffFile ${output_dir}/${sname}.indels.snpeff.vcf \
    -o ${output_dir}/${sname}.ann.indels.vcf \
    -L ${output_dir}/${sname}.raw.indels.vcf \
    --dbsnp $DBSNP
