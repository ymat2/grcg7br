import argparse
import gzip
# import re
from pathlib import Path


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", "--input")
    parser.add_argument("-o", "--output")
    args = parser.parse_args()

    genes = get_genes(args.input)
    with open(Path(args.output)/"genes.tsv", "w") as f:
        _header = ["seqname", "start", "end", "strand", "gene", "biotype"]
        f.write("\t".join(_header)+"\n")
        for l in genes:
            f.write("\t".join(l)+"\n")

    exons = get_exons(args.input)
    with open(Path(args.output)/"exons.tsv", "w") as f:
        _header = ["seqname", "start", "end", "gene"]
        f.write("\t".join(_header)+"\n")
        for l in exons:
            f.write("\t".join(l)+"\n")


def get_genes(gff: Path):
    gene_lines = []
    with gzip.open(gff, "rt") as f:
        for line in f:
            if line.startswith("#"):
                continue
            else:
                seqname, source, feature, start, end, score, strand, frame, attribute = line.rstrip("\n").split("\t")
                if feature != "gene":
                    continue
                else:
                    gene_name = next((p[len("Name="):] for p in attribute.split(";") if p.startswith("gene=")), "NA")
                    gene_biotype = next((p[len("gene_biotype="):] for p in attribute.split(";") if p.startswith("gene_biotype=")), "NA")
                    gene_lines.append([seqname, start, end, strand, gene_name, gene_biotype])
    return gene_lines


def get_exons(gff: Path):
    exon_lines = []
    with gzip.open(gff, "rt") as f:
        for line in f:
            if line.startswith("#"):
                continue
            else:
                seqname, source, feature, start, end, score, strand, frame, attribute = line.rstrip("\n").split("\t")
                if feature != "exon":
                    continue
                else:
                    gene_name = next((p[len("Name="):] for p in attribute.split(";") if p.startswith("gene=")), "NA")
                    exon_lines.append([seqname, start, end, gene_name])

    return exon_lines


if __name__ == "__main__":
    main()
