#!/bin/bash -l
#
#PBS -A P93300670
#PBS -l select=1:ncpus=8:mpiprocs=8:mem=16GB
#PBS -l walltime=6:00:00
#PBS -q casper
#
conda deactivate || echo "conda not loaded"
#
NODES=8 ; export NODES
# PARSE COMMAND LINE ARGUMENTS
# (If variables aren't already defined thanks to qsub)
if [ -z "${CASE}" ] && [ -z "${ARCHIVE_ROOT}" ] && [ -z "${START_YEAR}" ] && [ -z "${END_YEAR}" ] && [ -z "${COMPONENT}" ]; then
  if [ $# != 5 ]; then
    echo "ERROR: got $# arguments"
    echo "usage: $0 CASE ARCHIVE_ROOT START_YEAR END_YEAR COMPONENT"
    exit 1
  fi

  CASE=${1} ; export CASE
  ARCHIVE_ROOT=${2}
  START_YEAR=${3}
  END_YEAR=${4}
  COMPONENT=${5}
fi
echo "Reshaping ${COMPONENT} output for years ${START_YEAR} through ${END_YEAR} for ${CASE}..."
#
source /etc/profile.d/modules.sh
module purge
module load python/3.7.9
module load ncarenv
module load nco #/4.9.5
module load intel #/19.0.5
module load openmpi/4.1.0
ncar_pylib
#
case "$COMPONENT" in
  cam )
    HIST=cam.h2 ;;
  * )
    echo "Unknown component ${COMPONENT}"
    exit 1 ;;
esac
export HIST

#
NCKS=`which ncks`  ; export NCKS
PROCHOST=`hostname`;export PROCHOST
#
BASEDIR=/glade/u/home/strandwg/CCP_Processing_Suite
LOCALDSK=${ARCHIVE_ROOT}/${CASE} ; export LOCALDSK
PROCBASE=/glade/scratch/$USER/reshaper/${CASE}     ; export PROCBASE
#
HTYP=`echo $HIST | cut -d'.' -f1` ; export HTYP
case "$HTYP" in
  cam2 | cam )
    COMP_NAME=atm ;;
  cism )
    COMP_NAME=glc ;;
  clm2 )
     COMP_NAME=lnd ;;
  pop  )
    COMP_NAME=ocn ;;
  rtm | mosart )
    COMP_NAME=rof ;;
  cice | csim )
    COMP_NAME=ice ;;
  * )
    echo "Unable to continue because "$HIST" not known."
    exit 1 ;;
esac
#
LOCAL_HIST=${LOCALDSK}/${COMP_NAME}/hist ; export LOCAL_HIST
LOCAL_PROC=${PROCBASE}/${HIST}/proc      ; export LOCAL_PROC
CACHEDIR=${LOCAL_PROC}/COMPLETED         ; export CACHEDIR
#
VERBOSITY=0 ; export VERBOSITY
PREFIX="${CACHEDIR}/${CASE}.${HIST}." ; export PREFIX
NCFORMAT=netcdf4c ; export NCFORMAT ; export NCFORMAT
#
if [ ! -d $LOCAL_PROC ] ; then
 mkdir -p $LOCAL_PROC
fi
if [ ! -d $CACHEDIR ] ; then
 mkdir -p $CACHEDIR
fi
#
cd $LOCAL_PROC
ln -s -f $BASEDIR/run_slice2series_dav Transpose_Data
#
rm -f ${CASE}.${HIST}.*nc
if [ ! -f ${LOCAL_PROC}/.DONE.${CASE}.${HIST}.${START_YEAR}_${END_YEAR} ] ; then
  HISTF=
  for THIS_YEAR in $(seq ${START_YEAR} ${END_YEAR}) ; do
    YEAR=$(printf "%04d" ${THIS_YEAR})
    echo "YEAR: ${YEAR}"
    echo "LINKING FROM ${LOCAL_HIST}"
    ln -s -f ${LOCAL_HIST}/${CASE}.${HIST}.${YEAR}*nc .
    HISTF+="${CASE}.${HIST}.${YEAR}*nc "
  done
  NHISTF=`/bin/ls ${HISTF} | wc -l`
  OUTTIME="${START_YEAR}010100Z-${END_YEAR}123118Z"
  SUFFIX=".${OUTTIME}.nc" ; export SUFFIX
  echo -n "TS transpose_data start: " ; date
  ./Transpose_Data
  if [ $? -ne 0 ] ; then
    echo "Transpose_Data failed"
    exit 1
  fi
  echo -n "TS transpose_data end  : " ; date
  touch ${LOCAL_PROC}/.DONE.${CASE}.${HIST}.${START_YEAR}_${END_YEAR}
fi
#
echo -n "TS COMPLETE: " ; date
#
exit
