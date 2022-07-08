#!/bin/bash

for CASE in g.e22.GOMIPECOIAF_JRA-1p4-2018.TL319_g17.GCB_2022.BCRC.001 \
            g.e22.GOMIPECOIAF_JRA-1p4-2018.TL319_g17.GCB_2022.BCRD.001 ; do
    ARCHIVE_ROOT=/glade/scratch/klindsay/archive
#    ./run_segment.py --case $CASE --archive_root $ARCHIVE_ROOT --start_year 1653 --end_year 1677 --components pop cice
#    ./run_segment.py --case $CASE --archive_root $ARCHIVE_ROOT --start_year 1678 --end_year 1702 --components pop cice
#    ./run_segment.py --case $CASE --archive_root $ARCHIVE_ROOT --start_year 1703 --end_year 1727 --components pop cice
#    ./run_segment.py --case $CASE --archive_root $ARCHIVE_ROOT --start_year 1728 --end_year 1752 --components pop cice
#    ./run_segment.py --case $CASE --archive_root $ARCHIVE_ROOT --start_year 1753 --end_year 1777 --components pop cice
done

for CASE in g.e22.GOMIPECOIAF_JRA-1p4-2018.TL319_g17.GCB_2022.BCRC.001 \
            g.e22.GOMIPECOIAF_JRA-1p4-2018.TL319_g17.GCB_2022.BCRD.001 \
            g.e22.GOMIPECOIAF_JRA-1p4-2018.TL319_g17.GCB_2022.BDRC.001 \
            g.e22.GOMIPECOIAF_JRA-1p4-2018.TL319_g17.GCB_2022.BDRD.001 ; do
    ARCHIVE_ROOT=/glade/scratch/klindsay/archive
    if [[ $CASE == *"GCB_2022.BD"* ]]; then
        ARCHIVE_ROOT=/glade/scratch/mclong/archive
    fi
#    ./run_segment.py --case $CASE --archive_root $ARCHIVE_ROOT --start_year 1778 --end_year 1802 --components pop cice
#    ./run_segment.py --case $CASE --archive_root $ARCHIVE_ROOT --start_year 1803 --end_year 1827 --components pop cice
#    ./run_segment.py --case $CASE --archive_root $ARCHIVE_ROOT --start_year 1828 --end_year 1852 --components pop cice
#    ./run_segment.py --case $CASE --archive_root $ARCHIVE_ROOT --start_year 1853 --end_year 1877 --components pop cice
#    ./run_segment.py --case $CASE --archive_root $ARCHIVE_ROOT --start_year 1878 --end_year 1902 --components pop cice
#    ./run_segment.py --case $CASE --archive_root $ARCHIVE_ROOT --start_year 1903 --end_year 1927 --components pop cice
#    ./run_segment.py --case $CASE --archive_root $ARCHIVE_ROOT --start_year 1928 --end_year 1952 --components pop cice
#    ./run_segment.py --case $CASE --archive_root $ARCHIVE_ROOT --start_year 1953 --end_year 1977 --components pop cice
#    ./run_segment.py --case $CASE --archive_root $ARCHIVE_ROOT --start_year 1978 --end_year 2002 --components pop cice
done

for CASE in g.e22.GOMIPECOIAF_JRA-1p4-2018.TL319_g17.GCB_2022.BCRC.001 \
            g.e22.GOMIPECOIAF_JRA-1p4-2018.TL319_g17.GCB_2022.BDRC.001 ; do
    ARCHIVE_ROOT=/glade/scratch/klindsay/archive
    if [[ $CASE == *"GCB_2022.BD"* ]]; then
        ARCHIVE_ROOT=/glade/scratch/mclong/archive
    fi
#    ./run_segment.py --case $CASE --archive_root $ARCHIVE_ROOT --start_year 2003 --end_year 2021 --components pop cice
done

for CASE in g.e22.GOMIPECOIAF_JRA-1p4-2018.TL319_g17.GCB_2022.BCRD.001 \
            g.e22.GOMIPECOIAF_JRA-1p4-2018.TL319_g17.GCB_2022.BDRD.001 ; do
    ARCHIVE_ROOT=/glade/scratch/klindsay/archive
    if [[ $CASE == *"GCB_2022.BD"* ]]; then
        ARCHIVE_ROOT=/glade/scratch/mclong/archive
    fi
#    ./run_segment.py --case $CASE --archive_root $ARCHIVE_ROOT --start_year 2003 --end_year 2017 --components pop cice
done

for CASE in g.e22.GOMIPECOIAF_JRA-1p4-2018.TL319_g17.GCB_2022.BCRD.002 \
            g.e22.GOMIPECOIAF_JRA-1p4-2018.TL319_g17.GCB_2022.BDRD.002 ; do
    ARCHIVE_ROOT=/glade/scratch/klindsay/archive
#    ./run_segment.py --case $CASE --archive_root $ARCHIVE_ROOT --start_year 2018 --end_year 2021 --components pop cice
done
