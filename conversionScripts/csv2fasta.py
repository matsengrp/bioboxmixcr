#This script converts a csv file into a fasta file
#To run this script, run the following command: python csv2fasta.py <name of csv file>
#==============================================
#Import relevant modules
import csv
import argparse
#==============================================
#function that takes a csv file, extracts the unique id and seq and writes to a fasta file
def csvToFasta(inputFile):
	with open(inputFile[:-3]+'fasta', 'w') as outfile:
    		with open(inputFile) as infile:
        		reader = csv.DictReader(infile, delimiter=',')
        		for line in reader:
            			outfile.write('>%s\n%s\n' % (line['unique_id'], line['seq']))
#==============================================
#main function
if __name__ == '__main__':
	parser = argparse.ArgumentParser()
	parser.add_argument('input')
	args = parser.parse_args()
	csvToFasta(args.input)	
