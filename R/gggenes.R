#' Visualize gene structure
#'
#' @param chrom Accessions of chromosome
#' @param from Start position in bp
#' @param to End position in bp
#' @param color Color of genes
#' @param nrow number of rows when visualizing gene structures
#' @param label Whether to show gene names.
#' `all` shows all gene names and `none` hides them.
#'  You can use a character vecter of gene names to show a part of them.
#' @param ... Other arguments passed on to `ggplot2::theme_test()`
#' @rdname gggenes
#' @export

gggenes = function(chrom, from, to, color = "#333333", nrow = 1, label = "all", ...) {
  chr_genes = grcg7br::genes |>
    dplyr::filter(.data$seqname == chrom) |>
    dplyr::filter(.data$end >= from & .data$start <= to) |>
    dplyr::mutate(ypos = rep(1:nrow, length.out = dplyr::n()))
  chr_exons = grcg7br::exons |>
    dplyr::filter(.data$gene %in% chr_genes$gene) |>
    dplyr::left_join(chr_genes |> dplyr::select(.data$gene, .data$ypos), by = "gene")

  if (length(label) == 1 && label == "all") {
    chr_gene_labels = chr_genes
  } else if (length(label) == 1 && label == "none") {
    chr_gene_labels = chr_genes |> dplyr::mutate(gene = "")
  } else if (is.vector(label)) {
    chr_gene_labels = chr_genes |> dplyr::filter(.data$gene %in% label)
  } else {
    stop('Use one of "all", "none", or a character vecter of genes for `labels`.')
  }

  g = ggplot2::ggplot() +
    ggplot2::geom_segment(
      data = chr_genes,
      ggplot2::aes(
        x = .data$start,
        xend = .data$end,
        y = .data$ypos,
        yend = .data$ypos),
      linewidth = 1,
      color = color
    ) +
    ggplot2::geom_segment(
      data = chr_exons,
      ggplot2::aes(
        x = .data$start,
        xend = .data$end,
        y = .data$ypos,
        yend = .data$ypos
        ),
      linewidth = 5,
      color = color
    ) +
    ggplot2::geom_text(
      data = chr_gene_labels,
      ggplot2::aes(
        x = (.data$start + .data$end) / 2,
        y = .data$ypos,
        label = .data$gene
        ),
      fontface = "italic",
      vjust = -1
    ) +
    ggplot2::scale_y_continuous(expand = ggplot2::expansion(mult = c(.1, .5))) +
    ggplot2::coord_cartesian(xlim = c(from, to)) +
    ggplot2::labs(x = chrom) +
    ggplot2::theme_test(...) +
    ggplot2::theme(
      axis.title.y = ggplot2::element_blank(),
      axis.text.y = ggplot2::element_blank(),
      axis.ticks.y = ggplot2::element_blank()
    )
  g
}
