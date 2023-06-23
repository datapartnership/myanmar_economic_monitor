# Append Data

roi = "adm2"
product <- "VNP46A3"

for(roi in c("adm0", "adm1", "adm2", "adm3", "admsez", "admbound2", "admbound1")){ # "tessellation",
  for(product in c("VNP46A2", "VNP46A3", "VNP46A4")){

    df <- file.path(ntl_bm_dir, "FinalData", "aggregated", paste0(roi, "_", product)) %>%
      list.files(pattern = "*.Rds",
                 full.names = T) %>%
      map_df(readRDS)

    saveRDS(df, file.path(ntl_bm_dir, "FinalData", "aggregated",
                          paste0(roi, "_", product, ".Rds")))

    write_csv(df, file.path(ntl_bm_dir, "FinalData", "aggregated",
                            paste0(roi, "_", product, ".csv")))

  }
}


df <- readRDS(file.path(ntl_bm_dir, "FinalData", "aggregated",
                        paste0(roi, "_", product, ".Rds")))

df <- df %>%
  dplyr::arrange(date, DT_PCODE) %>%
  dplyr::select(DT_PCODE, date, ntl_bm_mean)

write.csv(df, "~/Desktop/ntl.csv")




# Trend: NTL and GDP, 2020 - present. Maps changes in SEZ
# Gas flaring
# log NTL // log GDP
# quarterly GDP
# Note important findings!
# 2020 base year??
# conflict -- ACLED -- at ADM1 and 2 regions
# --- overlap with NTL


df %>%
  ggplot() +
  geom_col(aes(x = date,
               y = ntl_bm_gf_mean)) +
  facet_wrap(~NAME_1,
             scales = "free_y") +
  labs(x = "Year",
       y = "NTL")


df <- readRDS(file.path(ntl_bm_dir, "FinalData", "aggregated",
                        paste0(roi, "_", product, ".Rds")))
