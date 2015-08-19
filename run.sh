#!/bin/bash
#This script runs the biobox for mixcr. It is referenced as the entrypoint in the Dockerfile.
echo '#=============================================='
echo 'CHECK(exit scripts if cases fail)'
# exit script if one command fails
set -o errexit
# exit script if Variable is not set
set -o nounset
echo '#=============================================='
echo 'ASSIGNING BASIC VARIABLES'
YAMLINPUT=/bbx/input/biobox.yml
DOCKEROUTPUTDIR=/bbx/output
#TASK=$1
mkdir -p ${DOCKEROUTPUTDIR}
echo '#=============================================='
echo 'CACHING PARAMETERS'
. ./inputDir/parse_yaml.sh
eval $(parse_yaml $YAMLINPUT 'mixcr_')
#create array to intake keys whose values are not false, add the values of those keys to a string 'CMD2'
CMD2=''
while read LINE; do
	if [ ${LINE:0:9} == "inputfile" ] ; then
		echo '	inside if' 
		break
	fi
	#remove - from beginning of line
	LINE=${LINE:1}
	CMD2=$CMD2$LINE' '
done <./inputDir/biobox.yml
INPUTFILE=$mixcr_inputfile
#if the input file is in csv or tsv format run conversion scripts into fasta
if [ ${INPUTFILE: -4} == ".csv" ] ; then
	#run csv conversion script
	echo '  RUNNING CSV CONVERSION'
	python conversionScripts/csv2fasta.py $INPUTFILE
	INPUTFILE=${INPUTFILE:0:${#INPUTFILE}-4}'.fasta'
elif [ ${INPUTFILE: -4} == ".tsv" ] ; then 
	#run tsv conversion script
	echo '	RUNNING TSV CONVERSION'
	python conversionScripts/tsv2fasta.py $INPUTFILE
	INPUTFILE=${INPUTFILE:0:${#INPUTFILE}-4}'.fasta'
fi
echo '#=============================================='
echo 'PROCESSING COMMAND'
CURRENTDIR=$(pwd)
echo $CURRENTDIR
echo $INPUTFILE
CMD1='export PATH=${CURRENTDIR}:$PATH && mixcr align ${INPUTFILE} output_file.vdjca && mixcr exportAlignments '
CMD3='output_file.vdjca /bbx/output/output.txt'
CMD=$CMD1$CMD2$CMD3
echo $CMD
eval $CMD
echo 'PROCESS COMPLETED'



