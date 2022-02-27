library(tidyverse)
source("data-raw/utils.R")

tun_governorates_path <- fs::path("data-raw", "raw", "tun_governorates.geojson")

if (!fs::file_exists(tun_governorates_path)) {
  governorates_geojson_url <- "https://www.data4tunisia.org/fr/datasets/r/f2324e88-a273-465a-bd94-c952f2829995"
  download.file(governorates_geojson_url, tun_governorates_path)
}

tun_governorates <- read_sf(tun_governorates_path) %>%
  rename(
    id_gov = CIRC_ID,
    name_fr_gov = NAME_EN,
    name_ar_gov = NAME_AR,
  ) %>%
  mutate(
    id_gov = as.numeric(str_remove(id_gov, "\\d$"))
  )

usethis::use_data(tun_governorates, overwrite = TRUE, compress = "xz")
