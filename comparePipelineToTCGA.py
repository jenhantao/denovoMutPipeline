# compare mutect calls and tcga calls, compare nb_tp calls and nt_tp calls
import sys

# key mutations by chromosome_position, all lower case
# read in mega maf file
tcgaCalls = set()
mutect_nb_tp_calls = set()
mutect_nt_tp_calls = set()
with open(sys.argv[1]) as f:
	data = f.readlines()
for line in data[1:]:
	tokens = line.strip().split(",")
	position = str(int(float(tokens[3])))
	chromosome = tokens[6].lower()
	#print chromosome+ "_" + position
	tcgaCalls.add(chromosome+"_"+position)
# read in mutect  output file
# path to mutect output files
folderPath = sys.argv[2]
sampleName = folderPath.split("/")[-2]
with open(folderPath+sampleName+"_NB_TP.call_stats.out") as f:
	data = f.readlines()
for line in data[1:]:
	tokens = line.split("\t")
	chromosome = tokens[0]
	position = tokens[1]
	judgement = tokens[5]
	key = chromosome+ "_" + position
	key = key.lower()
	mutect_nb_tp_calls.add(key)
	if 

# compare keeps

# compare rejects
