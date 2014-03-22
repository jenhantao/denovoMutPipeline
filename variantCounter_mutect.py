# computes statistics given three matched vcf files
# samples given to mutect in this order: normal, tumor
# things to watch out for: contaminant fraction, contaminant_lod, context for gc content?

# input three vcf files in the following order: NB_NT, NB_TP, NT_TP, sample name
import sys
path = sys.argv[1]
sampleName = path.split("/")[-2].strip()
# read in files
allMutations = []
allMutationsHash = {}
#nb_nt_file = open(sys.argv[1])
nb_nt_file = open(path + sampleName + "_NB_NT.call_stats.out")
nb_nt_data = nb_nt_file.readlines()
nb_nt_file.close()
nb_nt_mutations = {}
for line in nb_nt_data[1:]:
	tokens = line.strip().split("\t")
	# key mutations by contig_position
	key = "chr"+tokens[0].replace("chr","") + ":" + tokens[1]
	allMutations.append(key)
	mutation = {}
	mutation["contig"] = tokens[0]
	mutation["position"] = tokens[1]
	mutation["ref_allele"] = tokens[3]
	mutation["alt_allele"] = tokens[4]
	mutation["t_lod_fstar"] = tokens[18]
	mutation["t_ref_count"] = tokens[25]
	mutation["t_alt_count"] = tokens[26]
	mutation["n_ref_count"] = tokens[37]
	mutation["n_alt_count"] = tokens[38]
	mutation["normal_best_gt"] = tokens[33]
	mutation["reasons"] = tokens[49]
	mutation["judgement"] = tokens[50]
	nb_nt_mutations[key] = mutation	
	if key in allMutationsHash:
		allMutationsHash[key].append(mutation)
	else:
		allMutationsHash[key] = [mutation]

#nb_tp_file = open(sys.argv[2])
nb_tp_file = open(path + sampleName + "_NB_TP.call_stats.out")
nb_tp_data = nb_tp_file.readlines()
nb_tp_file.close()
nb_tp_mutations = {}
for line in nb_tp_data[1:]:
	tokens = line.strip().split("\t")
	# key mutations by contig_position
	key = "chr"+tokens[0].replace("chr","") + ":" + tokens[1]
	allMutations.append(key)
	mutation = {}
	mutation["contig"] = tokens[0]
	mutation["position"] = tokens[1]
	mutation["ref_allele"] = tokens[3]
	mutation["alt_allele"] = tokens[4]
	mutation["t_lod_fstar"] = tokens[18]
	mutation["t_ref_count"] = tokens[25]
	mutation["t_alt_count"] = tokens[26]
	mutation["n_ref_count"] = tokens[37]
	mutation["n_alt_count"] = tokens[38]
	mutation["normal_best_gt"] = tokens[33]
	mutation["reasons"] = tokens[49]
	mutation["judgement"] = tokens[50]
	nb_tp_mutations[key] = mutation
	if key in allMutationsHash:
		allMutationsHash[key].append(mutation)
	else:
		allMutationsHash[key] = [mutation]

#nt_tp_file = open(sys.argv[3])
nt_tp_file = open(path + sampleName + "_NT_TP.call_stats.out")
nt_tp_data = nt_tp_file.readlines()
nt_tp_file.close()
nt_tp_mutations = {}
for line in nt_tp_data[1:]:
	tokens = line.strip().split("\t")
	# key mutations by contig_position
	key = "chr"+tokens[0].replace("chr","") + ":" + tokens[1]
	allMutations.append(key)
	mutation = {}
	mutation["contig"] = tokens[0]
	mutation["position"] = tokens[1]
	mutation["ref_allele"] = tokens[3]
	mutation["alt_allele"] = tokens[4]
	mutation["t_lod_fstar"] = tokens[18]
	mutation["t_ref_count"] = tokens[25]
	mutation["t_alt_count"] = tokens[26]
	mutation["n_ref_count"] = tokens[37]
	mutation["n_alt_count"] = tokens[38]
	mutation["normal_best_gt"] = tokens[33]
	mutation["reasons"] = tokens[49]
	mutation["judgement"] = tokens[50]
	nt_tp_mutations[key] = mutation	
	if key in allMutationsHash:
		allMutationsHash[key].append(mutation)
	else:
		allMutationsHash[key] = [mutation]
	
# NB_NT, NB_TP, NT_TP
allMutations = list(set(allMutations))
# given a threeway comparison, there are 8 possible outcomes. the truth table is shown below, 1 denotes an equivalent state
# NB_NT NB_TP NT_TP
# 1     1     1    # alt allele doesn't show up
# 1     1     0    # alt allele appears in NT_TP
# 1     0     1    # alt allele appears in NB_TP
# 1     0     0    # alt allele appears in NB_TP, NT_TP
# 0     1     1    # alt allele appears in NB_NT
# 0     1     0    # alt allele appears in NB_NT, NT_TP
# 0     0     1    # alt allele appears in NB_NT, NB_TP
# 0     0     0    # alt_allele appears in all 3 files


