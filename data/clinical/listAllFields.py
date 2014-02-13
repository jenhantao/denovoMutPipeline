from os import listdir
from os.path import isfile, join
import sys
# finds fields that are common to all files being considered
path = sys.argv[1]

files = [ f for f in listdir(path) if isfile(join(path,f)) ]
numFiles = 0
allFieldsCount = {}
for f in files:
  if "clin" in f:
    numFiles += 1
    file = open(f)
    currentData = file.readlines()
    for line in currentData:
      header = line.split("\t")[0]
      if header in allFieldsCount:
        allFieldsCount[header].append(f[0:f.index(".")])
      else:
        allFieldsCount[header] = [f[0:f.index(".")]]
    file.close()
commonFields = sorted(list(set(allFieldsCount.keys())))

for field in commonFields:
  print field, allFieldsCount[field]
