library(tidyverse)
library(rstatix)

# Podatki
data <- tribble(
  ~PRBL1, ~PRBL2, ~PRBL3, ~PRBL4, ~PRBL5, ~Grade,
  5, 2, 3, 5, 5, "Above",
  4, 2, 2, 4, 4, "Below",
  3, 4, 3, 5, 4, "Above",
  4, 4, 4, 5, 3, "Above",
  4, 4, 4, 4, 5, "Above",
  3, 4, 3, 4, 4, "Above",
  4, 4, 3, 5, 5, "Above",
  4, 4, 2, 4, 3, "Above",
  4, 3, 2, 4, 5, "Below",
  4, 5, 5, 3, 4, "Above",
  3, 4, 4, 5, 4, "Below",
  3, 3, 4, 4, 4, "Above",
  1, 2, 3, 3, 4, "Below",
  4, 4, 3, 5, 4, "Above",
  5, 5, 4, 5, 5, "Above",
  4, 5, 4, 5, 5, "Below",
  2, 5, 3, 2, 5, "Above",
  5, 4, 4, 5, 5, "Above",
  3, 3, 2, 5, 2, "Below",
  5, 3, 2, 4, 3, "Below",
  5, 5, 4, 5, 5, "Above",
  4, 5, 4, 5, 2, "Below",
  5, 5, 1, 5, 1, "Above"
)

# Reshape
data_long <- data %>%
  pivot_longer(cols = starts_with("PRBL"), names_to = "Item", values_to = "Score") %>%
  mutate(Item = factor(Item, levels = paste0("PRBL", 1:5)))

# Povprečja
means_df <- data_long %>%
  group_by(Item, Grade) %>%
  summarise(Mean = mean(Score), .groups = "drop")

# Mann-Whitney test
stats_test <- data_long %>%
  group_by(Item) %>%
  wilcox_test(Score ~ Grade) %>%
  mutate(p_label = paste0("p = ", signif(p, 2)))

# Graf z novim zapisom
ggplot(data_long, aes(y = Score, fill = Grade)) +
  geom_bar(
    data = filter(data_long, Grade == "Above"),
    aes(x = after_stat(count)),
    position = "dodge",
    color = "black"
  ) +
  geom_bar(
    data = filter(data_long, Grade == "Below"),
    aes(x = -after_stat(count)),
    position = "dodge",
    color = "black"
  ) +
  geom_vline(
    data = filter(means_df, Grade == "Above"),
    aes(xintercept = Mean),
    color = "forestgreen",
    linetype = "dashed",
    linewidth = 0.7
  ) +
  geom_vline(
    data = filter(means_df, Grade == "Below"),
    aes(xintercept = -Mean),
    color = "firebrick",
    linetype = "dashed",
    linewidth = 0.7
  ) +
  geom_vline(xintercept = 0, linetype = "solid", color = "black", linewidth = 1.2) +
  facet_wrap(
    ~Item,
    ncol = 5,
    scales = "fixed",
    labeller = labeller(Item = c(
      "PRBL1" = "Support",
      "PRBL2" = "Group Work",
      "PRBL3" = "Work Independency",
      "PRBL4" = "Progress Monitoring",
      "PRBL5" = "Learning Autonomy"
    ))
  ) +
  # geom_text(
  #   data = stats_test,
  #   aes(x = 0, y = 5.5, label = p_label),
  #   inherit.aes = FALSE,
  #   size = 3
  # ) +
  scale_x_continuous(
    limits = c(-11, 11),
    breaks = seq(-11, 11, 4),
    labels = abs(seq(-11, 11, 4)),
    expand = c(0, 0)
  ) +
  scale_y_continuous(
    breaks = 1:5,
    labels = c("Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree")
  ) +
  scale_fill_manual(
    values = c("Above" = "forestgreen", "Below" = "firebrick"),
    labels = c("Above" = "Above average", "Below" = "Below average"),
    name = "Grade"
  ) +
  labs(
    y = "Likert Score",
    x = "Frequency",
    #caption = "Likert scale: 1 = Strongly Disagree, 5 = Strongly Agree"
  ) +
  theme_bw() +
  theme(
    panel.border = element_rect(colour = "black", fill = NA, linewidth = 1),
    strip.background = element_rect(fill = "white", colour = "black", linewidth = 0.7),
    legend.position = "top",
    panel.spacing.y = unit(1, "cm"),
    axis.text.x = element_text(size = 8),
    axis.ticks.x = element_line(),
    axis.line.x = element_line()
  )