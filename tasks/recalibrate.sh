#! /bin/bash

mkdir -p ${tmp_folder}_recal

# Recalibrate base quality scores
java -Xmx${heap}m -Djava.io.tmpdir\=${tmp_folder}_recal \
-jar ${gatk} \
-T BaseRecalibrator \
-I ${output_dir}/${subjectID}.realigned.bam \
-R $REF \
-L $ExonFile \
-knownSites $DBSNP \
-knownSites $mills \
-o ${output_dir}/${subjectID}.recal_data.grp

# Apply recalibration
java -Xmx${heap}m -Djava.io.tmpdir\=${tmp_folder}_recal -jar ${gatk} \
-T PrintReads \
-R $REF \
-I ${output_dir}/${subjectID}.realigned.bam \
-BQSR ${output_dir}/${subjectID}.recal_data.grp \
-o ${output_dir}/${subjectID}.realigned.recal.bam

java -Xmx${heap}m -Djava.io.tmpdir\=${tmp_folder}_recal \
-jar ${gatk} \
-T BaseRecalibrator \
-I ${output_dir}/${subjectID}.realigned.recal.bam \
-R $REF \
-L $ExonFile \
-knownSites $DBSNP \
-knownSites $mills \
-BQSR ${output_dir}/${subjectID}.recal_data.grp \
-o ${output_dir}/${subjectID}.recal_data.after.grp

# Missing R script

# QC: Determine the covariates affecting base quality scores in the realigned recalibrated bam (optional)
java -Xmx${heap}m -Djava.io.tmpdir\=${tmp_folder}_recal \
-jar ${gatk} \
-T BaseRecalibrator \
-I ${output_dir}/${subjectID}.realigned.recal.bam \
-R $REF \
-knownSites $DBSNP \
-knownSites $mills \
-before ${output_dir}/${subjectID}.recal_data.grp \
-after ${output_dir}/${subjectID}.recal_data.after.grp \
-plots ${output_dir}/${subjectID}.recal_data.after.plots \
-o ${output_dir}/${subjectID}.BQSR.QC

$samtools index ${output_dir}/${subjectID}.realigned.recal.bam

rmdir -p ${tmp_folder}_recal