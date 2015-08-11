import csv
with open("simu-10-leaves-1-mutate.fasta", 'w') as outfile:
    with open("simu-10-leaves-1-mutate.csv") as infile:
        reader = csv.DictReader(infile, delimiter=',')
        for line in reader:
            outfile.write('>%s\n%s\n' % (line['unique_id'], line['seq']))
