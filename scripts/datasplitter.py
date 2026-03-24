from pathlib import Path
import pandas as pd
import re

input_file = Path(r"C:\Users\iljav\Documents\musicology\massive-attack\data\massive_attack_tracks_clean.csv")
output_dir = Path(r"C:\Users\iljav\Documents\musicology\massive-attack\data")

# cleaned file from R is likely normal comma-separated UTF-8
df = pd.read_csv(input_file)

def clean_filename(name):
    name = name.lower()
    name = re.sub(r"[^a-z0-9]+", "_", name)
    name = re.sub(r"^_|_$", "", name)
    return name

for album_name, album_df in df.groupby("album_name"):
    filename = clean_filename(str(album_name)) + ".csv"
    album_df.to_csv(output_dir / filename, index=False)
    print(f"Saved: {filename}")