# summarize the distribution of scores found in all sample data
import sys
from os import listdir
from os.path import isfile, join
from numpy import *
from matplotlib import pyplot as plt

path = sys.argv[1]
fileNames = [ f for f in listdir(path) if isfile(join(path,f)) and "summary" in f]
mutations = []
for fileName in fileNames:
	sampleName = fileName.split("_")[0]
	with open(path+fileName) as f:
		data = f.readlines()
	for line in data[1:]:
		tokens = line.strip().split("\t")
		if len(tokens[0]) > 1:
			mutationID = sampleName+"_"+tokens[0]
			ref = tokens[1]
			alt = tokens[2]
			nb_fractions = tuple(tokens[3].split(",")[:4])
			nt_fractions = tuple(tokens[4].split(",")[:4])
			tp_fractions = tuple(tokens[5].split(",")[:4])
			mutationData = (mutationID, ref, alt, nb_fractions, nt_fractions, tp_fractions)
			mutations.append(mutationData)
		
mutations.sort()
ratioLabels = []
NB_NT_ratios = []
NB_TP_ratios = []
NB_counts = []
NT_counts = []
TP_counts = []
nucIndexHash = {"A":0,"C":1,"G":2,"T":3}
for mutation in mutations:
	alt = mutation[2]
	nb_count = float(mutation[3][nucIndexHash[alt]])
	nt_count = float(mutation[4][nucIndexHash[alt]])
	tp_count = float(mutation[5][nucIndexHash[alt]])
	# normalize counts by the total number of reads
	nb_count = nb_count/sum(map(float, mutation[3]))
	nt_count = nt_count/sum(map(float, mutation[4]))
	tp_count = tp_count/sum(map(float, mutation[5]))

	ratioLabels.append(mutation[0])
	
	NB_counts.append(nb_count)
	NT_counts.append(nt_count)
	TP_counts.append(tp_count)
	
	if nb_count > 0.0:
		NB_NT_ratios.append(nt_count/nb_count)
	else:
		NB_NT_ratios.append(inf)
	if nb_count > 0.0:
		NB_TP_ratios.append(tp_count/nb_count)
	else:
		NB_TP_ratios.append(inf)

# plot ratios of alt alleles between nt/nb and tp/nb
if False:
	fig, ax = plt.subplots()
	width = 0.35
	rects1 = ax.bar(arange(len(NB_NT_ratios)), NB_NT_ratios, width, color='orange')
	rects2 = ax.bar(arange(len(NB_NT_ratios))+width, NB_TP_ratios, width, color='b')
	# add asterisk at inf locations
	for i in range(len(NB_counts)):
		if NB_counts[i] == 0.0:
			ax.annotate('*', xy=(i,1), xytext=(i+0.5*width, 1))

	ax.set_xticks(arange(len(NB_NT_ratios))+width)
	ax.set_xticklabels(ratioLabels, rotation = 90)
	ax.legend( (rects1[0], rects2[0]), ('NT vs NB', 'TP vs NB ') )

	plt.ylabel('Likelihood Ratio')
	plt.xlabel('sample_location')
	plt.show()
# plot raw counts of alt alleles
if False:
	NB_counts = -log(NB_counts)
	NT_counts = -log(NT_counts)
	TP_counts = -log(TP_counts)
	fig, ax = plt.subplots()
	width = 0.25
	index = arange(len(NB_counts))
	rects1 = ax.bar(index, NB_counts, width, color='orange')
	rects2 = ax.bar(index+width, NT_counts, width, color='b')
	rects3 = ax.bar(index+2*width, TP_counts, width, color='black')

	ax.set_xticks(index+2*width)
	ax.set_xticklabels(ratioLabels, rotation = 90)
	ax.legend((rects1[0], rects2[0], rects3[0]), ('NB', 'NT', 'TP') )

	plt.ylabel('Log Normalized Frequency')
	plt.xlabel('sample_location')
	plt.show()
