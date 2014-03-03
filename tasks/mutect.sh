#! /bin/bash

mkdir -p ${tmp_folder}_mutect

java -Xmx${heap}m -Djava.io.tmpdir\=${tmp_folder}_mutect -jar ${mutect} \
--analysis_type MuTect \
--reference_sequence $REF \
--cosmic $COSMIC \
--dbsnp $DBSNP_mutect \
--intervals $ExonFile \
--input_file:normal ${output_dir}/${subjectID}_${normal}.bam \
--input_file:tumor ${output_dir}/${subjectID}_${tumor}.bam \
--out ${output_dir}/${sname}.call_stats.out \
--coverage_file ${output_dir}/${sname}.coverage.wig.txt 

rmdir -p ${tmp_folder}_mutect