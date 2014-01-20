from os import listdir
from os.path import isfile, join
import sys

path = sys.argv[1]

files = [ f for f in listdir(path) if isfile(join(path,f)) ]
