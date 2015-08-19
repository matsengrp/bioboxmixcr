import csv
import argparse
#==============================================
def csvToFasta(inputFile):
	with open(inputFile[:-3]+'fasta', 'w') as outfile:
    		with open(inputFile) as infile:
        		reader = csv.DictReader(infile, delimiter=',')
        		for line in reader:
            			outfile.write('>%s\n%s\n' % (line['unique_id'], line['seq']))
#==============================================
if __name__ == '__main__':
	parser = argparse.ArgumentParser()
	parser.add_argument('input')
	args = parser.parse_args()
	csvToFasta(args.input)	