triangleCountsAll = [[] for i in range(8)]# gives the frequency of each type of comparison result in the order given in the truth table
triangleCountsReject= [[] for i in range(8)]# gives the frequency of each type of comparison result in the order given in the truth table
triangleCountsKeep =  [[] for i in range(8)]## gives the frequency of each type of comparison result in the order given in the truth table
for mutation in allMutations:
	# count triangles
	nb_nt = False
	nb_tp = False
	nt_tp = False
	nb_nt_keep = False
	nb_tp_keep = False
	nt_tp_keep = False
	nb_nt_allele = None
	nb_tp_allele = None
	nt_tp_allele = None
	if mutation in nb_nt_mutations:
		nb_nt = True
		nb_nt_allele = nb_nt_mutations[mutation]["alt_allele"]
		if nb_nt_mutations[mutation]["judgement"] == "KEEP":
			nb_nt_keep = True
	if mutation in nb_tp_mutations:
		nb_tp = True
		nb_tp_allele = nb_tp_mutations[mutation]["alt_allele"]
		if nb_tp_mutations[mutation]["judgement"] == "KEEP":
			nb_tp_keep = True
	if mutation in nt_tp_mutations:
		nt_tp = True
		nt_tp_allele = nt_tp_mutations[mutation]["alt_allele"]
		if nt_tp_mutations[mutation]["judgement"] == "KEEP":
			nt_tp_keep = True
	if nb_nt:
		if nb_tp:
			if nt_tp:
				# mutation appears in all files
				triangleCountsAll[7].append(mutation)
				if nb_nt_keep and nb_tp_keep and nt_tp_keep:
					triangleCountsKeep[7].append(mutation)
				if not nb_nt_keep and not nb_tp_keep and not nt_tp_keep:
					triangleCountsReject[7].append(mutation)
					
			else:
				# mutation appears in nb_nt, nb_tp
				triangleCountsAll[6].append(mutation)
				if nb_nt_keep and nb_tp_keep:
					triangleCountsKeep[6].append(mutation)
				if not nb_nt_keep and not nb_tp_keep:
					triangleCountsReject[6].append(mutation)
		else:	
			if nt_tp:
				# alt allele appears in nb_nt, nt_tp
				triangleCountsAll[5].append(mutation)
				if nb_nt_keep and nt_tp_keep:
					triangleCountsKeep[5].append(mutation)
				if not nb_nt_keep and not nt_tp_keep:
					triangleCountsReject[5].append(mutation)
			else:
				# alt allele appears in nb_nt
				triangleCountsAll[4].append(mutation)
				if nb_nt_keep:
					triangleCountsKeep[4].append(mutation)
				if not nb_nt_keep:
					triangleCountsReject[4].append(mutation)
	else:
		if nb_tp:
			if nt_tp:
				# alt allele appears in nb_tp, nt_tp
				triangleCountsAll[3].append(mutation)
				if nb_tp_keep and nt_tp_keep:
					triangleCountsKeep[3].append(mutation)
				if not nb_tp_keep and not nt_tp_keep:
					triangleCountsReject[3].append(mutation)
			else:
				# alt allele appears in nb_tp
				triangleCountsAll[2].append(mutation)
				if nb_tp_keep:
					triangleCountsKeep[2].append(mutation)
				if not nb_tp_keep:
					triangleCountsReject[2].append(mutation)
		else:	
			if nt_tp:
				#alt allele appears in nt_tp
				triangleCountsAll[1].append(mutation)
				if nt_tp_keep:
					triangleCountsKeep[1].append(mutation)
				if not nt_tp_keep:
					triangleCountsReject[1].append(mutation)
			else:
				# alt_allele doesn't appear in any of the files
				triangleCountsAll[0].append(mutation)
				triangleCountsKeep[0].append(mutation)
				triangleCountsReject[0].append(mutation)
# find mutations of interest

countsFile = open(sampleName+"_counts.tsv","w")
countsFile.write("all SNPs"+"\n")
countsFile.write('\t'.join(map(str,[ len(cell) for cell in triangleCountsAll]))+"\n")
countsFile.write("all KEEP SNPs"+"\n")
countsFile.write('\t'.join(map(str,[len(cell) for cell in triangleCountsKeep]))+"\n")
countsFile.write("all REJECT SNPs"+"\n")
countsFile.write('\t'.join(map(str,[len(cell) for cell in triangleCountsReject]))+"\n")

#columns = ["%5s" % cell for cell in line]
#    print ' '.join(columns)

# print mutations out in a csv
outputFile = open(sampleName+"_summary.tsv","w")
outputFile.write("position\tref_allele\talt_allele\tt_lod_fstart\tt_ref_count\tt_alt_count\tn_ref_count\tn_alt_count\tnormal_best_gt\treasons\tjudgement\n")
for mut in triangleCountsAll[6]:
	currentMutations = allMutationsHash[mut]
	outputFile.write(mut+"\t"+currentMutations[0]["ref_allele"]+"\t"+currentMutations[0]["alt_allele"]+"\t"+currentMutations[0]["t_lod_fstar"]+"\t"+currentMutations[0]["t_ref_count"]+"\t"+currentMutations[0]["t_alt_count"]+"\t"+currentMutations[0]["n_ref_count"]+"\t"+currentMutations[0]["n_alt_count"]+"\t"+currentMutations[0]["normal_best_gt"]+"\t"+currentMutations[0]["reasons"]+"\t"+currentMutations[0]["judgement"]+"\n")
	for mutation in currentMutations[1:]:
		outputFile.write("\t"+mutation["ref_allele"]+"\t"+mutation["alt_allele"]+"\t"+mutation["t_lod_fstar"]+"\t"+mutation["t_ref_count"]+"\t"+mutation["t_alt_count"]+"\t"+mutation["n_ref_count"]+"\t"+mutation["n_alt_count"]+"\t"+mutation["normal_best_gt"]+"\t"+mutation["reasons"]+"\t"+mutation["judgement"]+"\n")



#	mutation["ref_allele"] = tokens[3]
#	mutation["alt_allele"] = tokens[4]
#	mutation["t_lod_fstar"] = tokens[18]
#	mutation["t_ref_count"] = tokens[25]
#	mutation["t_alt_count"] = tokens[26]
#	mutation["n_ref_count"] = tokens[37]
#	mutation["n_alt_count"] = tokens[38]
#	mutation["normal_best_gt"] = tokens[33]
#	mutation["reasons"] = tokens[49]
#	mutation["judgement"] = tokens[50]
#








