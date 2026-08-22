#' genes.
#'
#' Genes for GRCg7b.
#'
#' @format A data frame with two variables: \code{seqname}, \code{start}, \code{end}, \code{strand}, \code{gene}, \code{biotype}
#' @source <https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/016/699/485/GCF_016699485.2_bGalGal1.mat.broiler.GRCg7b/GCF_016699485.2_bGalGal1.mat.broiler.GRCg7b_genomic.gff.gz>
"genes"

#' exons.
#'
#' Exons for GRCg7b.
#'
#' @format A data frame with two variables: \code{seqname}, \code{start}, \code{end}, \code{strand}, \code{gene}
#' @source <https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/016/699/485/GCF_016699485.2_bGalGal1.mat.broiler.GRCg7b/GCF_016699485.2_bGalGal1.mat.broiler.GRCg7b_genomic.gff.gz>
"exons"

#' accession2chrom.
#'
#' correspondence of chromosome accessions and number in GRCg7b.
#'
#' @format A data frame with two variables: \code{CHROM}, \code{chr}
#' @source <https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/016/699/485/GCF_016699485.2_bGalGal1.mat.broiler.GRCg7b/GCF_016699485.2_bGalGal1.mat.broiler.GRCg7b_assembly_report.txt>
"accession2chrom"

#' cumsum_seq_length
#'
#' helper dataframe to convert positions in
#' chromosome to cumsum positions (used for manhattan plot)
#'
#' @format A data frame with two variables: \code{CHROM}, \code{cumsum_seq_length}
"cumsum_seq_length"

#' chrom_axis
#'
#' axis labels and positions for manhattan plot
#'
#' @format A data frame with two variables: \code{chr}, \code{center}
"chrom_axis"
