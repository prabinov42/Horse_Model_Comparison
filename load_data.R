df <- read_csv("https://raw.githubusercontent.com/prabinov42/MiscData/master/horse_racing_data.csv") %>%
  clean_names() %>%
  filter(finish_time > 100) %>%
  mutate(finish_time = floor(finish_time) + 2 * (finish_time - floor(finish_time)))