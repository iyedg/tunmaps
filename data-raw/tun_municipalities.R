library(dplyr)
source("data-raw/utils.R")

mun_official <- readr::read_csv2("http://data.collectiviteslocales.gov.tn/wp-content/uploads/sites/20/2021/05/Mun_population2020.csv")

tun_municipalities_path <- fs::path("data-raw", "tun_municipalities.geojson")

if (!fs::file_exists(tun_municipalities_path)) {
  # Source: https://www.data4tunisia.org/en/datasets/decoupage-de-la-tunisie-en-municipalites-geojson/
  municipalities_geojson_url <- "https://www.data4tunisia.org/en/datasets/r/7d262421-f3d6-4ec8-8c4a-387307144626"
  download.file(municipalities_geojson_url, tun_municipalities_path)
}

tun_municipalities <- dplyr::rename(
  sf::read_sf(tun_municipalities_path),
  name_ar_mun = NAME_EN_AR,
  name_fr_mun = NAME_EN,
  id_gov = C_GOUV
) %>%
  mutate(id_gov = as.numeric(id_gov))


tun_municipalities_names <- tun_municipalities %>%
  distinct(id_gov, name_ar_mun)

official_mun_names <- mun_official %>%
  distinct(code_gouvernorat, nom_municipalite_ar, nom_gouvernorat_ar) %>%
  rename(
    gov_id = code_gouvernorat,
    gov_name = nom_gouvernorat_ar,
    mun_name = nom_municipalite_ar
  ) %>%
  mutate(gov_id = as.numeric(gov_id))


match_gov_muns <- function(governorate_id) {
  official_mun_names_subset <- official_mun_names %>%
    filter(gov_id == governorate_id)

  tun_municipalities_names_subset <- tun_municipalities_names %>%
    filter(id_gov == governorate_id)

  matches <- match_lists(
    target.names = official_mun_names_subset %>% pull(mun_name),
    source.names = tun_municipalities_names_subset %>% pull(name_ar_mun)
  )

  matches
}

gov_ids <- official_mun_names %>%
  distinct(gov_id) %>%
  pull(gov_id)


matched_df <- gov_ids %>%
  purrr::map(match_gov_muns) %>%
  bind_rows()


clean_tun_municipalities <- tun_municipalities %>%
  left_join(matched_df, by = c(name_ar_mun = "source.name")) %>%
  left_join(mun_official %>% rename(target.name = nom_municipalite_ar)) %>%
  select(-name_ar_mun) %>%
  rename(
    name_ar_mun = target.name,
    gov_name = nom_gouvernorat_ar,
    id_mun = code_municipalite
  ) %>%
  select(
    id_gov,
    id_mun,
    name_ar_mun,
    name_fr_mun,
    geometry
  )

usethis::use_data(tun_municipalities, overwrite = TRUE, compress = "xz")
