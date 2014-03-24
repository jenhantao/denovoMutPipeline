# summarize the distribution of scores found in all sample data
import sys
from os import listdir
from os.path import isfile, join

path = sys.argv[1]
filePaths = [ f for f in listdir(path) if isfile(join(path,f))]
NB_NT_ratios = []
NB_TP_ratios = []
for filePath in filePaths:
	with open(path+filePath) as f:
		data = f.readlines()
	for line in data[1:]:
		tokens = line.strip().split("\t")
		mutationID = filePath+"_"+	

