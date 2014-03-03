#! /bin/bash

# Note: HaplotypeCaller can take a single bam or a whole set of bams
#
# minPruning 5 - requires at least 5 reads to support the variant
# => Is this too conservative?
# -dcov 10 - no more than 10 reads starting at the same position will be included in the analyzed data
# From GATK forum: "Allowing 10 reads per sites for 100 bp reads is like allowing up to 1000x coverage at each position."

mkdir ${output_dir}/germline

# HaplotypeCaller
java -Xmx${heap}m -jar $gatk \
     -T HaplotypeCaller \
     -R $REF \
     -I ${output_dir}/${sname}.bam \
     --dbsnp $DBSNP \
     -l INFO \
     -stand_call_conf 30.0 \
     -stand_emit_conf 10.0 \
     -out_mode EMIT_VARIANTS_ONLY \
     -dcov 10 \
     -A HaplotypeScore \
     -A InbreedingCoeff \
     -A QualByDepth \
     -o ${output_dir}/germline/${sname}.raw.snvs.indels.vcf \
     -minPruning 5 \
     -L $FMFile \
     #-nct $CPUs  

 
rm -f ${output_dir}/germline/*.idx

