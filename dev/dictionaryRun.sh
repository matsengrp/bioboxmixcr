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
TASK=$1
mkdir -p ${DOCKEROUTPUTDIR}
echo '#=============================================='
echo 'CACHING PARAMETERS'
. ./inputDir/parse_yaml.sh
eval $(parse_yaml $YAMLINPUT 'mixcr_')
#create array to intake keys whose values are not false, add the values of those keys to a string 'CMD2'
CMD2=''

#currently checks one value at a time, future implementation will parse yaml file with a for loop
#All_C_Alignments=$mixcr_ALLCAlignments
#All_C_Hits=$mixcr_AllChits

#All_D_Alignments=$mixcr_AllDalignments
#All_D_Hits=$mixcr_AllDhits

#All_V_Alignments=$mixcr_AllValignments
#All_V_Alignments=$mixcr_AllValignments

#All_J_Hits=$mixcr_AllJhits
#All_J_Hits=$mixcr_AllJhits
#===
#Best_C_Alignment=$mixcr_BestCalignment
#Best_C_Hit=$mixcr_BestChit

#Best_D_Alignment=$mixcr_BestDalignment
#Best_D_Hit=$mixcr_BestDhit

#Best_V_Alignment=$mixcr_BestValignment
#Best_V_Hit=$mixcr_BestVhit

#Best_J_Alignment=$mixcr_BestJalignment
#Best_J_Hit=$mixcr_BestJhit
#===
#DESCR1= 17 descrR1: false
# 18 descrR2: false
# 20 quality: false
# 21 readId: false
# 22 sequence: false
# 23 targets: false

INPUTFILE=$mixcr_inputfile
#if the input file is in csv or tsv format run conversion scripts into fasta
if [ ${INPUTFILE: -4} == ".csv" ] ; then
	#run csv conversion script
	echo '  RUNNING CSV CONVERSION'
	python python/csv2fasta.py $INPUTFILE
	INPUTFILE=${INPUTFILE:0:${#INPUTFILE}-4}'.fasta'
elif [ ${INPUTFILE: -4} == ".tsv" ] ; then 
	#run tsv conversion script
	echo '	RUNNING TSV CONVERSION'
	python python/tsv2fasta.py $INPUTFILE
	INPUTFILE=${INPUTFILE:0:${#INPUTFILE}-4}'.fasta'
fi
echo '#=============================================='
echo 'PROCESSING COMMAND'
CURRENTDIR=$(pwd)
echo $CURRENTDIR
echo $INPUTFILE
CMD1='export PATH=${CURRENTDIR}:$PATH && mixcr align ${INPUTFILE} output_file.vdjca && mixcr exportAlignments'
CMD3='output_file.vdjca /bbx/output/output.txt'
CMD= $CMD1$CMD2$CMD3
echo $CMD
eval $CMD
echo 'PROCESS COMPLETED'



