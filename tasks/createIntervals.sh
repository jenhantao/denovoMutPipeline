#! /bin/bash

mkdir -p ${tmp_folder}_realign

java -Xmx${heap}m -Djava.io.tmpdir\=${tmp_folder}_realign \
 -jar $gatk \
 -T RealignerTargetCreator \
 -I $1 \
 -R $REF \
 -known $DBSNP \
 -nt $CPUs \
 -o ${output_dir}/${subjectID}.forRealign.intervals \
 -L $ExonFile

rm -rf ${tmp_folder}_realign