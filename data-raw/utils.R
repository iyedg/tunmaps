library(zip)
library(sf)
library(RcppHungarian)
library(fuzzyjoin)

read_shp_from_zip <- function(zip_file, shp_file) {
  temp_dir <- tempdir()
  unzip(zip_file, exdir = temp_dir, overwrite = T)
  sf_obj <- read_sf(
    fs::path(temp_dir, shp_file)
  )
  unlink(temp_dir)
  sf_obj
}

match_lists <- function(source.names, target.names) {
  dist_matrix <- stringdist::stringdistmatrix(source.names, target.names, method = "jaccard")

  res <- RcppHungarian::HungarianSolver(dist_matrix)

  tibble(
    source.name = source.names[res$pairs[, 1]],
    target.name = target.names[res$pairs[, 2]],
    dist = dist_matrix[res$pairs]
  )
}
