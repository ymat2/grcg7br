#' Visualize gene structure
#'
#' @param chrom Accessions of chromosome
#' @param from Start position in bp
#' @param to end position in bp
#' @param nrows number of rows when visualizing gene structures
#' @rdname gggenes
#' @export

gggenes = function(chrom, from, to, nrows = 1) {
  chr_genes = grcg7br::genes |>
    dplyr::filter(.data$seqname == chrom) |>
    dplyr::filter(.data$end >= from & .data$start <= to) |>
    dplyr::mutate(ypos = rep(1:nrows, length.out = dplyr::n()))
  chr_exons = grcg7br::exons |>
    dplyr::filter(.data$gene %in% chr_genes$gene) |>
    dplyr::left_join(chr_genes |> dplyr::select(.data$gene, .data$ypos), by = "gene")
  g = ggplot2::ggplot() +
    ggplot2::geom_segment(
      data = chr_genes,
      ggplot2::aes(x = .data$start, xend = .data$end, y = .data$ypos, yend = .data$ypos),
      linewidth = 1
    ) +
    ggplot2::geom_segment(
      data = chr_exons,
      ggplot2::aes(x = .data$start, xend = .data$end, y = .data$ypos, yend = .data$ypos),
      linewidth = 5
    ) +
    ggplot2::coord_cartesian(xlim = c(from, to))
  g
}
