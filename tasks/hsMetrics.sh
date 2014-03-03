#! /bin/bash

$samtools view -H ${output_dir}/${subjectID}.realigned.recal.bam > header.txt

m=0
for i in `cat $ExonFile`;   \
do echo "$i"; echo "MPMPMP$m"; m=$(($m + 1)) ;  \
done > exon.target.interval_list.tmp

perl -0777 -i -pe "s/\nMPMPMP/\ttarget_/g" exon.target.interval_list.tmp
perl -0777 -i -pe "s/\r\t/\t/g" exon.target.interval_list.tmp
perl -0777 -i -pe "s/:/\t/g" exon.target.interval_list.tmp
perl -0777 -i -pe "s/-/\t/g" exon.target.interval_list.tm2
cat header.txt  exon.target.interval_list.tmp > exon.target.interval_list.picard

java -Xmx${heap}m -jar ${picard}/CalculateHsMetrics.jar \
    BAIT_INTERVALS\=$BaitFilePicard  \
    TARGET_INTERVALS\=$ExonFilePicard   \
    INPUT\=${output_dir}/${subjectID}.realigned.recal.bam  \
    OUTPUT\=${output_dir}/${subjectID}.realigned.recal.hsmetrics