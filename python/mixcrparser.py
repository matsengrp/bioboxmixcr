#This script takes in the inferences for gene locations from Mixcr in the form of a text file and outputs a directory containing the results in both table and histogram form.
#----------------------------
from performanceplotter import PerformancePlotter
import csv
import utils
#from collections import OrderedDict
#----------------------------
#hardcoded default germline sequences
germline_seqs = utils.read_germlines("data/imgt") 

#create an instance of the performance plotter class
perfplotter = PerformancePlotter(germline_seqs, 'mixcr')

#fill in both inferred and true nested dictionaries
trueDictionary = {}
iDictionary = {}
with open("simu-10-leaves-1-mutate.csv") as inFile1:
	with open('edited_output_file.txt') as inFile2:
		reader1 = csv.DictReader(inFile1)
		reader2 = csv.DictReader(inFile2, delimiter='\t')
		for row1, row2 in zip(reader1, reader2):
			unique_id = row1['unique_id']
			#print unique_id
			trueDictionary[unique_id] = {}
			trueDictionary[unique_id]['v_gene'] = row1['v_gene']	
			trueDictionary[unique_id]['d_gene'] = row1['d_gene']	
			trueDictionary[unique_id]['j_gene'] = row1['v_gene']	
			#print trueDictionary[unique_id]
			iDictionary[unique_id] = {}
			iDictionary[unique_id]['v_gene'] = row2['Best V hit']
			iDictionary[unique_id]['d_gene'] = row2['Best D hit']
			iDictionary[unique_id]['j_gene'] = row2['Best J hit']
			#print iDictionary[unique_id]

#run evaluate
for key in trueDictionary:
	#if key == '123818946361786991':
		#print 'RUNNING EVALUATE ON: ', key
	perfplotter.evaluate(trueDictionary[key], iDictionary[key])
	#perfplotter.evaluate(trueDictionary[key], iDictionary[key])
print 'COMPLETED EVALUATE'
#generate output inside of plot directory
perfplotter.plot('mixcrPlotDir')			

'''	
with open("simu-10-leaves-1-mutate.csv") as inFile1:
	with open('edited_output_file.txt') as inFile2:
		reader1 = csv.DictReader(inFile1)
		reader2 = csv.DictReader(inFile2, delimiter='\t')
		for i1, i2 in zip(reader1, reader2):
			#gets the unique id number from the dictionary in the first id
			unique_id = i1['unique_id']
			trueDictionary[unique_id] = i1
			#needs dict(i1) so that it isn't referencing the same object
			iDictionary[unique_id] = dict(i1)
			#print 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
			#print unique_id, '\n'
			#print i1, '\n'
			#print i2, '\n'
			iDictionary[unique_id]['v_gene'] = i2['Best V hit']
			iDictionary[unique_id]['d_gene'] = i2['Best D hit']
			iDictionary[unique_id]['j_gene'] = i2['Best J hit']
			#print iDictionary[unique_id], '\n'			
'''

'''
for key in trueDictionary:
	#print key 
	if (key == '123818946361786991'):
		print 'RUNNING EVALUTE ON: ', key 
		#utils.print_reco_event(germline_seqs, trueDictionary[key])
		#print 'ZZZZZZZZZZZZZZZ'
		
		#dictionaries contain same key value pairs but are in different order
		#print trueDictionary[key], '\n'
		#print iDictionary[key], '\n'
		perfplotter.evaluate(trueDictionary[key], iDictionary[key])
	print 'XXXXXXXXXXXX'
	#print 'TRUE: ', trueDictionary[tkey], '\n', 'INFERRED: ', iDictionary[ikey], '\n'
	#perfplotter.evaluate(trueDictionary[key], iDictionary[key])

#tkey = 123818946361786991
#tempDict = trueDictionary['unique_id'][tkey]
#utils.print_reco_event(germline_seqs, tempDict)
#perfplotter.evaluate(trueDictionary[unique_id][tkey], iDictionary[ikey])
#generate plot directory
perfplotter.plot('mixcrPlotDir')
'''
