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
#Parse the input yaml file and read the parameters
#echo 'biobox.yml:'
#cat ./inputDir/biobox.yml
. ./inputDir/parse_yaml.sh
eval $(parse_yaml $YAMLINPUT 'mixcr_')

#GERMLINESEQDIR=$mixcr_germlineSeqDir
INPUTFILE=$mixcr_inputfile
#OUTPUTFILENAME=$mixcr_outputfile

#echo $GERMLINESEQDIR
echo '	Input file name: '$INPUTFILE
#echo '	Output file name: '$OUTPUTFILENAME

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
echo '#=============================================='
echo 'GENERATING TASKFILE'
#echo -n 'default: mixcr align ${INPUTFILE} output_file.vdjca && mixcr exportAlignments output_file.vdjca /bbx/output/output.txt' >> ./Taskfile
#ls
#echo 'Taskfile: '
#cat Taskfile
echo '#=============================================='
echo 'PROCESSING COMMAND'
#CMD=$(egrep ^${TASK}: ./Taskfile | cut -f 2 -d ':')
#if [[ -z ${CMD} ]]; then
#	echo "Abort, no task found for '${TASK}'."
#	exit 1
#fi
#echo $(pwd)
#ls
#ls outputDir
#ls inputDir
#CMD1='export PATH='$(pwd)':$PATH'
#CMD2='mixcr align /bbx/input/$INPUTFILE output_file.vdjca'
#CMD3='mixcr exportAlignments output_file.vdjca /bbx/output/$OUTPUTFILE'
#eval $CMD1
#eval $CMD2
#eval $CMD3
#echo $(pwd)
#ls
#echo '======'
#echo $OUTPUTFILENAME
CMD= 'export PATH='$(pwd)':$PATH && mixcr align '$INPUTFILE' output_file.vdjca && mixcr exportAlignments output_file.vdjca /bbx/output/output.txt'
#echo $CMD
#echo 'XXXXXXXXX'
#pwd
#echo 'XXXXXXXXX'
#ls
#echo 'XXXXXXXXX'
#ls inputDir
#echo 'XXXXXXXXX'
#ls outputDir
eval $CMD
ls
echo 'PROCESS COMPLETED'



