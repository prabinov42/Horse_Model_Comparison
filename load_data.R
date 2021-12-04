library(tidyverse)
library(janitor)

df <- read_csv("https://raw.githubusercontent.com/prabinov42/MiscData/master/horse_racing_data.csv") %>%
  clean_names() %>%
  filter(finish_time > 100) %>%
  mutate(finish_time = floor(finish_time) + 2 * (finish_time - floor(finish_time)))

dts <- df %>%
  group_by(date) %>%
  summarize(
    min_temp = min(temp),
    max_temp = max(temp)
  ) %>%
  mutate(diff_temp = max_temp - min_temp) %>%
  filter(diff_temp > 0) %>%
  pull(date)

df <- df %>%
  filter(!(date %in% dts)) %>%
  filter(cond != "Heavy")

dfr <- df %>%
  group_by(date, racenum) %>%
  summarize(
    n=n(),
    mn = max(hnum)
  )%>%
  filter( n == mn) %>%
  ungroup()

df <- dfr %>%
  left_join(df, by = c("date"="date", "racenum"="racenum")) %>%
  select(-n,-mn)
