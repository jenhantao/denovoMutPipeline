#! /bin/bash

#snpEff="/ngs1a/01-script/snpeff/snpEff_2_0_5"
 
java -Xmx${heap}m  \
  -jar   ${snpEff}/snpEff.jar  \
   eff   \
   -v -i vcf \
   -o gatk   \
   -c    ${snpEff}/snpEff.config
   GRCh37.65   \
   ${output_dir}/variants/${subjectID}.snps.PASS.vcf   
 
 
java -Xmx${heap}m  \
  -jar   ${snpEff}/snpEff.jar  \
   eff   \
   -v -i vcf \
   -o vcf   \
   -c    ${snpEff}/snpEff.config
   GRCh37.65   \
   ${output_dir}/variants/${subjectID}.indels.PASS.vcf
 