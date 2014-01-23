# read in clinical data, sort by age and cancer type
# args: filePathToPatientData, filePathToSampleCounts

import sys
from operator import itemgetter
from os import listdir
from os.path import isfile, join

path = sys.argv[1]

# read in sample counts
sampleCountDict = {}
countFile = open (sys.argv[2])
countData = countFile.readlines()
for line in countData:
  tokens = line.strip().split()
  sampleCountDict[tokens[1]]= int(tokens[0])
countFile.close()
files = [ f for f in listdir(path) if isfile(join(path,f)) ]
for f in files:
  if "clin" in f:
    file = open(f)
    data = file.readlines()
    file.close()
    data = data[1:]
    samples = [None]* (len(data[0].split("\t"))-1)
    sortedFields = []
    for line in data:
            tokens = line.split("\t")
            rowHeader = tokens[0].strip()
            sortedFields.append(rowHeader)
            for i in range(1,len(tokens)):
                    currentSample = samples[i-1]
                    if currentSample == None:
                            currentSample = {}
                            samples[i-1]= currentSample
                    currentSample[rowHeader] = tokens[i].strip()
    for sample in samples:
      try:
        sample["patient.daystobirth"] = int(sample["patient.daystobirth"])	
      except ValueError:
        sample["patient.daystobirth"] = -99999
    # sort samples according to age
    sortedSamples = sorted(samples, key=itemgetter("patient.daystobirth"),reverse= True)
    # print into csv sheet
    ageSortedName = f[0:f.find(".")]+"_ageSorted.csv"
    ageSortedFile  = open(ageSortedName,'w')
    idNotFound = []
    totalAge = 0
    numCounted = 0
    ageSortedFile.write("number of total patients: "+str(len(samples))+"\n")
    for sample in sortedSamples:
      barcode = sample["patient.bcrpatientbarcode"].upper()
      if barcode in sampleCountDict:
        if sampleCountDict[barcode] == 3:
          age = sample["patient.daystobirth"]
          numCounted += 1
          totalAge += age
          ageSortedFile.write(barcode+"\t"+ str(age)+"\n")
      else:
        idNotFound.append(barcode)
    if numCounted > 0:
      ageSortedFile.write("average age: "+ str(totalAge/numCounted)+"\n")
    else:
      ageSortedFile.write("average age: NA")
    #ageSortedFile.write("*** ID NOT FOUND FOR ***\n")
    #for id in idNotFound:
    #  ageSortedFile.write(id+"\n")
    ageSortedFile.close()
