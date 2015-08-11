#This file fills in the data for the inferred dictionary from Mixcr with data from the original input file into Mixcr
#---------------------------------
import csv
#---------------------------------
#takes in a text file as input and returns a dictionary
def fillDictionary(inputFile):
	dictionary = {}
	with open(inputFile) as inFile:
		reader = csv.DictReader(inFile)
		for row in reader:
			unique_id = row['unique_id']
			dictionary[unique_id] = row			

	return dictionary	
