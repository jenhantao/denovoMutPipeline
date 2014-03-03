#! /bin/bash

# Note: Must run prepForVarscan.sh first to get mpileup files

mkdir -p ${tmp_folder}_varscan
 
java -Xmx${heap}m -Djava.io.tmpdir\=${tmp_folder}_varscan -jar ${varscan} somatic \
--analysis_type MuTect \
--reference_sequence $REF \
--cosmic $COSMIC \
--dbsnp $DBSNP_mutect \
--intervals $ExonFile \
--input_file:normal ${output_dir}/${normal}.mpileup \
--input_file:tumor ${output_dir}/${tumor}.mpileup \
--out ${output_dir}/${subjectID}.call_stats.out \
--coverage_file ${output_dir}/${subjectID}.coverage.wig.txt 

rmdir -p ${tmp_folder}_varscan