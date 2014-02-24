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
for line in nb_nt_data[10:]:
	tokens = line.split("\t")
	# key mutations by CHROM_POS, normal_name
	key = tokens[0] + "_" + tokens[1]
	allMutations.append(key)
	mutation = {}
	mutation["CHROM"] = tokens[0]
	mutation["POS"] = tokens[1]
	mutation["context"] = tokens[2]
	mutation["REF"] = tokens[3]
	mutation["ALT"] = tokens[4]
	mutation["QUAL"] = tokens[5]
	mutation["FILTER"] = tokens[6]
	nb_nt_mutations[key] = mutation	

nb_tp_file = open(sys.argv[2])
nb_tp_data = nb_tp_file.readlines()
nb_tp_file.close()
nb_tp_mutations = {}
for line in nb_tp_data[1:]:
	tokens = line.split("\t")
	# key mutations by CHROM_POS, normal_name
	key = tokens[0] + "_" + tokens[1]
	allMutations.append(key)
	mutation = {}
	mutation["CHROM"] = tokens[0]
	mutation["POS"] = tokens[1]
	mutation["REF"] = tokens[3]
	mutation["ALT"] = tokens[4]
	mutation["QUAL"] = tokens[5]
	mutation["FILTER"] = tokens[6]
	nb_tp_mutations[key] = mutation

nt_tp_file = open(sys.argv[3])
nt_tp_data = nt_tp_file.readlines()
nt_tp_file.close()
nt_tp_mutations = {}
for line in nt_tp_data[1:]:
	tokens = line.split("\t")
	# key mutations by CHROM_POS, normal_name
	key = tokens[0] + "_" + tokens[1]
	allMutations.append(key)
	mutation = {}
	mutation["CHROM"] = tokens[0]
	mutation["POS"] = tokens[1]
	mutation["REF"] = tokens[3]
	mutation["ALT"] = tokens[4]
	mutation["QUAL"] = tokens[5]
	mutation["FILTER"] = tokens[6]
	nt_tp_mutations[key] = mutation	
	
# sanity check all REFs should be the same
# NB_NT, NB_TP, NT_TP
allMutations = list(set(allMutations))
# given a threeway comparison, there are 8 possible outcomes. the truth table is shown below, 1 denotes an equivalent state
# NB_NT NB_TP NT_TP
# 1     1     1    # alt alleledoesn't show up
# 1     1     0    # alt allele appears in NT_TP
# 1     0     1    # alt allele appears in NB_TP
# 1     0     0    # alt allele appears in NB_TP, NT_TP
# 0     1     1    # alt allele appears in NB_NT
# 0     1     0    # alt allele appears in NB_NT, NT_TP
# 0     0     1    # alt allele appears in NB_NT, NB_TP
# 0     0     0    # ALT appears in all 3 files

triangleCounts = [0]*8 # gives the frequency of each type of comparison result in the order given in the truth table
for mutation in allMutations:
	#print mutation,nb_nt_mutations[mutation]["REF"] , nb_tp_mutations[mutation]["REF"] ,nb_nt_mutations[mutation]["REF"] , nt_tp_mutations[mutation]["REF"]
	if not (nb_nt_mutations[mutation]["REF"] == nb_tp_mutations[mutation]["REF"] and nb_nt_mutations[mutation]["REF"] == nt_tp_mutations[mutation]["REF"]):
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
		nb_nt_allele = nb_nt_mutations[mutation]["ALT"]
	if mutation in nb_tp_mutations:
		nb_tp = True
		nb_tp_allele = nb_tp_mutations[mutation]["ALT"]
	if mutation in nt_tp_mutations:
		nt_tp = True
		nt_tp_allele = nt_tp_mutations[mutation]["ALT"]
	if nb_nt:
		if nb_tp:
			if nt_tp:
				# mutation appears in all files
				triangleCounts[7] += 1
			else:
				# mutation appears in nb_nt, nb_tp
				triangleCounts[6] += 1
		else:	
			if nt_tp:
				# alt allele appears in nb_tp, nt_tp
				triangleCounts[5] += 1
			else:
				# alt allele appears in nb_nt
				triangleCounts[4] += 1
	else:
		if nb_tp:
			if nt_tp:
				# alt allele appears in nb_tp, nt_tp
				triangleCounts[3] += 1
			else:
				# alt allele appears in nb_tp, nt_tp
				triangleCounts[2] += 1
		else:	
			if nt_tp:
				alt allele appears in nt_tp
				triangleCounts[1] += 1
			else:
				# ALT doesn't appear in any of the files
				triangleCounts[0] += 1

# find mutations of interest















































