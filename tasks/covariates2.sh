#! /bin/bash

mkdir -p ${tmp_folder}_covar

java -Xmx${heap}m -Djava.io.tmpdir\=${tmp_folder}_covar \
 -jar $gatk \
 -R $REF \
 -I ${output_dir}/${subjectID}.realigned.recal.bam \
 -knownSites ${DBSNP} \
 -T CountCovariates \
 -nt $CPUs \
 -cov ReadGroupCovariate \
 -cov QualityScoreCovariate \
 -cov CycleCovariate \
 -cov DinucCovariate \
 -recalFile ${output_dir}/${subjectID}.flt.recal_v2.csv  \
 -L $ExonFile

mkdir -p  ${output_dir}/analyzeCovar_v2

java -Xmx${heap}m  \
 -jar ${gatk_analyzecovar} \
 -recalFile ${output_dir}/${subjectID}.flt.recal_v2.csv  \
 -outputDir ${output_dir}/analyzeCovar_v2  \
 -ignoreQ 3
