#' Plot a map of Tunisia showing the boundaries of Governorates.
#'
#' @return ggplot2 plot
#' @export
#'
#' @examples
plot_governorates <- function() {
  ggplot2::ggplot(tunmaps::tun_governorates) +
    ggplot2::geom_sf() +
    ggplot2::theme_void() +
    ggplot2::labs(
      caption = "Produced with tunmaps"
    )
}
