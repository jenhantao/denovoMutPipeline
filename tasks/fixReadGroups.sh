#! /bin/bash

mkdir -p ${tmp_folder}_readgroup

java -Xmx${heap}m -Djava.io.tmpdir\=${tmp_folder}_readgroup \
 -jar ${picard}/AddOrReplaceReadGroups.jar \
  RGLB\=${subjectID}_interleaved_reads.fastq.gz \
  RGPL\=illumina \
  RGPU\=unit \
  RGSM\=${subjectID} \
  RGID\=${subjectID} \
  I\=${output_dir}/${subjectID}.fxmt.bam \
  O\=${output_dir}/${subjectID}.fxmt.repaired.bam \
  SORT_ORDER\=coordinate \
  CREATE_INDEX\=True

# Fixme:
# RGID = unique for flow cell + lane + number : ALL READS FROM THE SAME GROUP ARE ASSUMED TO SHARE THE SAME ERROR MODEL
# RGLB = MarkDuplicates uses the LB field to determine which read groups might contain molecular duplicates, in case the same DNA library was sequenced on multiple lanes.
# RGPL = platfrom used (can get better info direct from cgquery)
# RGSM = sample that was sequenced


rm -rf ${tmp_folder}_readgroup

mv ${output_dir}/${subjectID}.fxmt.repaired.bam ${output_dir}/${subjectID}.fxmt.bam
mv ${output_dir}/${subjectID}.fxmt.repaired.bai ${output_dir}/${subjectID}.fxmt.bai
rm ${output_dir}/${subjectID}.fxmt.repaired.bam
rm ${output_dir}/${subjectID}.fxmt.repaired.bai

${samtools} index ${output_dir}/${subjectID}.fxmt.bam
