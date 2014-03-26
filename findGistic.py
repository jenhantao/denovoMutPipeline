import sys
# inputs: path to gistic threshold file, path to list of sample+gene pairs

with open(sys.argv[1]) as f:
	gistic = f.readlines()
sampleNames = gistic[0].strip().split("\t")[3:]
for i in range(len(sampleNames)):
	tokens = sampleNames[i].split("-")
	sampleNames[i] = "-".join(tokens[:3])
gisticValuesHash = {}
for line in gistic[1:]:
	tokens = line.split("\t")
	gene = tokens[0]
	values = tokens[1:]
	for i in range(len(sampleNames)):
		sample = sampleNames[i]
		gisticValuesHash[sample+"_"+gene] = values[i]
print len(gistic)*len(sampleNames)
print len(gisticValuesHash.keys())

with open(sys.argv[2]) as f:
	searchTerms = f.readlines()[1:]

for line in searchTerms:
	tokens = line.strip().split("\t")
	if len(tokens) > 1:
		if not "-" in tokens[1]:
			sample = tokens[0]
			genes = tokens[1].replace("\"","").split(",")
			for gene in genes:
				if sample+"_"+gene in gisticValuesHash:
					gisticValue = gisticValuesHash[sample+"_"+gene]
					print sample, gene, gisticValue
				else:
					print sample, gene, "-"

		
	
