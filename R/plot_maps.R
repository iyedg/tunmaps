#' Plot a map of Tunisia showing the boundaries of Governorates.
#'
#' @return ggplot2 plot
#' @export
plot_governorates <- function() {
  ggplot2::ggplot(tunmaps::tun_governorates) +
    ggplot2::geom_sf() +
    ggplot2::theme_void() +
    ggplot2::labs(
      caption = "Produced with tunmaps"
    )
}

#' Plot a map of Tunisia showing the boundaries of Municipalities.
#'
#' @return ggplot2 plot
#' @export
plot_municipalities <- function() {
  ggplot2::ggplot(tunmaps::tun_municipalities) +
    ggplot2::geom_sf() +
    ggplot2::theme_void() +
    ggplot2::labs(
      caption = "Produced with tunmaps"
    )
}
