# Annual Trends

# Load data --------------------------------------------------------------------
adm1_df <- readRDS(file.path(ntl_bm_dir, "FinalData", "aggregated",
                             paste0("adm1", "_", "VNP46A4", ".Rds")))

adm2_df <- readRDS(file.path(ntl_bm_dir, "FinalData", "aggregated",
                             paste0("adm2", "_", "VNP46A4", ".Rds")))

adm3_df <- readRDS(file.path(ntl_bm_dir, "FinalData", "aggregated",
                             paste0("adm3", "_", "VNP46A4", ".Rds")))

sez_df <- readRDS(file.path(ntl_bm_dir, "FinalData", "aggregated",
                            paste0("admsez", "_", "VNP46A4", ".Rds")))

border_df <- readRDS(file.path(ntl_bm_dir, "FinalData", "aggregated",
                               paste0("admborder_1km", "_", "VNP46A4", ".Rds")))

# Filter -----------------------------------------------------------------------
# clean_data <- function(df){
#   df %>%
#     mutate(year = date %>% year(),
#            month = date %>% month()) %>%
#     filter(month != 12,
#            year >= 2019)
# }
#
# adm1_df <- adm1_df %>%
#   clean_data() %>%
#   group_by(year, NAME_1) %>%
#   dplyr::summarise(across(c(ntl_bm_sum, ntl_bm_mean, ntl_bm_median), mean)) %>%
#   ungroup()
#
# adm2_df <- adm2_df %>%
#   clean_data() %>%
#   group_by(year, NAME_1, NAME_2) %>%
#   dplyr::summarise(across(c(ntl_bm_sum, ntl_bm_mean, ntl_bm_median), mean)) %>%
#   ungroup()
#
# adm3_df <- adm3_df %>%
#   clean_data() %>%
#   group_by(year, NAME_1, NAME_2, NAME_3) %>%
#   dplyr::summarise(across(c(ntl_bm_sum, ntl_bm_mean, ntl_bm_median), mean)) %>%
#   ungroup()
#
# sez_df <- sez_df %>%
#   clean_data() %>%
#   group_by(year, Name) %>%
#   dplyr::summarise(across(c(ntl_bm_sum, ntl_bm_mean, ntl_bm_median), mean)) %>%
#   ungroup()
#
# border_df <- border_df %>%
#   clean_data() %>%
#   group_by(year, Name) %>%
#   dplyr::summarise(across(c(ntl_bm_sum, ntl_bm_mean, ntl_bm_median), mean)) %>%
#   ungroup()

# Trends -----------------------------------------------------------------------
sez_df %>%
  ggplot(aes(x = date, y = ntl_bm_sum)) +
  geom_col() +
  facet_wrap(~Name, scales = "free_y")

border_df %>%
  ggplot(aes(x = date, y = ntl_bm_sum)) +
  geom_col() +
  facet_wrap(~border_town, scales = "free_y")

adm1_df %>%
  filter(NAME_1 == "Yangon") %>%
  ggplot(aes(x = date, y = ntl_bm_sum)) +
  geom_col()

adm2_df %>%
  filter(NAME_1 == "Yangon") %>%
  ggplot(aes(x = date, y = ntl_bm_sum)) +
  geom_col() +
  facet_wrap(~NAME_2)

adm3_df %>%
  mutate(NAME_3_clean = paste(NAME_2, NAME_3)) %>%
  filter(NAME_1 == "Yangon") %>%
  ggplot(aes(x = date, y = ntl_bm_sum)) +
  geom_col() +
  facet_wrap(~NAME_3_clean,
             scales = "free_y")
