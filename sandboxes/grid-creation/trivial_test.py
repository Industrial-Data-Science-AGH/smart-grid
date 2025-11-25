import os
import grid2op
print(__name__)
for entry in os.environ:
    print(entry, os.environ[entry])
print(f'ver: {grid2op.__version__}')