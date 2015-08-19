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
#$CMD2 will be a string containing the specified command line arguments from $YAMLINPUT 
CMD2=''
while read LINE; do
	if [ ${LINE:0:9} == "inputfile" ] ; then
		#echo '	inside if' 
		break
	fi
	#remove '-' from beginning of line
	LINE=${LINE:1}
	#concatenation
	CMD2=$CMD2$LINE' '
done <./inputDir/biobox.yml
INPUTFILE=$mixcr_inputfile
#if the input file is in csv or tsv format run conversion scripts into fasta
#echo ${INPUTFILE: -5}
if [ ${INPUTFILE: -5} == ".csv" ] ; then
	#run csv conversion script
	echo '  RUNNING CSV CONVERSION'
	python conversionScripts/csv2fasta.py $INPUTFILE
	INPUTFILE=${INPUTFILE:0:${#INPUTFILE}-5}'.fasta'
elif [ ${INPUTFILE: -5} == ".tsv" ] ; then 
	#run tsv conversion script
	echo '	RUNNING TSV CONVERSION'
	python conversionScripts/tsv2fasta.py $INPUTFILE
	INPUTFILE=${INPUTFILE:0:${#INPUTFILE}-5}'.fasta'
fi
echo '#=============================================='
echo 'PROCESSING COMMAND'
CURRENTDIR=$(pwd)
#echo $CURRENTDIR
#echo $INPUTFILE
CMD1='export PATH=${CURRENTDIR}:$PATH && mixcr align ${INPUTFILE} output_file.vdjca && mixcr exportAlignments '
CMD3='output_file.vdjca /bbx/output/output.txt'
CMD=$CMD1$CMD2$CMD3
echo -n 'Running command: '
echo $CMD
eval $CMD
echo 'PROCESS COMPLETED'



