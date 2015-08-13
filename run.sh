#This script runs the biobox for mixcr. It is called to as the entrypoint in the Dockerfile. 
#==============================================
# exit script if one command fails
set -o errexit

# exit script if Variable is not set
set -o nounset
#==============================================
INPUT=/bbx/input/biobox.yaml
OUTPUT=/bbx/output
mkdir -p ${OUTPUT}
#==============================================
#Parse the input yaml file and read the parameters
print 'biobox.yml: '
cat biobox.yml

. ./inputDir/parse_yaml.sh
eval $(parse_yaml $INPUT 'mixcr_')
GERMLINESEQDIR=$mixcr_germlineSeqDir
INPUTFILE=$mixcr_inputfile
OUTPUTFILE=$mixcr_outputfile

#if the output file is in csv or tsv format run conversion scripts into fasta

echo -n 'default: mixcr align ${INPUTFILE} output_file.vdjca && mixcr exportAlignments output_file.vdjca ${OUTPUTFILE}' >> ./Taskfile
#==============================================
print '\n Taskfile: '
cat Taskfile
#==============================================
CMD=$(egrep ^${TASK}: ./Taskfile | cut -f 2 -d ':')
if [[ -z ${CMD} ]]; then
	echo "Abort, no task found for '${TASK}'."
	exit 1
fi
eval $(CMD)

echo 'PROCESS COMPLETED'



