import sys
with open (sys.argv[1]) as f:
	data = f.readlines()
sampleNames = []
typeSampleHash = {}

NBSamples = []
NTSamples = []
TPSamples = []

typeSampleHash["NT"] = NTSamples
typeSampleHash["NB"] = NBSamples
typeSampleHash["TP"] = TPSamples

# read in data
for i in range(len(data)):
	line = data[i]
	if "single" in line:
		tokens = line.strip().split()
		sampleType = tokens[-1]
		uuid = tokens[2].split("/")[-1]
		sampleName = tokens[-2]
		if not sampleName in sampleNames:
			sampleNames.append(sampleName)
		if sampleType == "NT":
			NTSamples.append(uuid)
		elif sampleType == "NB":
			NBSamples.append(uuid)
		elif sampleType == "TP":
			TPSamples.append(uuid)

# build arrays that will be fed to sge script
outputSampleNames = []
outputNormalTypes = []
outputTumorTypes = []
outputNormalSamples = []
outputTumorSamples =[]
normalTypes = ["NB","NT"]
tumorTypes = ["NT","TP"]
for normalType in normalTypes:
	for tumorType in tumorTypes:
		if not normalType == tumorType:
			normalSamples = typeSampleHash[normalType]
			tumorSamples = typeSampleHash[tumorType]
			for i in range(len(sampleNames)):
				outputSampleNames.append(sampleNames[i])
				outputNormalTypes.append(normalType)
				outputTumorTypes.append(tumorType)
				outputNormalSamples.append(normalSamples[i])
				outputTumorSamples.append(tumorSamples[i])
				
print "set normalSamples= ("+ " ".join(outputNormalSamples)+")"
print "set tumorSamples= ("+ " ".join(outputTumorSamples)+")"
print "set sampleNames= ("+ " ".join(outputSampleNames)+")"
print "set normalTypes= ("+ " ".join(outputNormalTypes)+")"
print "set tumorTypes= ("+ " ".join(outputTumorTypes)+")"
