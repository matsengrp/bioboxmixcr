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

#dictionary containing true values
trueDictionary = {}
with open("simu-10-leaves-1-mutate.csv") as inFile:
	reader = csv.DictReader(inFile)
	for row in reader:
		unique_id = row['unique_id']
		trueDictionary[unique_id] = row 

#dictionary containing inferred values
iDictionary = {}
with open("edited_output_file.txt") as infile:
	reader = csv.DictReader(infile, delimiter='\t')
	for i, row in enumerate(reader):
		#print row

		#fill in with data from original text file
		iDictionary[i] = fillData.fillDictionary('simu-10-leaves-1-mutate.csv')

		iDictionary[i]['v_gene'] = row['Best V hit'] 
		iDictionary[i]['d_gene'] = row['Best D hit'] 
 		iDictionary[i]['j_gene'] = row['Best J hit']
		
		#filling in random data
		'''
		iDictionary[i]['unique_id'] = 1		
		iDictionary[i]['reco_id'] = 1 
		iDictionary[i]['cdr3_length'] = 0
		iDictionary[i]['v_5p_del'] = 0
		iDictionary[i]['v_3p_del'] = 0 
		iDictionary[i]['d_5p_del'] = 0
		iDictionary[i]['d_3p_del'] = 0
		iDictionary[i]['j_5p_del'] = 0
		iDictionary[i]['j_3p_del'] = 0
		iDictionary[i]['fv_insertion'] = ''
		iDictionary[i]['vd_insertion'] = ''
		iDictionary[i]['dj_insertion'] = ''
		iDictionary[i]['jf_insertion'] = ''
		iDictionary[i]['seq'] = ''
		'''

#for tkey, tvalue in trueDictionary.items():
#	for ikey, ivalue in iDictionary.items():
#		print 'KEYS: ', tkey, ikey, '\n'
#		print 'TRUE VALUE', tvalue, '\n'
#		print 'INFERRED VALUE', ivalue,'\n'
		#perfplotter.evaluate(tvalue, ivalue)		

#print values of true dictionary
#for key in trueDictionary:
#	print key, trueDictionary[key], '\n'
#print values of inferred dictionary
#for key in iDictionary:
#	print key, iDictionary[key], '\n'

for tkey, ikey in zip(trueDictionary, iDictionary):
	#print 'TRUE: ', trueDictionary[tkey], '\n', 'INFERRED: ', iDictionary[ikey], '\n'
	perfplotter.evaluate(trueDictionary[tkey], iDictionary[ikey])

	#print key, value, 'TRUE','\n'
	#perfplotter.evaluate()

#for key, value in iDictionary.items():
#       print key, value, 'INFERRED','\n'
#evaluate checks one line at a time, true, untrue
#perfplotter.evaluate(trueDictionary, iDictionary)

#generate plot directory
perfplotter.plot('mixcrPlotDir')

