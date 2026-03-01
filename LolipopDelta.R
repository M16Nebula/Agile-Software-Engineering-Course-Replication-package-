library(tidyverse)

# ====== Podatki ======

# Podatki "pred"
pred_data <- tribble(
  ~activity, ~v1, ~v2, ~v3, ~v4, ~v5, ~v6, ~v7, ~v8, ~v9, ~v10, ~v11, ~v12, ~v13, ~v14, ~v15, ~v16, ~v17, ~v18, ~v19, ~v20, ~v21, ~v22, ~v23,
  "Writing code", 5,4,1,4,3,4,3,3,5,4,3,3,4,4,2,4,3,3,3,3,1,5,5,
  "Testing code", 3,4,1,2,2,3,2,4,4,4,2,4,3,4,3,2,4,2,4,2,1,4,5,
  "Search for anwers", 4,4,2,2,4,4,5,5,5,4,3,4,5,4,3,4,5,4,4,3,2,4,5,
  "Project planning", 2,3,2,2,2,3,1,2,5,4,3,2,4,2,2,2,1,4,1,2,3,3,5,
  "Predictive analytics", 2,4,1,2,1,3,2,1,5,4,1,2,4,3,3,1,2,2,1,2,3,2,5,
  "Learning about a codebase", 4,2,1,4,1,4,4,4,5,4,3,4,5,4,2,1,3,3,2,3,4,4,5,
  "Generating content or synthetic data", 4,1,2,4,4,2,2,2,3,4,3,2,4,1,5,3,5,2,2,3,4,4,5,
  "Documenting code", 2,2,1,1,3,2,1,4,4,4,1,3,3,4,4,5,2,2,3,4,3,3,5,
  "Deployment and monitoring", 2,2,1,4,1,2,1,2,3,4,1,4,3,2,1,3,1,3,1,2,1,3,5,
  "Debugging and getting help", 4,5,1,5,3,4,3,5,5,4,3,4,5,5,1,4,4,4,4,3,4,5,5,
  "Committing and reviewing code", 3,2,1,3,1,1,1,2,3,1,1,3,3,2,1,3,1,2,1,3,2,3,5
)

# Podatki "po"
po_data <- tribble(
  ~activity, ~v1, ~v2, ~v3, ~v4, ~v5, ~v6, ~v7, ~v8, ~v9, ~v10, ~v11, ~v12, ~v13, ~v14, ~v15, ~v16, ~v17, ~v18, ~v19, ~v20, ~v21, ~v22, ~v23,
  "Writing code", 5,4,1,4,3,5,3,5,5,4,4,3,2,4,2,4,4,4,5,4,1,5,5,
  "Testing code", 4,4,1,2,2,1,3,2,3,1,2,2,4,1,3,2,4,2,3,2,1,2,1,
  "Search for anwers", 4,4,2,2,3,4,5,4,4,2,4,4,5,4,3,3,4,5,5,4,4,4,5,
  "Project planning", 3,1,1,2,2,3,3,1,4,2,1,2,4,1,3,3,1,3,2,2,2,4,5,
  "Predictive analytics", 2,1,1,1,2,2,4,1,3,1,1,1,4,1,2,2,1,1,1,2,1,3,5,
  "Learning about a codebase", 2,3,1,4,1,4,1,5,1,3,3,4,3,5,1,1,3,1,2,3,1,5,5,
  "Generating content or synthetic data", 4,1,2,5,5,3,2,1,1,1,4,3,4,1,5,1,5,5,1,2,4,3,1,
  "Documenting code", 2,2,1,1,4,2,1,2,3,1,4,3,4,4,4,4,1,2,1,4,2,2,5,
  "Deployment and monitoring", 2,1,1,2,1,1,1,1,1,1,1,2,3,1,1,1,1,1,1,2,1,3,1,
  "Debugging and getting help", 5,4,2,2,4,3,5,4,4,4,5,4,4,4,3,5,4,3,5,4,4,5,1,
  "Committing and reviewing code", 2,1,1,4,1,1,4,2,3,1,1,1,4,2,4,1,1,1,2,2,1,3,1
)

# ====== Priprava podatkov ======
# Pretvorba v dolg format in označba časa
combined <- bind_rows(
  pred_data %>%
    pivot_longer(-activity, names_to = "id", values_to = "score") %>%
    mutate(time = "Pred"),
  po_data %>%
    pivot_longer(-activity, names_to = "id", values_to = "score") %>%
    mutate(time = "Po")
)

# Izračun povprečnih ocen
combined_summary <- combined %>%
  group_by(activity, time) %>%
  summarise(mean_score = mean(score), .groups = "drop") %>%
  pivot_wider(names_from = time, values_from = mean_score) %>%
  mutate(
    delta = round(Po - Pred, 2),
    activity_short = recode(activity,
                            "Writing code" = "Writing code",
                            "Testing code" = "* Testing code (sig.)",
                            "Search for anwers" = "Search for anwers",
                            "Project planning" = "Project planning",
                            "Predictive analytics" = "Predictive analytics",
                            "Learning about a codebase" = "* Learning about a codebase (sig.)",
                            "Generating content or synthetic data" = "Generating content or synthetic data",
                            "Documenting code" = "Documenting code",
                            "Deployment and monitoring" = "* Deployment and monitoring (sig.)",
                            "Debugging and getting help" = "Debugging and getting help",
                            "Committing and reviewing code" = "Committing and reviewing code"
    )
  ) %>%
  arrange(desc(abs(delta))) %>%
  mutate(
    activity = factor(activity, levels = activity),
    activity_short = factor(activity_short, levels = activity_short),
    activity_num = as.numeric(activity)
  )

# Priprava za graf
combined_long <- combined_summary %>%
  pivot_longer(cols = c(Pred, Po), names_to = "time", values_to = "mean_score") %>%
  mutate(
    time = factor(time, levels = c("Pred", "Po")),
    activity_num = as.numeric(activity)
  )

# ====== Risanje grafa ======
ggplot(combined_long, aes(x = mean_score, y = activity_num, color = time)) +
  geom_line(aes(group = activity_num), color = "grey60", linewidth = 1.3) +
  geom_point(size = 4) +
  geom_text(data = combined_summary,
            aes(x = (Pred + Po)/2, y = activity_num + 0.45, label = paste0("Δ=", delta)),
            inherit.aes = FALSE,
            color = "black", size = 4) +
  scale_color_manual(values = c("Pred" = "darkgreen", "Po" = "red")) +
  scale_x_continuous(limits = c(1.0, 5.0), breaks = 1:5,minor_breaks = seq(1, 5, 0.2)) +
  scale_y_continuous(
    breaks = combined_summary$activity_num,
    labels = combined_summary$activity_short,
    expand = expansion(add = c(0.5, 0.5))
  ) +
  labs(x = NULL, y = NULL
    #title = "Double Lollipop Diagram: Povprečne ocene pred in po (urejeno po Δ)",
    #x = "Povprečna ocena",
    #y = "Aktivnost",
    #color = "Time"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    panel.grid.major.x = element_line(color = "grey80", linetype = "dashed"),
    panel.grid.major.y = element_line(color = "grey90"),
    panel.grid.minor.x = element_line(color = "grey90", linetype = "dashed"),
    axis.text = element_text(size = 11, face = "bold"),
    axis.title = element_text(face = "bold"),
    plot.title = element_text(face = "bold", hjust = 0.5),
    legend.position = "none",
    panel.border = element_rect(color = "black", fill = NA, linewidth = 1),
    plot.margin = margin(15, 15, 15, 15),
    theme(text = element_text(family = "sans"))
  ) +
  coord_cartesian(clip = "off")