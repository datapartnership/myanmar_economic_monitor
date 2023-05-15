# GDP vs NTL

# Load/prep NTL data -----------------------------------------------------------
roi     <- "adm0"
product <- "VNP46A3"

ntl_df <- readRDS(file.path(ntl_bm_dir, "FinalData", "aggregated", 
                        paste0(roi, "_", product, ".Rds")))

ntl_df <- ntl_df %>%
  mutate(date = floor_date(date, unit = "quarter"),
         month = date %>% month,
         year = date %>% year) %>%
  mutate(quarter = case_when(
    month == 1 ~ "q1",
    month == 4 ~ "q2",
    month == 7 ~ "q3",
    month == 10 ~ "q4"
  )) %>%
  group_by(year, quarter, date) %>%
  summarise(ntl_bm_mean = mean(ntl_bm_mean))

# Load GDP ---------------------------------------------------------------------
gdp_df <- read_xlsx(file.path(gdp_dir, "RawData", "GDP quarterly.xlsx"), 3)

# Merge ------------------------------------------------------------------------
df_wide <- ntl_df %>%
  left_join(gdp_df, by = c("year", "quarter"))

df_long <- df_wide %>%
  pivot_longer(cols = -c(year, quarter, date))

# Figure -----------------------------------------------------------------------
## Add Percent change from start
df_long <- df_long %>%
  
  group_by(name) %>%
  mutate(value_start = value[(year == 2015) & (quarter == "q1")]) %>%
  ungroup(name) %>%
  
  mutate(value_pc = (value - value_start)/value_start*100)

## Scatter
df_wide %>%
  ggplot(aes(x = constant_gdp, y = ntl_bm_mean)) +
  geom_smooth(method='lm', formula= y~x, se=F, color = "darkorange") +
  geom_point(size = 3) +
  stat_cor(p.accuracy = 0.001, r.accuracy = 0.01) +
  labs(x = "GDP",
       y = "Nighttime\nLights") +
  theme_classic2() +
  theme(axis.title.y = element_text(angle = 0, vjust = 0.5))

ggsave(filename = file.path(fig_dir, "gdp_ntl_quarterly_scatter.png"),
       height = 3.5, width = 5)

## Trends
df_long %>%
  filter(name != "current_gdp",
         year >= 2015, 
         year <= 2019) %>%
  mutate(name = case_when(
    name == "constant_gdp" ~ "GDP",
    name == "ntl_bm_mean" ~ "Nighttime Lights"
  )) %>%
  ggplot(aes(x = date, y = value)) +
  geom_vline(xintercept = ymd("2016-01-01"), alpha = 0.2) +
  geom_vline(xintercept = ymd("2017-01-01"), alpha = 0.2) +
  geom_vline(xintercept = ymd("2018-01-01"), alpha = 0.2) +
  geom_vline(xintercept = ymd("2019-01-01"), alpha = 0.2) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  facet_wrap(~name, scales = "free_y", ncol = 1) +
  labs(x = NULL,
       y = NULL,
       title = "Quarterly Nighttime Lights") +
  theme_classic2() +
  theme(strip.text = element_text(face = "bold", size = 12),
        strip.background = element_blank(),
        plot.title = element_text(face = "bold"))

ggsave(filename = file.path(fig_dir, "gdp_ntl_quarterly_trends.png"),
       height = 4.5, width = 6)

## Trends PC
df_long %>%
  filter(name != "current_gdp",
         year >= 2015, 
         year <= 2019) %>%
  mutate(name = case_when(
    name == "constant_gdp" ~ "GDP",
    name == "ntl_bm_mean" ~ "Nighttime Lights"
  )) %>%
  ggplot(aes(x = date, y = value_pc, color = name)) +
  geom_vline(xintercept = ymd("2016-01-01"), alpha = 0.2) +
  geom_vline(xintercept = ymd("2017-01-01"), alpha = 0.2) +
  geom_vline(xintercept = ymd("2018-01-01"), alpha = 0.2) +
  geom_vline(xintercept = ymd("2019-01-01"), alpha = 0.2) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  labs(x = NULL,
       y = NULL,
       color = NULL,
       title = "Quarterly GDP & Nighttime Lights: Percent Change Since Q1 2015") +
  theme_classic2() +
  theme(plot.title = element_text(face = "bold")) +
  scale_color_manual(values = c("gray20", "darkorange")) 

ggsave(filename = file.path(fig_dir, "gdp_ntl_quarterly_trends_pc.png"),
       height = 3.5, width = 7)



