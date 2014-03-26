# summarize the distribution of scores found in all sample data
import sys
from os import listdir
from os.path import isfile, join
from numpy import *
from matplotlib import pyplot as plt

path = sys.argv[1]
fileNames = [ f for f in listdir(path) if isfile(join(path,f)) and "summary" in f]
mutations = []
header = None
outFile = open(sys.argv[2],'w')
toWrite = []
for fileName in fileNames:
	print "*****"
	print fileName
	sampleName = fileName.split("_")[0]
	with open(path+fileName) as f:
		data = f.readlines()
	if header == None:
		header = "sample name\t"+data[0]
	if len(data) > 1:
		toAdd = []
		for i in range(0,len(data[1:]),2):
			print i
			toAdd.append((data[i+1], data[i+2]))
		toAdd = sorted(toAdd)
		toAddArray = []
		for i in range(len(toAdd)):
			toAddArray.append(sampleName + "\t" + toAdd[i][0])
			toAddArray.append(sampleName + "\t" + toAdd[i][1])
		print len(toAddArray)
		print toAddArray
		toWrite += toAddArray
print len(toWrite)
		
for line in toWrite:
	outFile.write(line)
