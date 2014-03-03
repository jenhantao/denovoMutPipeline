#! /bin/bash

# GATK compatible SnpEff
java -Xmx${heap}m -jar $snpEff eff -c $snpEffConf -o gatk -s ${output_dir}/${sname}.snvs.snpeff.summary GRCh37.64 ${output_dir}/${sname}.forSnpEff.snvs.vcf > ${output_dir}/${sname}.snvs.snpeff.vcf
java -Xmx${heap}m -jar $snpEff eff -c $snpEffConf -o gatk -s ${output_dir}/${sname}.indels.snpeff.summary GRCh37.64 ${output_dir}/${sname}.raw.indels.vcf > ${output_dir}/${sname}.indels.snpeff.vcf

# Full snpEff - not currently GATK compatible
#java -Xmx${heap}m -jar $snpEff eff -c $snpEffConf -nextprot -motif -lof -reg GM12878 -s ${output_dir}/${sname}.snvs.snpeff.summary GRCh37.71 ${output_dir}/${sname}.forSnpEff.snvs.vcf > ${output_dir}/${sname}.snvs.snpeff.vcf
#java -Xmx${heap}m -jar $snpEff eff -c $snpEffConf -nextprot -motif -lof -reg GM12878 -s ${output_dir}/${subjectID}.indels.snpeff.nf.summary GRCh37.71 ${output_dir}/${subjectID}.raw.indels.vcf > ${output_dir}/${subjectID}.indels.snpeff.vcf

