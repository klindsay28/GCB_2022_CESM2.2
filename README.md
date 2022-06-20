# GCB_2022_CESM2.2
CESM participation in Global Carbon Budget 2022: scripts, notebooks, documentation, ....

Ocean model contributions to Global Carbon Budget 2022 (GCB_2022) consists of 4 experiments:

GCB_2022 Notation | CESM CO2 Notation | Carbon Cycle CO2 | Climate Forcing
:---------------: | :---------------: | :--------------: | :-------------:
A                 | BDRD              | varying          | varying
B                 | BCRC              | constant         | constant
C                 | BDRC              | varying          | constant
D                 | BCRD              | constant         | varying

Output is requested for years 1959-2021 (2 tier 3 output variables are requested back to 1850).

The CESM contribution uses the JRA55 forcing, repeating the forcing 1958-2018 6 times.
The model years for this forcing are 1653-2018.
The 6th cycle is extended with forcing from years 2019-2021.
Constant forcing experiments use JRA55 1990/1991 repeat year forcing.

The GCB_2022 specified value for constant CO2 concentration is 278 ppm.
In the GCB_2022 prescribed CO2 forcing, this value occurs mid-1777.
So we start the BDR[CD] experiments at 1778-01-01,
initializing them from the analogous BCR[CD] expriments at 1778-01-01.

Each GCB_2022 experiment is done with 2 CESM experiments:

Experiment Number | BC Year Range | BD Year Range
:---------------: | :-----------: | :-----------:
001               | 1653-2017     | 1778-2017
002               | 2018-2021     | 2018-2021

Note that experiment 001 does not run a full 6th cycle of the JRA forcing, it stops at 2018-01-01.
This is to ensure that cycling of forcing that would occur at the end of 2018 does not lead to
using 1958 forcing at the end of 2018.

## Throughput and Computational Cost

The experiments are being run on 23 nodes.
Note that this is larger than the default of 14 nodes for ocean-ice experiments on the gx1v7 grid.
This enables a throughput of ~40 years per wall clock day on cheyenne.
If experiments are run concurrently where possible,
it will take 9-10 wall clock days to run all experiments,
neglecting wait time in the queue.

The computational cost of this configuration is ~500 core-hours per year on cheyenne.
The total cost of all runs is approximately

500 * ( 2 * (2021-1653+1) + 2 * (2021-1778+1) ) = 613000 core-hours.
