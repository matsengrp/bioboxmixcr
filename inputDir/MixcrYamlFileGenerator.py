#!/usr/bin/env python
#This script generates a yaml file for Mixcr based on user input
#8-17-15
#===================================================
#Import relevant libraries
import yaml
#===================================================
#Lists manual information for user
print 'The following dictionary contains parameters for Mixcr\'s export function.'
print 'To specify parameters, enter in the corresponding number.'
print 'When you are done entering parameters, enter -2'
#===================================================
#Dictionary to contain parameters and their respective keys
parameters = {0:'Best V hit', 1:'Best D hit', 2:'Best J hit', 3:'Best C hit', 4:'All V hits', 5:'All D hits', 6:'All J hits', 7:'All C hits', 8:'Best V alignment', 9:'Best D alignment', 10:'Best J alignment', 11:'Best C alignment', 12:'All V alignments', 13:'All D alignments', 14:'All J alignments', 15:'All C Alignments', 16:'sequence', 17:'quality', 18:'readId', 19:'targets', 20:'descrR1', 21:'descrR2'}
print parameters
#===================================================
#List to contain user input
#User will input numbers that correspond to parameters  
values = [] 
key = -1
while(True):
	key = int(raw_input('Next parameter? (enter \'-1\' to end): '))
	if(key==-1):
		break
	else:
		values.append(parameters[key])
print 'Parameter collection complete'
print 'Here is the list of parameters you have specified:'
print values
#===================================================
inputFileName = raw_input('Enter the name of the input file: ')
values.append(inputFileName) 
#===================================================
with open('biobox.yml', 'w') as writer:
	writer.write(yaml.dump(values, default_flow_style=False))
