#' Annotate gene name to bed style dataframe
#'
#' @param df A data.frame. with bed style
#' @param seqnames Colname passed to seqnames.field (e.g. `CHROM`)
#' @param start Colname passed to start.field (e.g. `BIN_START`)
#' @param end Colname passed to end.field. (e.g. `BIN_END`)
#' @importFrom rlang .data
#' @importFrom rlang :=
#' @rdname annotate
#' @export

annotate = function(df, seqnames, start, end) {
  gr = GenomicRanges::makeGRangesFromDataFrame(
    df,
    keep.extra.columns = TRUE,
    ignore.strand = TRUE,
    seqnames.field = seqnames,
    start.field = start,
    end.field = end
  )

  genes = grcg7br::genes |>
    dplyr::select(.data$seqname, .data$start, .data$end, .data$gene)
  genes = GenomicRanges::makeGRangesFromDataFrame(
    genes,
    keep.extra.columns = TRUE,
    ignore.strand = TRUE,
    seqnames.field = "seqname",
    start.field = "start",
    end.field = "end",
  )

  df_overlap = IRanges::mergeByOverlaps(
      gr,
      genes,
      maxgap = -1L,
      minoverlap = 0L,
      type = "any",
      select = "all"
    ) |>
    dplyr::as_tibble() |>
    dplyr::select(
      .data$gr.seqnames,
      .data$gr.start,
      .data$gr.end,
      .data$gene
    ) |>
    dplyr::rename(
      !!seqnames := .data$gr.seqnames,
      !!start := .data$gr.start,
      !!end := .data$gr.end
    )

  df_merge = df |> dplyr::left_join(
    df_overlap,
    by = c(seqnames, start, end)
  )

  return(df_merge)
}
