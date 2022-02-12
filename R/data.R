#' Map of Tunisia divided by Governorates.
#'
#' The Map of Tunisia divided by Governorates with
#' their administrative identifiers and their French names.
#'
#' @format
#' A data frame with `r nrow(tunmaps::tun_governorates)` rows
#' \describe{
#'   \item{geometry}{Polygons representing Governorates}
#'   \item{id_gov}{Administrative Identifier of Governorate}
#'   \item{name_gov_fr}{Name of Governorate in French}
#' }
"tun_governorates"

#' Map of Tunisia divided by Municipalities.
#'
#' The Map of Tunisia divided by Municipalities with
#' their administrative identifiers and their French names.
#'
#' @format
#' A data frame with `r nrow(tunmaps::tun_municipalities)` rows
#' \describe{
#'   \item{geometry}{Polygons representing Municipalities}
#'   \item{id_gov}{Administrative Identifier of Governorate}
#'   \item{name_gov_fr}{Name of Governorate in French}
#' }
"tun_municipalities"
