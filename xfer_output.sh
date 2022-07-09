#!/bin/bash

# transfer log and non-netCDF POP hist files to campaign storage

for CASE in g.e22.GOMIPECOIAF_JRA-1p4-2018.TL319_g17.GCB_2022.BCRC.001 \
            g.e22.GOMIPECOIAF_JRA-1p4-2018.TL319_g17.GCB_2022.BCRD.001 \
            g.e22.GOMIPECOIAF_JRA-1p4-2018.TL319_g17.GCB_2022.BDRC.001 \
            g.e22.GOMIPECOIAF_JRA-1p4-2018.TL319_g17.GCB_2022.BDRD.001 \
            g.e22.GOMIPECOIAF_JRA-1p4-2018.TL319_g17.GCB_2022.BCRD.002 \
            g.e22.GOMIPECOIAF_JRA-1p4-2018.TL319_g17.GCB_2022.BDRD.002 ; do
    echo CASE=$CASE

    DOUT_S=/glade/scratch/klindsay/archive/$CASE
    if [[ $CASE == *"GCB_2022.BD"*".001" ]]; then
        DOUT_S=/glade/scratch/mclong/archive/$CASE
    fi

    campaign_root=/glade/campaign/cesm/development/bgcwg/projects/GCB_2022/$CASE

    cd $DOUT_S/logs
    campaign_dir=$campaign_root/output/logs
    echo copying log files to $campaign_dir
    mkdir -p $campaign_dir
    cp -p *.log.* $campaign_dir

    cd $DOUT_S/ocn/hist
    campaign_dir=$campaign_root/output/ocn/hist
    echo copying non-netCDF POP files to $campaign_dir
    mkdir -p $campaign_dir
    cp -p $CASE.pop.{dd,do,dt,dv}.* $campaign_dir
done
