# computes statistics given three matched vcf files
# samples given to mutect in this order: normal, tumor
# input three vcf files in the following order: NB_NT, NB_TP, NT_T
# key mutations by contig_position, normal_name
# meta data to keep: dbsnp_site, covered, tumor_power, normal_power
# sanity check all ref_alleles should be the same
# actually compairing alt_alleles
# t_lod_fstar (likelihood tumor event is real / likelihood event is sequencing error) is the core statistic
# things to watch out for: contaminant fraction, contaminant_lod, context for gc content?
