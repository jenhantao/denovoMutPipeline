#! /bin/bash

# Hard filter for variants in small numbers of exomes (< 30)
#
# NOTE: Error messages like this
# WARN  11:39:55,446 Interpreter - ![0,14]: 'ReadPosRankSum < -20.0;' undefined variable ReadPosRankSum   
# can be caused by an annotation missing for a subset of values.
# Also, if filter values are not of the SAME type (float:float, interger:interger, etc.) then the filter might fail
# i.e. if file stores float (30.0) and filter is set to compare to an integer (30) no filtering will take place.

# Divide output into SNPs and INDELS
java -Xmx${heap}m -jar  $gatk \
   -R $REF \
   -T SelectVariants \
   --variant ${output_dir}/germline/${sname}.raw.snvs.indels.vcf \
   -o ${output_dir}/germline/${sname}.raw.indels.vcf \
   -selectType INDEL

java -Xmx${heap}m -jar $gatk \
   -R $REF \
   -T SelectVariants \
   --variant ${output_dir}/germline/${sname}.raw.snvs.indels.vcf \
   -o ${output_dir}/germline/${sname}.raw.snvs.vcf \
   -selectType SNP

# Filter indels
java -Xmx${heap}m  \
  -jar $gatk \
  -l INFO -T VariantFiltration \
  -R $REF \
  -o ${output_dir}/germline/${sname}.filtered.indels.vcf \
  -V:VCF ${output_dir}/germline/${sname}.raw.indels.vcf \
  --filterExpression "QD < 2.0" \
  --filterName "QDFilter" \
  --filterExpression "ReadPosRankSum < -20.0" \
  --filterName "ReadPosFilter" \
  --filterExpression "FS > 200.0" \
  --filterName "FSFilter" \
  --filterExpression "MQ0 >= 4 && ((MQ0 / (1.0 * DP)) > 0.1)" \
  --filterName "HARD_TO_VALIDATE" \
  --filterExpression "QUAL < 30.0 || DP < 6 || DP > 5000 " \
  --filterName "QualFilter"
 
rm -f ${output_dir}/germline/*.idx

# Need to get list of passing indels
mline2=`grep -n "#CHROM" ${output_dir}/germline/${sname}.filtered.indels.vcf | cut -d':' -f 1`
head -n $mline2 ${output_dir}/germline/${sname}.filtered.indels.vcf > ${output_dir}/germline/headindels.vcf
cat ${output_dir}/germline/${sname}.filtered.indels.vcf | grep PASS | cat ${output_dir}/germline/headindels.vcf - > ${output_dir}/germline/${sname}.indels.PASS.vcf
 
rm -f ${output_dir}/germline/headindels.vcf

java -Xmx${heap}m  \
  -jar $gatk \
  -l OFF -T VariantFiltration \
  -R $REF \
  -o ${output_dir}/germline/${sname}.filtered.snvs.vcf \
  --variant ${output_dir}/germline/${sname}.raw.snvs.vcf \
  --mask ${output_dir}/germline/${sname}.indels.PASS.vcf \
  --maskName InDel \
  --clusterSize 3 \
  --clusterWindowSize 10 \
  --filterExpression "QD < 2.0" \
  --filterName "QDFilter" \
  --filterExpression "MQ < 40.0" \
  --filterName "MQFilter" \
  --filterExpression "FS > 60.0" \
  --filterName "FSFilter" \
  --filterExpression "HaplotypeScore > 13.0" \
  --filterName "HaplotypeScoreFilter" \
  --filterExpression "MQRankSum < -12.5" \
  --filterName "MQRankSumFilter" \
  --filterExpression "ReadPosRankSum < -8.0" \
  --filterName "ReadPosRankSumFilter" \
  --filterExpression "QUAL < 30.0 || DP < 6 || DP > 5000 "\
  --filterName "StandardFilters" \
  --filterExpression "MQ0 >= 4 && ((MQ0 / (1.0 * DP)) > 0.1)" \
  --filterName "HARD_TO_VALIDATE"
  
rm -f ${output_dir}/germline/*.idx

mline=`grep -n "#CHROM" ${output_dir}/germline/${sname}.filtered.snvs.vcf | cut -d':' -f 1`
head -n $mline ${output_dir}/germline/${sname}.filtered.snvs.vcf > ${output_dir}/germline/head.vcf
cat ${output_dir}/germline/${sname}.filtered.snvs.vcf | grep PASS | cat ${output_dir}/germline/head.vcf - > ${output_dir}/germline/${sname}.snvs.PASS.vcf
  
rm -f ${output_dir}/germline/head.vcf

java -Xmx${heap}m -jar $gatk \
   -T VariantEval \
   --dbsnp $DBSNP \
   -R $REF \
   -eval ${output_dir}/germline/${sname}.snvs.PASS.vcf \
   -o ${output_dir}/germline/${sname}.snvs.PASS.vcf.eval


java -Xmx${heap}m -jar $gatk \
   -T VariantEval \
   --dbsnp $DBSNP \
   -R $REF \
   -eval ${output_dir}/germline/${sname}.indels.PASS.vcf \
   -o ${output_dir}/germline/${sname}.indels.PASS.vcf.eval

 
rm -f ${output_dir}/germline/*.idx
