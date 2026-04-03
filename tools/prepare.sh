#!/bin/bash

curl -O --output-dir tools https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/016/699/485/GCF_016699485.2_bGalGal1.mat.broiler.GRCg7b/GCF_016699485.2_bGalGal1.mat.broiler.GRCg7b_genomic.gff.gz
python3 tools/extract.py -i tools/GCF_016699485.2_bGalGal1.mat.broiler.GRCg7b_genomic.gff.gz -o data-raw
