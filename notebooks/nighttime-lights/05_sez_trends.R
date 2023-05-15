# SEZ Trends

# Load data --------------------------------------------------------------------
roi     <- "admsez"
product <- "VNP46A4"

ntl_df <- readRDS(file.path(ntl_bm_dir, "FinalData", "aggregated", 
                            paste0(roi, "_", product, ".Rds")))

# Figure -----------------------------------------------------------------------
ntl_df <- ntl_df %>%
  mutate(Name = case_when(
    Name == "Bago Industrial Complex (Local Industrial Zone)" ~ "Bago Industrial Complex\n(Local Industrial Zone)",
    Name == "Bago Industrial Complex (Foreign Industrial Zone)" ~ "Bago Industrial Complex\n(Foreign Industrial Zone)",
    Name == "Det Khi Na Thi Ri SME Industrial Zone (Nay Pyi Taw)" ~ "Det Khi Na Thi Ri SME\nIndustrial Zone (Nay Pyi Taw)",
    Name == "Korea-Myanmar Economic Cooperation Industrial Complex" ~ "Korea-Myanmar Economic\nCooperation Industrial Complex",
    Name == "Kyauk Tan Industrial Zone - Mawlamyine" ~ "Kyauk Tan Industrial\nZone - Mawlamyine",
    Name == "" ~ "",
    Name == "" ~ "",
    Name == "" ~ "",
    Name == "" ~ "",
    Name == "" ~ "",
    Name == "" ~ "",
    Name == "" ~ "",
    Name == "" ~ "",
    TRUE ~ Name
  ))


ntl_df %>%
  ggplot(aes(x = date, y = ntl_bm_mean)) +
  geom_col() +
  scale_x_continuous(labels = 2012:2022,
                     breaks = 2012:2022) +
  labs(x = NULL,
       y = NULL,
       title = "Nighttime Lights: Gas Flaring Locations") +
  theme_classic2() + 
  theme(axis.title.y = element_text(angle = 0, vjust = 0.5),
        plot.title = element_text(face = "bold",size = 16),
        strip.text = element_text(face = "bold", size = 10),
        strip.background = element_blank()) +
  facet_wrap(~Name,
             scales = "free_y",
             ncol = 5)

ggsave(filename = file.path(fig_dir, "sez_ntl_trends.png"),
       height = 20, width = 15)
