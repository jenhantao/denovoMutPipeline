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
with open(sys.argv[2]) as f:
	data = f.readlines()
for line in data[1]:
	tokens = line.split("\t")
	if "chr" in tokens[0]:
		print tokens[0].replace("chr","").replace(":","_")

# compare keeps

# compare rejects
