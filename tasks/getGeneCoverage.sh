#! /bin/bash

java -Xmx4g -jar ${gatk} \
     -R ${REF} \
     -T DepthOfCoverage \
     -o ${output_dir}/$1.depthofcoverage \
     -I ${output_dir}/$1.recal.bam \
     -geneList ${REFSEQ} \
     -ct 6 -ct 8 -ct 10 -ct 20 \
     -L ${ExonFile} \
     -omitBaseOutput \
     -omitLocusTable

