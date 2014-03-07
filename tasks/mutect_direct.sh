#! /bin/bash

echo "####################################"
echo ${normalFile}
echo ${tumorFile}
echo "####################################"
mkdir -p ${tmp_folder}_mutect

#java -Xmx${heap}m -Djava.io.tmpdir\=${tmp_folder}_mutect -jar ${mutect} \
#--analysis_type MuTect \
#--reference_sequence $REF \
#--cosmic $COSMIC \
#--dbsnp $DBSNP_mutect \
#--intervals $ExonFile \
#--input_file:normal ${normalFile} \
#--input_file:tumor ${tumorFile} \
#--out ${output_dir}/${sname}.call_stats.out \
#--coverage_file ${output_dir}/${sname}.coverage.wig.txt 

java -Xmx${heap}m -Djava.io.tmpdir\=${tmp_folder}_mutect -jar ${mutect} \
--analysis_type MuTect \
--reference_sequence $REF \
--dbsnp $DBSNP_mutect \
--input_file:normal ${normalFile} \
--input_file:tumor ${tumorFile} \
--out ${output_dir}/${sname}.call_stats.out \
--coverage_file ${output_dir}/${sname}.coverage.wig.txt 
rmdir -p ${tmp_folder}_mutect
