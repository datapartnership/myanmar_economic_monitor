# Append Data

roi = "adm2"
product <- "VNP46A3"

df <- readRDS(file.path(ntl_bm_dir, "FinalData", "aggregated", 
                        paste0(roi, "_", product, ".Rds")))

df %>%
  group_by(date, NAME_2) %>%
  dplyr::summarise(ntl_bm_mean = mean(ntl_bm_mean)) %>%
  ggplot(aes(x = date, y = ntl_bm_mean)) +
  geom_col() +
  facet_wrap(~NAME_2, scales = "free_y") +
  labs(x = NULL, y = "NTL")



for(roi in c("tessellation", "adm0", "adm1", "adm2")){
  for(product in c("VNP46A2", "VNP46A3")){
    
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