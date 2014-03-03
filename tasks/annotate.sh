#! /bin/bash

# Variant Annotator
java -Xmx${heap}m -jar $gatk \
     -T VariantAnnotator \
     -R $REF \
     -A SnpEff \
     --variant ${output_dir}/germline/${sname}.snvs.PASS.vcf \
     --snpEffFile ${output_dir}/germline/${sname}.snvs.snpeff.vcf \
     -o ${output_dir}/germline/${sname}.snvs.PASS.snpeff.vcf \
     -L ${output_dir}/germline/${sname}.snvs.PASS.vcf \
     --dbsnp $DBSNP

java -Xmx${heap}m -jar $gatk \
     -T VariantAnnotator \
     -R $REF \
     -A SnpEff \
     --variant ${output_dir}/germline/${sname}.indels.PASS.vcf \
     --snpEffFile ${output_dir}/germline/${sname}.indels.snpeff.vcf \
     -o ${output_dir}/germline/${sname}.indels.PASS.snpeff.vcf \
     -L ${output_dir}/germline/${sname}.indels.PASS.vcf \
     --dbsnp $DBSNP

rm -f ${output_dir}/germline/*.idx