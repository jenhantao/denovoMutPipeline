#! /bin/bash

mkdir -p ${tmp_folder}_covar

java -Xmx${heap}m -Djava.io.tmpdir\=${tmp_folder}_covar \
-jar $gatk \
-R $REF \
-l INFO \
-I ${output_dir}/${subjectID}.realigned.srt.bam \
-knownSites $DBSNP \
-T CountCovariates \
-nt $CPUs \
-cov ReadGroupCovariate \
-cov QualityScoreCovariate \
-cov CycleCovariate \
-cov DinucCovariate \
-recalFile ${output_dir}/${subjectID}.flt.recal_v1.csv  \
-L $ExonFile

mkdir -p  ${output_dir}/analyzeCovar_v1

java -Xmx${heap}m -Djava.io.tmpdir\=${tmp_folder}_covar \
-jar ${gatk} \
-T BaseRecalibrator \
-I ${output_dir}/${subjectID}.realigned.srt.bam \
-R $REF \
-knownSites $DBSNP \
-o ${output_dir}/${subjectID}.recal_data.grp

java -jar GenomeAnalysisTK.jar \
-T PrintReads \
-R $REF \
-I ${output_dir}/${subjectID}.realigned.srt.bam \
-BQSR ${output_dir}/${subjectID}.recal_data.grp \
-o ${output_dir}/${subjectID}.recal.bam


#java -Xmx${heap}m -Djava.io.tmpdir\=${tmp_folder}_covar \
#-jar ${gatk_analyzecovar} \
#-recalFile ${output_dir}/${subjectID}.flt.recal_v1.csv  \
#-outputDir ${output_dir}/analyzeCovar_v1  \
#-ignoreQ 3

rm -rf ${tmp_folder}_covar