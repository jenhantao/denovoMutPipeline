# reads in list of ids, then prints out new file with just the rows I need
# arguments: file with list of IDs, original runscript

import sys

idFile = open(sys.argv[1])
runFile = open(sys.argv[2])

idData = idFile.readlines()
ids = []
for id in idData: 
	ids.append(id.strip())
idFile.close()
runData = runFile.readlines()
runFile.close()
# assuming all barcodes have the same length...
codeLength = len(ids[0])
# find relevant lines
relevantLines = []
for i in range(0,len(runData)):
	currentLine = runData[i]
	barcodeIndex = currentLine.find("TCGA-")
	barcode = currentLine[barcodeIndex:barcodeIndex+codeLength]
	if barcode in ids:
		relevantLines.append(currentLine.strip())
for i in range(0,len(relevantLines),8):
	for j in range(i,i+8):
		print relevantLines[j]
		if j == i+4:
			newLine = relevantLines[i+5]
			newLine = newLine.replace("TP","NT")
			print newLine
