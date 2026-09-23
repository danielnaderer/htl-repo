<img src="./resources/HTLstp-RGB150.png" alt="HTL" width=200>
<ul style="list-style-type:circle;">
  <li>REFR - Prof. Franz Reichel</li>
  <li>DSAI - Data Science and Artificial Intelligence - 4XHIF</li>
</ul>

---
# 📊 Kostenlose Datensätze für Pandas-Übungen

Hier findest du **kostenlose, öffentlich zugängliche Datensätze**, perfekt zum Üben mit Pandas.

---

## 🌐 Plattformen mit vielen Themen
| Quelle | Inhalt | Tipp |
|-------|-------|-----|
| [**Kaggle Datasets**](https://www.kaggle.com/datasets) | Riesen-Auswahl: Sport, Gesundheit, Finanzen, Spiele, Natur, Text, Bilder | Kostenloser Account, Download als CSV, direkt mit `pd.read_csv()` nutzbar |
| [**Google Dataset Search**](https://datasetsearch.research.google.com/) | Suchmaschine für offene Datensätze weltweit | Einfach Stichwörter eingeben, z. B. „climate csv“ |
| [**data.world**](https://data.world/) | Community-Plattform für offene Daten | Viele CSV-Dateien, gute API |
| [**GitHub – Awesome Public Datasets**](https://github.com/awesomedata/awesome-public-datasets) | Riesen-Liste nach Kategorien | Praktisch zum Stöbern |

---

## 🐼 Direkt für Pandas geeignet (CSV/TSV)
| Quelle | Beispiel-Datensätze |
|-------|---------------------|
| **UCI Machine Learning Repository** – [archive.ics.uci.edu](https://archive.ics.uci.edu/) | Klassiker wie *Iris*, *Wine*, *Adult Income* |
| **FiveThirtyEight Data** – [data.fivethirtyeight.com](https://data.fivethirtyeight.com/) | Journalismus-Daten: Wahlen, Sport, Gesellschaft |
| **Open Data Portale** | z. B. [data.gov](https://www.data.gov/), [data.europa.eu](https://data.europa.eu/) |

---

## 🔥 Spaßige Beispiele für Pandas-Übungen
- **Movies & Series:** [TMDb Movies Dataset auf Kaggle](https://www.kaggle.com/datasets/tmdb/tmdb-movie-metadata)
- **Games:** Steam-Spielbewertungen, Videospiel-Verkäufe
- **Food & Drinks:** Weltweite Kaffeepreise, Bierbewertungen
- **Sport:** Fußball- oder NBA-Statistiken
- **Umwelt:** Wetter- und Klimadaten, Luftqualität

---

## 🏁 Sofort loslegen
Mit Seaborn kannst du ohne Download üben:
```python
import seaborn as sns
df = sns.load_dataset("titanic")  # oder "tips", "penguins"
```

---

## 🎮 Beispiel: Mini-Steam-Datensatz

Erstelle eine kleine CSV-Datei `steam_mini.csv`:
```csv
Name,Genre,Preis,Reviews_Pos,Reviews_Total
Half-Life 2,Action,8.99,9500,10000
Stardew Valley,Simulation,13.99,45000,47000
Portal 2,Puzzle,9.99,30000,31000
Among Us,Party,4.99,100000,120000
Hades,Roguelike,24.99,55000,60000
```

### Auswertung in Pandas
```python
import pandas as pd

df = pd.read_csv("steam_mini.csv")

# Prozent positiver Bewertungen
df["Positiv_%"] = df["Reviews_Pos"] / df["Reviews_Total"] * 100

# Günstigste Spiele mit >90% positiver Bewertung
print(df[df["Positiv_%"] > 90].sort_values("Preis"))
```

Diese Mini-Übung zeigt:
* **Berechnete Spalten** (`Positiv_%`)
* **Filterung & Sortierung** mit Pandas
