# computes statistics given three matched vcf files
# samples given to mutect in this order: normal, tumor
# things to watch out for: contaminant fraction, contaminant_lod, context for gc content?

# input three vcf files in the following order: NB_NT, NB_TP, NT_TP, sample name
import sys
sampleName = sys.argv[4]
# read in files
allMutations = []
nb_nt_file = open(sys.argv[1])
nb_nt_data = nb_nt_file.readlines()
nb_nt_file.close()
nb_nt_mutations = {}
for line in nb_nt_data[1:]:
	tokens = line.split("\t")
	# key mutations by contig_position, normal_name
	key = tokens[0] + "_" + tokens[1]
	allMutations.append(key)
	mutation = {}
	mutation["contig"] = tokens[0]
	mutation["position"] = tokens[1]
	mutation["context"] = tokens[2]
	mutation["ref_allele"] = tokens[3]
	mutation["alt_allele"] = tokens[4]
	mutation["dbsnp_site"] = tokens[8]
	mutation["tumor_power"] = tokens[11]
	mutation["normal_power"] = tokens[12]
	mutation["t_lod_fstar"] = tokens[16] # t_lod_fstar (likelihood tumor event is real / likelihood event is sequencing error) is the core statistic
	mutation["tumor_f"] = tokens[17]
	mutation["contaminant_fraction"] = tokens[18]
	mutation["contaminant_lod"] = tokens[19]
	nb_nt_mutations[key] = mutation	

nb_tp_file = open(sys.argv[2])
nb_tp_data = nb_tp_file.readlines()
nb_tp_file.close()
nb_tp_mutations = {}
for line in nb_tp_data[1:]:
	tokens = line.split("\t")
	# key mutations by contig_position, normal_name
	key = tokens[0] + "_" + tokens[1]
	allMutations.append(key)
	mutation = {}
	mutation["contig"] = tokens[0]
	mutation["position"] = tokens[1]
	mutation["context"] = tokens[2]
	mutation["ref_allele"] = tokens[3]
	mutation["alt_allele"] = tokens[4]
	mutation["dbsnp_site"] = tokens[8]
	mutation["tumor_power"] = tokens[11]
	mutation["normal_power"] = tokens[12]
	mutation["t_lod_fstar"] = tokens[16] 
	mutation["tumor_f"] = tokens[17]
	mutation["contaminant_fraction"] = tokens[18]
	mutation["contaminant_lod"] = tokens[19]
	nb_tp_mutations[key] = mutation

nt_tp_file = open(sys.argv[3])
nt_tp_data = nt_tp_file.readlines()
nt_tp_file.close()
nt_tp_mutations = {}
for line in nt_tp_data[1:]:
	tokens = line.split("\t")
	# key mutations by contig_position, normal_name
	key = tokens[0] + "_" + tokens[1]
	allMutations.append(key)
	mutation = {}
	mutation["contig"] = tokens[0]
	mutation["position"] = tokens[1]
	mutation["context"] = tokens[2]
	mutation["ref_allele"] = tokens[3]
	mutation["alt_allele"] = tokens[4]
	mutation["dbsnp_site"] = tokens[8]
	mutation["tumor_power"] = tokens[11]
	mutation["normal_power"] = tokens[12]
	mutation["t_lod_fstar"] = tokens[16] 
	mutation["tumor_f"] = tokens[17]
	mutation["contaminant_fraction"] = tokens[18]
	mutation["contaminant_lod"] = tokens[19]
	nt_tp_mutations[key] = mutation	
	
# sanity check all ref_alleles should be the same
# NB_NT, NB_TP, NT_TP
allMutations = list(set(allMutations))
# given a threeway comparison, there are 8 possible outcomes. the truth table is shown below, 1 denotes an equivalent state
# NB NT TP
# 1  1  1 # mutation doesn't show in any of the files
# 1  1  0 # mutation shows in nb_tp, nt_tp, no match
# 1  0  1 # mutation shows in nb_nt, nt_tp, no match
# 1  0  0 # mutation appears in all files, no match
# 0  1  1 # mutation appears in nb_nt, nb_tp, no match <- this is the interesting one
# 0  1  0 # mutation appears in all files, no match
# 0  0  1 # mutation appears in all files, no match
# 0  0  0 # appears in all files, no matches

triangleCounts = [0]*8 # gives the frequency of each type of comparison result in the order given in the truth table
for mutation in allMutations:
	#print mutation,nb_nt_mutations[mutation]["ref_allele"] , nb_tp_mutations[mutation]["ref_allele"] ,nb_nt_mutations[mutation]["ref_allele"] , nt_tp_mutations[mutation]["ref_allele"]
	if not (nb_nt_mutations[mutation]["ref_allele"] == nb_tp_mutations[mutation]["ref_allele"] and nb_nt_mutations[mutation]["ref_allele"] == nt_tp_mutations[mutation]["ref_allele"]):
		print "ref alleles don't match for: "+mutation 
	# count triangles
	nb_nt = False
	nb_tp = False
	nt_tp = False
	nb_nt_allele = "nb_nt"
	nb_tp_allele = "nb_tp"
	nt_tp_allele = "nt_tp"
	if mutation in nb_nt_mutations:
		nb_nt = True
		nb_nt_allele = nb_nt_mutations[mutation]["alt_allele"]
	if mutation in nb_tp_mutations:
		nb_tp = True
		nb_tp_allele = nb_tp_mutations[mutation]["alt_allele"]
	if mutation in nt_tp_mutations:
		nt_tp = True
		nt_tp_allele = nt_tp_mutations[mutation]["alt_allele"]
	# mutation doesn't show in any of the files
	if not nb_nt and not nb_tp and not nt_tp:
		triangleCounts[0] += 1
	# mutation shows in nb_tp, nt_tp, no match
	elif not nb_nt and nb_tp and nt_tp
		triangleCounts[1] += 1
	
# find mutations of interest



