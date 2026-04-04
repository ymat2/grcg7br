df = dplyr::tibble(
  CHROM = c("NC_052532.1", "NC_052532.1", "NC_052532.1", "NC_052533.1", "NC_052535.1"),
  BIN_START = c(38960001, 59440001, 164900001, 30340001, 85000001),
  FST = c(0.001, 0.003, 0.014, 0.002, 0.009)
) |> dplyr::mutate(BIN_END = BIN_START + 20000 - 1, .after = BIN_START)

readr::write_tsv(df, "./inst/extdata/sample.fst")
