import csv
with open("A-subset-200.fasta", 'w') as outfile:
    with open("A-subset-200.tsv") as infile:
        reader = csv.DictReader(infile, delimiter='\t')
        for line in reader:
            outfile.write('>%s\n%s\n' % (line['name'], line['nucleotide']))
