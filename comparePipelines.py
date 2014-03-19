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
	with open(sys.argv[1]+"/"+realignedFile) as f:
		realignedData = f.readlines()
	realignedPositions = []
	realignedRefAlleles = []
	realignedAltAlleles = []
	for line in realignedData:
		if not "#" in line:
			tokens = line.split()
			realignedPositions.append(tokens[0].replace("chr","")+tokens[1])
			realignedRefAlleles.append(realignedPositions[-1]+"_"+tokens[3])
			realignedAltAlleles.append(realignedPositions[-1]+"_"+tokens[3])
	realignedPositions = set(realignedPositions)
	realignedRefAlleles = set(realignedRefAlleles)
	realignedAltAlleles = set(realignedAltAlleles)
		
	
	with open(sys.argv[1]+"/"+unalignedFile) as f:
		unalignedData = f.readlines()
	unalignedPositions = []
	unalignedRefAlleles = []
	unalignedAltAlleles = []
	for line in unalignedData:
		if not "#" in line:
			tokens = line.split()
			unalignedPositions.append(tokens[0].replace("chr","")+tokens[1])
			unalignedRefAlleles.append(unalignedPositions[-1]+"_"+tokens[3])
			unalignedAltAlleles.append(unalignedPositions[-1]+"_"+tokens[3])
	unalignedPositions = set(unalignedPositions)
	unalignedRefAlleles = set(unalignedRefAlleles)
	unalignedAltAlleles = set(unalignedAltAlleles)

	print realignedFile, unalignedFile
	print "Num realigned positions: "+str(len(realignedPositions))
	print "Num unaligned positions: "+str(len(unalignedPositions))
	print "num common positions: "+str(len(realignedPositions.intersection(unalignedPositions)))
	print "num common RefAlleles: "+str(len(realignedRefAlleles.intersection(unalignedRefAlleles)))
	print "num common AltAlleles: "+str(len(realignedAltAlleles.intersection(unalignedAltAlleles)))
	print "***"	
