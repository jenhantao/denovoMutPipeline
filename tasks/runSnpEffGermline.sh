#! /bin/bash

# GATK compatible SnpEff
java -Xmx${heap}m -jar $snpEff eff -c $snpEffConf -o gatk -s ${output_dir}/germline/${sname}.snvs.snpeff.summary GRCh37.64 ${output_dir}/germline/${sname}.snvs.PASS.vcf > ${output_dir}/germline/${sname}.snvs.snpeff.vcf
java -Xmx${heap}m -jar $snpEff eff -c $snpEffConf -o gatk -s ${output_dir}/germline/${sname}.indels.snpeff.summary GRCh37.64 ${output_dir}/germline/${sname}.indels.PASS.vcf > ${output_dir}/germline/${sname}.indels.snpeff.vcf

# Full snpEff - not currently GATK compatible
#java -Xmx${heap}m -jar $snpEff eff -c $snpEffConf -nextprot -motif -lof -reg GM12878 -s ${output_dir}/germline/${sname}.snvs.snpeff.summary GRCh37.71 ${output_dir}/germline/${sname}.snvs.PASS.vcf > ${output_dir}/germline/${sname}.snvs.snpeff.vcf
#java -Xmx${heap}m -jar $snpEff eff -c $snpEffConf -nextprot -motif -lof -reg GM12878 -s ${output_dir}/germline/${subjectID}.indels.snpeff.summary GRCh37.71 ${output_dir}/germline/${sname}.indels.PASS.vcf > ${output_dir}/germline/${sname}.indels.snpeff.vcf

