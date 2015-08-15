#!/bin/bash
#This script runs the biobox for mixcr. It is referenced as the entrypoint in the Dockerfile.
#==============================================
echo 'CHECK: exit scripts if cases fail'
# exit script if one command fails
set -o errexit
# exit script if Variable is not set
set -o nounset
#==============================================
echo 'ASSIGNING BASIC VARIABLES'
INPUT=/bbx/input/biobox.yml
OUTPUT=/bbx/output
#TASK=$1
mkdir -p ${OUTPUT}
#==============================================
echo 'CACHING PARAMETERS'
#Parse the input yaml file and read the parameters
#echo 'biobox.yml:'
#cat ./inputDir/biobox.yml
. ./inputDir/parse_yaml.sh
eval $(parse_yaml $INPUT 'mixcr_')

GERMLINESEQDIR=$mixcr_germlineSeqDir
INPUTFILE=$mixcr_inputfile
OUTPUTFILE=$mixcr_outputfile

#echo $GERMLINESEQDIR
#echo $INPUTFILE
#echo $OUTPUTFILE

#if the input file is in csv or tsv format run conversion scripts into fasta
if [ ${INPUTFILE: -4} == ".csv" ] ; then
	#run csv conversion script
	echo '  RUNNING CSV CONVERSION'
	python python/csv2fasta.py $INPUTFILE
	#ls
	#echo '==='
	#ls inputDir
	INPUTFILE=${INPUTFILE:0:${#INPUTFILE}-4}'.fasta'
elif [ ${INPUTFILE: -4} == ".tsv" ] ; then 
	#run tsv conversion script
	echo '	RUNNING TSV CONVERSION'
	python python/tsv2fasta.py $INPUTFILE
	INPUTFILE=${INPUTFILE:0:${#INPUTFILE}-4}'.fasta'
fi
#echo $INPUTFILE
#INPUTFILE=./inputDir/
#ls inputDir
#echo '==='
#ls 
#==============================================
#echo 'GENERATING TASKFILE'
#echo -n 'default: mixcr align ${INPUTFILE} output_file.vdjca && mixcr exportAlignments output_file.vdjca ${OUTPUTFILE}' >> ./Taskfile
#ls
#echo 'Taskfile: '
#cat Taskfile
#==============================================
#CMD=$(egrep ^${TASK}: ./Taskfile | cut -f 2 -d ':')
#if [[ -z ${CMD} ]]; then
#	echo "Abort, no task found for '${TASK}'."
#	exit 1
#fi
echo 'PROCESSING COMMAND'
#echo $(pwd)
ls
ls outputDir
#ls inputDir
#CMD1='export PATH='$(pwd)':$PATH'
#CMD2='mixcr align'$INPUTFILE'./outputDir/output_file.vdjca'
#CMD3='mixcr exportAlignments ./outputDir/output_file.vdjca' $OUTPUTFILE
echo $(pwd)
echo $INPUTFILE
echo $OUTPUTFILE
CMD='export PATH='$(pwd)':$PATH && mixcr align'$INPUTFILE'./outputDir/output_file.vdjca && mixcr exportAlignments ./outputDir/output_file.vdjca'$OUTPUTFILE
echo $CMD
eval $CMD

echo 'PROCESS COMPLETED'


