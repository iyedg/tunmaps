tun_municipalities_path <- fs::path("data-raw", "tun_municipalities.geojson")

if (!fs::file_exists(tun_municipalities_path)) {
  municipalities_geojson_url <- "https://www.data4tunisia.org/en/datasets/r/715366fd-81dc-490b-959c-f8760961a8cf"
  download.file(municipalities_geojson_url, tun_municipalities_path)
}

tun_municipalities <- dplyr::select(
  dplyr::rename(
    sf::read_sf(tun_municipalities_path),
    id_mun = id,
    name_mun_fr = name.fr,
    name_mun_ar = name.ar,
    name_mun = name
  ),
  id_mun, name_mun_fr, name_mun_ar, name_mun
)

usethis::use_data(tun_municipalities, overwrite = TRUE, compress = "xz")
