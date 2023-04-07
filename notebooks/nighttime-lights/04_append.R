# Append Data

roi = "adm0"
product <- "VNP46A3"

for(roi in c("tessellation", "adm0", "adm1", "adm2")){
  for(product in c("VNP46A2", "VNP46A3")){
    
    df <- file.path(ntl_bm_dir, "FinalData", "aggregated", paste0(roi, "_", product)) %>%
      list.files(pattern = "*.Rds",
                 full.names = T) %>%
      map_df(readRDS_data)
    
    saveRDS(df, file.path(ntl_bm_dir, "FinalData", "aggregated", 
                          paste0(roi, "_", product, ".Rds")))
    
    write_csv(df, file.path(ntl_bm_dir, "FinalData", "aggregated", 
                            paste0(roi, "_", product, ".csv")))
    
  }
}




readRDS_data <- function(path){
  df <- readRDS(path)
  
  df$date <- path %>%
    substring(150, 159) %>%
    str_replace_all("_", "-") %>%
    ymd()
  
  return(df)
}
