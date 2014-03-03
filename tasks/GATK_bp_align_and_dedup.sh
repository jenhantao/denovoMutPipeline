#! /bin/bash

echo "pe alignment from interleaved bam"
$bwa mem -M $hg19_ref_bwa -p ${output_dir}/${subjectID}_interleaved_reads.fastq.gz | gzip > ${output_dir}/${subjectID}.sam.gz 2> ${output_dir}/${subjectID}.pe.log

mkdir ${tmp_folder}_rmdup

java -Xmx${heap}m -Djava.io.tmpdir\=${tmp_folder}_rmdup \
 -jar ${picard}/SortSam.jar \
 I\=${output_dir}/${subjectID}.sam.gz \
 O\=${output_dir}/${subjectID}.bam \
 SORT_ORDER=coordinate 

java -Xmx${heap}m -Djava.io.tmpdir\=${tmp_folder}_rmdup \
 -jar ${picard}/MarkDuplicates.jar \
 I\=${output_dir}/${subjectID}.bam \
 O\=${output_dir}/${subjectID}.rmdup.bam \
 M\=${output_dir}/${subjectID}.duplicate_report.txt \
 VALIDATION_STRINGENCY\=SILENT \
 REMOVE_DUPLICATES\=false

java -Xmx${heap}m -Djava.io.tmpdir\=${tmp_folder}_rmdup  \
 -jar ${picard}/AddOrReplaceReadGroups.jar \
  RGID\=id \
  RGLB\=${subjectID}.fastq \
  RGPL\=Illumina \
  RGPU\=GRP1 \
  RGSM\=${subjectID} \
  I\=${output_dir}/${subjectID}.rmdup.bam \
  O\=${output_dir}/${subjectID}.rmdup.grp.bam \
  SORT_ORDER\=coordinate \
  CREATE_INDEX\=true \
  VALIDATION_STRINGENCY\=SILENT

mv -f ${output_dir}/${subjectID}.rmdup.grp.bam ${output_dir}/${subjectID}.rmdup.bam
mv -f ${output_dir}/${subjectID}.rmdup.grp.bai ${output_dir}/${subjectID}.rmdup.bai

${bamtools} stats \
  -insert \
  -in ${output_dir}/${subjectID}.rmdup.bam \
  > ${output_dir}/${subjectID}.rmdup.stats

rm -rf ${tmp_folder}_rmdup