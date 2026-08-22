genes = readr::read_tsv("data-raw/genes.tsv")
usethis::use_data(genes, overwrite = TRUE)

exons = readr::read_tsv("data-raw/exons.tsv")
usethis::use_data(exons, overwrite = TRUE)

# source: https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/016/699/485/GCF_016699485.2_bGalGal1.mat.broiler.GRCg7b/GCF_016699485.2_bGalGal1.mat.broiler.GRCg7b_assembly_report.txt
# if (!file.exists("data-raw/grcg7b.txt")) {
#   download.file("https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/016/699/485/GCF_016699485.2_bGalGal1.mat.broiler.GRCg7b/GCF_016699485.2_bGalGal1.mat.broiler.GRCg7b_assembly_report.txt", "data-raw/grcg7b.txt")
# }
# grcg7b = readr::read_delim("data-raw/grcg7b.txt", comment = "#", delim = "\t")

GRCg7b_sequence_report = readr::read_tsv("data-raw/GRCg7b_sequence_report.tsv")

accession2chrom = GRCg7b_sequence_report |>
  dplyr::rename(CHROM = `RefSeq seq accession`, chr = `Chromosome name`) |>
  dplyr::select(CHROM, chr)
usethis::use_data(accession2chrom, overwrite = TRUE)

cumsum_seq_length = GRCg7b_sequence_report |>
  dplyr::rename(CHROM = `RefSeq seq accession`, length = `Seq length`) |>
  dplyr::mutate(cumsum_seq_length = dplyr::lag(cumsum(length), default = 0)) |>
  dplyr::select(CHROM, cumsum_seq_length)
usethis::use_data(cumsum_seq_length, overwrite = TRUE)

chrom_axis = GRCg7b_sequence_report |>
  dplyr::rename(CHROM = `RefSeq seq accession`, chr = `Chromosome name`, length = `Seq length`) |>
  dplyr::mutate(chr = dplyr::if_else(stringr::str_detect(CHROM, "^NW"), "Un", chr)) |>
  dplyr::mutate(chr = forcats::fct_inorder(chr)) |>
  dplyr::mutate(cumsum_seq_length = dplyr::lag(cumsum(length), default = 0)) |>
  dplyr::mutate(center = length / 2 + cumsum_seq_length) |>
  dplyr::group_by(chr) |>
  dplyr::summarise(center = mean(center)) |>
  dplyr::ungroup()
usethis::use_data(chrom_axis, overwrite = TRUE)
