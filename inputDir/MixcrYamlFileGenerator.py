#!/usr/bin/env python
#This script generates a yaml file for Mixcr based on user input
#8-17-15
#===================================================
#Import relevant libraries
import yaml
#===================================================
#Lists manual information for user
print 'The following dictionary contains parameters for Mixcr\'s export function.'
print 'To specify parameters, enter in the corresponding description (the key value).'
print 'When you are done entering parameters, enter \'exit\'' 
#===================================================
#Dictionary to contain parameters and their respective keys
parameters = {'BestVhit':'-vHit', 'BestDhit':'-dHit', 'BestJhit':'-jHit','BestChit':'-cHit', 'AllVhits':'-vHits', 'AllDhits':'-dHits', 'AllJhits':'-jHits', 'AllChits':'-cHits', 'BestValignment':'-vAlignment', 'BestDalignment':'-dAlignment', 'BestJalignment':'-jAlignment','BestCalignment':'-cAlignment', 'AllValignments':'-vAlignments','AllDalignments':'-dAlignments', 'AllJalignments':'-jAlignments', 'AllCAlignments':'-cAlignments', 'sequence':'-sequence', 'quality':'-equality', 'readId':'-readId', 'targets':'-targets','descrR1':'-descrR1','descrR2':'-descrR2'}
print parameters
#===================================================
#List to contain user input
#User will input descriptions of the commands that correspond to parameters 
values=[]
key = 'exit' 
while(True):
	key = raw_input('Next parameter? (enter \'exit\' to end): ')
	if(key=='exit'):
		break
	else:
		#append the command to the list 
		values.append(parameters[key])	
print 'Parameter collection complete'
print 'Here is the list of parameters you have specified:'
print values
#===================================================
#Creates a temporary dictionary with single key-value pair containing name of input file
tempDict={}
inputFileName = raw_input('Enter the name of the input file: ')
tempDict['inputfile'] = inputFileName
#===================================================
with open('biobox.yml', 'w') as writer:
	#add list of commands to file
	writer.write(yaml.dump(values, default_flow_style=False))
	#add key value pair containing name of input file to file
	writer.write(yaml.dump(tempDict, default_flow_style=False))
