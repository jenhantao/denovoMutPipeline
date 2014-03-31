# summarize the distribution of scores found in all sample data
import sys
from os import listdir
from os.path import isfile, join

path = sys.argv[1]
fileNames = [ f for f in listdir(path) if isfile(join(path,f)) and "counts" in f]
mutations = []
header = None
outFile = open(sys.argv[2],'w')
toWrite = []
outFile.write("Sample Name\tType\t1\t2\t3\t4\t5\t6\t7\t8\n")
for fileName in fileNames:
	print fileName
	sampleName = fileName.split("_")[0]
	with open(path+fileName) as f:
		data = f.readlines()
	outFile.write(sampleName+"\tKEEP\t"+data[3])		
	outFile.write(sampleName+"\tALL\t"+data[1])		
		
for line in toWrite:
	outFile.write(line)
