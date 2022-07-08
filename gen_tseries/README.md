# Scripts to generate single variable timeseries files

The scripts rely on ncar_pylib. This tool is deprecated by NCAR/CISL,
so these scripts may fail to work in the future.

The scripts are not self contained. They call tools written by Gary
Strand that reside in /glade/u/home/strandwg/CCP_Processing_Suite.

The tools create single variable timeseries files in subdirectories of
/glade/scratch/$USER/reshaper/$CASE. The script gen_links.sh creates
links from this directory to campaign storage so that the timeseries
files are created directly on campaign storage. This script, gen_links.sh,
should be run before other scripts.

The script run_all.sh calls run_segment.py for 25-year time segments for
all cases. The script run_segment.py calls scripts that handle output
with specific frequency output. These scripts handle, for instance, file
naming conventions for different output frequencies. Previous experience
from Mike Levy indicates that these scripts cannot be called for a single
case with different time segments simultaneously, because of temporary
files whose names are time-independent. So the workflow is to uncomment
a single call to run_segment.py in run_all.sh and run run_all.sh. When
all submitted batch jobs complete, the user should uncomment a different
call to run_segment.py in run_all.sh and run run_all.sh. This process
is repeated until all run_segment.py calls in run_all.sh have been run.
