# reads in list of ids, then prints out new file with just the rows I need
# arguments: file with list of IDs, original summary file

import sys

idFile = open(sys.argv[1])
summaryFile = open(sys.argv[2])

idData = idFile.readlines()
ids = []
for id in idData: 
	ids.append(id.strip())
idFile.close()
summaryData = summaryFile.readlines()
summaryFile.close()
# assuming all barcodes have the same length...
codeLength = len(ids[0])
print summaryData[0].strip()
for i in range(1,len(summaryData)):
	currentLine = summaryData[i]
	fullBarcode = currentLine.split("\t")[1]
	barcode = fullBarcode[0:codeLength]
	if barcode in ids:
		print currentLine.strip()
