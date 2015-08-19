#This script converts a tsv file into a fasta file
#To run this script, run the following command: python tsv2fasta.py <name of tsv file>
#==============================================
#Import relevant modules
import argparse
import csv
#==============================================
#function that takes a tsv file, extracts the unique id and seq and writes to a fasta file
def tsvToFasta(inputFile):
	with open(inputFile[:-3]+'fasta', 'w') as outfile:
    	with open(inputFile) as infile:
        	reader = csv.DictReader(infile, delimiter='\t')
        	for line in reader:
            	outfile.write('>%s\n%s\n' % (line['unique_id'], line['sequence']))
#==============================================
#main function
if __name == '__main__':
	parser = argparse.ArgumentParser()
	parser.add_argument('input')
	args = parser.parse_args
	tsvToFasta(args.input)
