# read in clinical data, sort by age and cancer type
# args: filePath, number of candidates

import sys

path = sys.argv[1]
file = open(path)
data = file.readlines()
data = data[1:]
samples = [None]* (len(data[0].split("\t"))-1)
for line in data:
	tokens = line.split("\t")
	rowHeader = tokens[0].strip()
	for i in range(1,len(tokens)):
		currentSample = samples[i-1]
		if currentSample == None:
			currentSample = {}
			samples[i-1]= currentSample
		currentSample[rowHeader] = tokens[i].strip()
patient.agebegansmokinginyears
patient.birthcontrolpillhistoryusagecategory
patient.clinicalcqcf.daystodeath
patient.daystobirth
patient.daystodeath
patient.race
patient.stageevent.clinicalstage
patient.weight
patient.yearofinitialpathologicdiagnosis
patient.ageatinitialpathologicdiagnosis
patient.agebegansmokinginyears

for sample in samples:
	# remove samples containing serious values
	if "patient.chemicalexposuretext" in sample:
		if  

# sort samples according to age

# print into csv sheet
