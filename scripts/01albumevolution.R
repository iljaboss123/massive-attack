library(tidyverse)

# --------------------------------------------------
# 1. Load cleaned dataset
# --------------------------------------------------
tracks <- read_csv("data/massive_attack_tracks_clean.csv", show_col_types = FALSE)

# --------------------------------------------------
# 2. Ensure album order is chronological
# --------------------------------------------------
album_order <- c(
  "Blue Lines",
  "Protection",
  "Mezzanine",
  "100th Window",
  "Heligoland"
)

tracks <- tracks %>%
  mutate(
    album_name = factor(album_name, levels = album_order, ordered = TRUE)
  )

# --------------------------------------------------
# 3. Quick check
# --------------------------------------------------
summary(
  tracks %>%
    select(danceability, energy, valence, acousticness, loudness)
)

# --------------------------------------------------
# 4. Album-level summary
# --------------------------------------------------
album_summary <- tracks %>%
  group_by(album_name) %>%
  summarise(
    n_tracks = n(),
    avg_valence = mean(valence, na.rm = TRUE),
    avg_energy = mean(energy, na.rm = TRUE),
    avg_acousticness = mean(acousticness, na.rm = TRUE),
    avg_loudness = mean(loudness, na.rm = TRUE),
    .groups = "drop"
  )

print(album_summary)

# ==================================================
# 5. Visualisations
# ==================================================

# --------------------------------------------------
# Plot: Valence
# --------------------------------------------------
p_valence <- ggplot(album_summary, aes(x = album_name, y = avg_valence, group = 1)) +
  geom_line(linewidth = 1) +
  geom_point(size = 3) +
  labs(
    title = "Massive Attack: Average Valence by Album",
    x = "Album",
    y = "Average valence"
  ) +
  theme_minimal()

print(p_valence)

# --------------------------------------------------
# Plot: Energy
# --------------------------------------------------
p_energy <- ggplot(album_summary, aes(x = album_name, y = avg_energy, group = 1)) +
  geom_line(linewidth = 1) +
  geom_point(size = 3) +
  labs(
    title = "Massive Attack: Average Energy by Album",
    x = "Album",
    y = "Average energy"
  ) +
  theme_minimal()

print(p_energy)

# --------------------------------------------------
# Plot: Acousticness
# --------------------------------------------------
p_acousticness <- ggplot(album_summary, aes(x = album_name, y = avg_acousticness, group = 1)) +
  geom_line(linewidth = 1) +
  geom_point(size = 3) +
  labs(
    title = "Massive Attack: Average Acousticness by Album",
    x = "Album",
    y = "Average acousticness"
  ) +
  theme_minimal()

print(p_acousticness)

# --------------------------------------------------
# Plot: Loudness
# --------------------------------------------------
p_loudness <- ggplot(album_summary, aes(x = album_name, y = avg_loudness, group = 1)) +
  geom_line(linewidth = 1) +
  geom_point(size = 3) +
  labs(
    title = "Massive Attack: Average Loudness by Album",
    x = "Album",
    y = "Average loudness (dB)"
  ) +
  theme_minimal()

print(p_loudness)

# --------------------------------------------------
# 6. Save plots
# --------------------------------------------------
dir.create("plots", showWarnings = FALSE)

ggsave("plots/avg_valence_by_album.png", p_valence, width = 8, height = 5)
ggsave("plots/avg_energy_by_album.png", p_energy, width = 8, height = 5)
ggsave("plots/avg_acousticness_by_album.png", p_acousticness, width = 8, height = 5)
ggsave("plots/avg_loudness_by_album.png", p_loudness, width = 8, height = 5)


