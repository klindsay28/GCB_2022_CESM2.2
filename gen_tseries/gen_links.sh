#!/bin/bash

# create directories and link_names so that generated tseries go directly to campaign storage

for CASE in g.e22.GOMIPECOIAF_JRA-1p4-2018.TL319_g17.GCB_2022.BCRC.001 \
            g.e22.GOMIPECOIAF_JRA-1p4-2018.TL319_g17.GCB_2022.BCRD.001 \
            g.e22.GOMIPECOIAF_JRA-1p4-2018.TL319_g17.GCB_2022.BDRC.001 \
            g.e22.GOMIPECOIAF_JRA-1p4-2018.TL319_g17.GCB_2022.BDRD.001 \
            g.e22.GOMIPECOIAF_JRA-1p4-2018.TL319_g17.GCB_2022.BCRD.002 \
            g.e22.GOMIPECOIAF_JRA-1p4-2018.TL319_g17.GCB_2022.BDRD.002 ; do
    echo CASE=$CASE

    campaign_root=/glade/campaign/cesm/development/bgcwg/projects/GCB_2022/$CASE/output
    mkdir -p $campaign_root
    cd $campaign_root
    mkdir -p {ice,ocn}/proc/tseries/month_1 ocn/proc/tseries/{day_1,year_1}

    dir=/glade/scratch/$USER/reshaper/$CASE
    mkdir -p $dir
    cd $dir
    mkdir -p {cice.h,pop.h,pop.h.nday1,pop.h.ecosys.nday1,pop.h.ecosys.nyear1}/proc

    link_name=cice.h/proc/COMPLETED
    if ! [ -e $link_name ]; then
        echo creating $link_name link
        ln -s $campaign_root/ice/proc/tseries/month_1 $link_name
    fi

    link_name=pop.h/proc/COMPLETED
    if ! [ -e $link_name ]; then
        echo creating $link_name link
        ln -s $campaign_root/ocn/proc/tseries/month_1 $link_name
    fi

    link_name=pop.h.nday1/proc/COMPLETED
    if ! [ -e $link_name ]; then
        echo creating $link_name link
        ln -s $campaign_root/ocn/proc/tseries/day_1 $link_name
    fi

    link_name=pop.h.ecosys.nday1/proc/COMPLETED
    if ! [ -e $link_name ]; then
        echo creating $link_name link
        ln -s $campaign_root/ocn/proc/tseries/day_1 $link_name
    fi

    link_name=pop.h.ecosys.nyear1/proc/COMPLETED
    if ! [ -e $link_name ]; then
        echo creating $link_name link
        ln -s $campaign_root/ocn/proc/tseries/year_1 $link_name
    fi
done
