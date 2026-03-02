library(tidyverse)

# Data input
data <- tribble(
  ~KORF1, ~KORF2, ~KORF3, ~KORF4, ~KORF5, ~Effort,
  4, 3, 5, 4, 5, "Above",
  4, 5, 5, 4, 4, "Below",
  4, 2, 2, 3, 3, "Below",
  4, 5, 4, 3, 4, "Above",
  4, 5, 2, 2, 4, "Above",
  4, 3, 3, 4, 4, "Below",
  5, 4, 5, 2, 5, "Above",
  4, 4, 4, 4, 4, "Above",
  4, 2, 3, 2, 4, "Below",
  4, 2, 3, 3, 5, "Above",
  4, 1, 4, 3, 3, "Below",
  3, 3, 4, 4, 4, "Above",
  5, 3, 4, 3, 3, "Below",
  4, 2, 4, 3, 4, "Below",
  5, 5, 5, 5, 5, "Above",
  4, 2, 5, 4, 3, "Below",
  4, 2, 5, 4, 3, "Above",
  4, 3, 4, 4, 4, "Above",
  4, 2, 1, 1, 4, "Below",
  4, 4, 3, 4, 4, "Below",
  5, 4, 3, 2, 5, "Above",
  4, 5, 4, 3, 4, "Below",
  5, 5, 5, 1, 5, "Above"
)

# Reshape to long format
data_long <- data %>%
  pivot_longer(cols = starts_with("KORF"), names_to = "Item", values_to = "Score") %>%
  mutate(Item = factor(Item, levels = paste0("KORF", 1:5)))

# Calculate means
means_df <- data_long %>%
  group_by(Item, Effort) %>%
  summarise(Mean = mean(Score), .groups = "drop")

# Plot horizontal bars (transposed Likert scale)
ggplot(data_long, aes(y = Score, fill = Effort)) +
  geom_bar(data = subset(data_long, Effort == "Above"), aes(x = ..count..), position = "dodge", color = "black") +
  geom_bar(data = subset(data_long, Effort == "Below"), aes(x = -..count..), position = "dodge", color = "black") +
  # Mean lines (vertical now)
  geom_vline(data = subset(means_df, Effort == "Above"), aes(xintercept = Mean), color = "forestgreen", linetype = "dashed", size = 0.7) +
  geom_vline(data = subset(means_df, Effort == "Below"), aes(xintercept = -Mean), color = "firebrick", linetype = "dashed", size = 0.7) +
  # Bold vertical line at 0
  geom_vline(xintercept = 0, linetype = "solid", color = "black", size = 1.2) +
  facet_wrap(
    ~Item, 
    ncol = 5, 
    scales = "fixed",
    labeller = labeller(Item = c(
      "KORF1" = "Sprint Planning",
      "KORF2" = "Daily Scrum",
      "KORF3" = "Sprint Review",
      "KORF4" = "Sprint Retrospective",
      "KORF5" = "Sprint Phase (*)"
    ))
  ) +
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
    name = "Project Effort"
  ) +
  labs(
    y = "Likert Score",
    x = "Frequency",
    #caption = "Likert scale: 1 = Strongly Disagree, 5 = Strongly Agree"
  ) +
  theme_bw() +
  theme(
    panel.border = element_rect(colour = "black", fill = NA, size = 1),
    strip.background = element_rect(fill = "white", colour = "black"),
    legend.position = "top",
    panel.spacing.y = unit(1, "cm"),
    axis.text.x = element_text(size = 8),
    axis.ticks.x = element_line(),
    axis.line.x = element_line()
  )
