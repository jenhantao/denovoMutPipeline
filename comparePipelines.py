import sys
from os import listdir
from os.path import isfile, join

realignedFiles = [ f for f in listdir(sys.argv[1]) if isfile(join(sys.argv[1],f)) and "forSnpEff.snvs.vcf" in f]
unalignedFiles = [ f for f in listdir(sys.argv[2]) if isfile(join(sys.argv[2],f)) and "forSnpEff.snvs.vcf" in f]
realignedFiles.sort()
unalignedFiles.sort()
print realignedFiles
print unalignedFiles
# arguments: path to realigned set of vcf files, path to unaligned set of vcf files

for i in range(len(realignedFiles)):
	realignedFile = realignedFiles[i]
	unalignedFile = unalignedFiles[i]
	with open(realignedFiles) as f:
		realignedData = `	

