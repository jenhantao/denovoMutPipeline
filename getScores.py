# summarize the distribution of scores found in all sample data
import sys
from os import listdir
from os.path import isfile, join

path = sys.argv[1]
directories = [ f for f in listdir(path) if not isfile(join(sys.argv[1],f))]
print directories
for directory in directories:
	pass

