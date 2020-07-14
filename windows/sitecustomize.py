import sys
import os
from os.path import abspath, dirname

# Append the invoked script dir to the library search path
invoked_file = abspath(sys.argv[0])
invoked_dir = dirname(invoked_file)
sys.path.append(invoked_dir)
