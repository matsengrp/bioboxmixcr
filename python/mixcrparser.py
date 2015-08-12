#This script takes in the inferences for gene locations from Mixcr in the form of a text file and outputs a directory containing the results in both table and histogram form.
#----------------------------
from performanceplotter import PerformancePlotter
import csv
import utils
import fillData
#----------------------------
#hardcoded default germline sequences
germline_seqs = utils.read_germlines("data/imgt") 

#create an instance of the performance plotter class
perfplotter = PerformancePlotter(germline_seqs, 'mixcr')

#fill in both inferred and true dictionaries
trueDictionary = {}
iDictionary = {}
with open("simu-10-leaves-1-mutate.csv") as inFile1:
	with open('edited_output_file.txt') as inFile2:
		reader1 = csv.DictReader(inFile1)
		reader2 = csv.DictReader(inFile2, delimiter='\t')
		for i1, i2 in zip(reader1, reader2):
			unique_id = i1['unique_id']
			trueDictionary[unique_id] = i1
			iDictionary[unique_id] = i1
			print 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
			print i1, '\n'
			print i2, '\n'
			#print trueDictionary, '\n'
			#print iDictionary, '\n'			
			iDictionary[unique_id]['v_gene'] = i2['Best V hit']
			iDictionary[unique_id]['d_gene'] = i2['Best D hit']
			iDictionary[unique_id]['j_gene'] = i2['Best J hit']
			print iDictionary[unique_id]			

for tkey, ikey in zip(trueDictionary, iDictionary):
	#print 'TRUE: ', trueDictionary[tkey], '\n', 'INFERRED: ', iDictionary[ikey], '\n'
	perfplotter.evaluate(trueDictionary[tkey], iDictionary[ikey])

#generate plot directory
perfplotter.plot('mixcrPlotDir')

