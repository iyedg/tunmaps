tun_governorates_path <- fs::path("data-raw", "tun_governorates.geojson")

if (!fs::file_exists(tun_governorates_path)) {
  governorates_geojson_url <- "http://www.openculture.gov.tn/dataset/70fd9b49-3925-477f-ae17-9d206d650aab/resource/4b3d85dd-a523-425c-b477-ab9fec6e51a0/download/decoupage.geojson"
  download.file(governorates_geojson_url, tun_governorates_path)
}

tun_governorates <- dplyr::rename(
  sf::read_sf(tun_governorates_path),
  id_gov = gov_id,
  name_gov_fr = gov_name_f
)


usethis::use_data(tun_governorates, overwrite = TRUE, compress = "xz")
