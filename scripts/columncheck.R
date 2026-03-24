library(tidyverse)

tracks <- read_delim(
  "data/full_massive_attack_catalogue.csv",
  delim = ";",
  locale = locale(encoding = "Latin1"),
  show_col_types = FALSE
)

glimpse(tracks)
colnames(tracks)

tracks <- tracks %>%
  rename(
    track_uri = `Track URI`,
    track_name = `Track Name`,
    album_name = `Album Name`,
    artist_names = `Artist Name(s)`,
    release_date = `Release Date`,
    duration_ms = `Duration (ms)`,
    popularity = `Popularity`,
    explicit = `Explicit`,
    added_by = `Added By`,
    added_at = `Added At`,
    genres = `Genres`,
    record_label = `Record Label`,
    danceability = `Danceability`,
    energy = `Energy`,
    key = `Key`,
    loudness = `Loudness`,
    mode = `Mode`,
    speechiness = `Speechiness`,
    acousticness = `Acousticness`,
    instrumentalness = `Instrumentalness`,
    liveness = `Liveness`,
    valence = `Valence`,
    tempo = `Tempo`,
    time_signature = `Time Signature`
  )
summary(tracks %>% select(danceability, energy, speechiness, acousticness, instrumentalness, liveness, valence, tempo, loudness))

tracks <- tracks %>%
  mutate(
    danceability = danceability / 1000,
    energy = energy / 1000,
    speechiness = speechiness / 1000,
    acousticness = acousticness / 1000,
    instrumentalness = instrumentalness / 1000,
    liveness = liveness / 1000,
    valence = valence / 1000,
    tempo = tempo / 1000,
    loudness = loudness / 1000
  )

summary(tracks %>% select(danceability, energy, valence, tempo, loudness))

write_csv(tracks, "data/massive_attack_tracks_clean.csv")
