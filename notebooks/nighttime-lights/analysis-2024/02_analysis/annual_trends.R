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
theme_manual <- theme_classic2() + 
  theme(strip.background = element_blank())

# SEZ Individual ---------------------------------------------------------------
sez_df <- sez_df %>%
  mutate(Name_id = Name %>%
           as.factor() %>%
           as.numeric())
  
sez_df %>%
  dplyr::filter(Name_id %in% 1:30) %>%
  ggplot(aes(x = date, y = ntl_bm_sum)) +
  geom_col() +
  facet_wrap(~Name, scales = "free_y") +
  labs(x = NULL,
       y = "NTL Radiance") +
  theme_manual

ggsave(filename = file.path(fig_dir, "ntl_sez_1.png"),
       height = 10, width = 15)

sez_df %>%
  dplyr::filter(Name_id %in% 31:60) %>%
  ggplot(aes(x = date, y = ntl_bm_sum)) +
  geom_col() +
  facet_wrap(~Name, scales = "free_y") +
  labs(x = NULL,
       y = "NTL Radiance") +
  theme_manual

ggsave(filename = file.path(fig_dir, "ntl_sez_2.png"),
       height = 10, width = 15)

sez_df %>%
  dplyr::filter(Name_id %in% 61:95) %>%
  ggplot(aes(x = date, y = ntl_bm_sum)) +
  geom_col() +
  facet_wrap(~Name, scales = "free_y") +
  labs(x = NULL,
       y = "NTL Radiance") +
  theme_manual

ggsave(filename = file.path(fig_dir, "ntl_sez_3.png"),
       height = 10, width = 15)

# SEZ Average ------------------------------------------------------------------
sez_df %>%
  group_by(date) %>%
  dplyr::summarise(ntl_bm_sum = mean(ntl_bm_sum)) %>%
  ungroup() %>%
  ggplot(aes(x = date, y = ntl_bm_sum)) +
  geom_col() +
  labs(x = NULL,
       y = "NTL Radiance",
       title = "Average nighttime lights across special economic zones") +
  theme_manual

ggsave(filename = file.path(fig_dir, "ntl_sez_avg.png"),
       height = 2.5, width = 6)

# Other ------------------------------------------------------------------------
border_df %>%
  ggplot(aes(x = date, y = ntl_bm_sum)) +
  geom_col() +
  facet_wrap(~border_town, scales = "free_y") +
  labs(x = NULL,
       y = "NTL Radiance",
       title = "Average nighttime lights across border locations") +
  theme_manual

ggsave(filename = file.path(fig_dir, "ntl_border.png"),
       height = 6, width = 10)

adm1_df %>%
  ggplot(aes(x = date, y = ntl_bm_sum)) +
  geom_col() +
  labs(x = NULL,
       y = "NTL Radiance",
       title = "Sum of nighttime lights within ADM1 units") +
  facet_wrap(~NAME_1) +
  theme_manual

ggsave(filename = file.path(fig_dir, "ntl_adm1.png"),
       height = 6, width = 10)

adm1_df %>%
  filter(NAME_1 == "Yangon") %>%
  ggplot(aes(x = date, y = ntl_bm_sum)) +
  geom_col() +
  labs(x = NULL,
       y = "NTL Radiance",
       title = "Sum of nighttime lights within Yangon") +
  theme_manual

ggsave(filename = file.path(fig_dir, "ntl_adm1_yangon.png"),
       height = 2.5, width = 6)

adm2_df %>%
  filter(NAME_1 == "Yangon") %>%
  ggplot(aes(x = date, y = ntl_bm_sum)) +
  geom_col() +
  facet_wrap(~NAME_2) +
  labs(x = NULL,
       y = "NTL Radiance",
       title = "Sum of nighttime lights within ADM2 units in Yangon") +
  theme_manual

ggsave(filename = file.path(fig_dir, "ntl_adm2_yangon.png"),
       height = 4, width = 6)

adm3_df %>%
  mutate(NAME_3_clean = paste(NAME_2, NAME_3)) %>%
  filter(NAME_1 == "Yangon") %>%
  ggplot(aes(x = date, y = ntl_bm_sum)) +
  geom_col() +
  facet_wrap(~NAME_3_clean,
             scales = "free_y") +
  labs(x = NULL,
       y = "NTL Radiance",
       title = "Sum of nighttime lights within ADM3 units in Yangon") +
  theme_manual

ggsave(filename = file.path(fig_dir, "ntl_adm3_yangon.png"),
       height = 6, width = 10)
