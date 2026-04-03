genes = readr::read_tsv("data-raw/genes.tsv")
usethis::use_data(genes, overwrite = TRUE)

exons = readr::read_tsv("data-raw/exons.tsv")
usethis::use_data(exons, overwrite = TRUE)
