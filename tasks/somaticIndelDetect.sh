#! /bin/bash

# Documentation for somatic indel detector here:
# http://www.broadinstitute.org/gatk/gatkdocs/org_broadinstitute_sting_gatk_walkers_indels_SomaticIndelDetector.html

# Note: This does not take known indels as an input: works best if tumor normal simultaneously realingned around indels first

java -Xmx${heap}m -jar ${gatk2} \
  -T SomaticIndelDetector \
  -R $REF \
  -o ${output_dir}/${sname}.raw.indels.vcf \
  -verbose ${output_dir}/${sname}.indels.txt\
  -I:normal ${output_dir}/${subjectID}_${normal}.bam \
  -I:tumor ${output_dir}/${subjectID}_${tumor}.bam