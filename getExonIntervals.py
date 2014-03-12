'''
reads in gaf file, and produces a picard style list of exon intervals
targets in the form of <chr> <start> <stop> + <target_name>. 
These interval lists are tab-delimited. 
They are also 1-based (first position in the genome is position 1, not position 0).
'''
import sys
with open(sys.argv[1]) as f:
	data = f.readlines()
for line in data:
	tokens = line.strip().split("\t")
	if tokens[2] == "exon":
		coordinateTokens = tokens[1].split(":")
		chromosome = coordinateTokens[0][3:]
		start = coordinateTokens[1].split("-")[0]
		end = coordinateTokens[1].split("-")[1]
		strand = coordinateTokens[2]
		print str(chromosome) + "\t" + str(start) + "\t" + str(end) + "\t" + str(strand) + "\t" + str(tokens[1])

