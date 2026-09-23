<img src="./resources/HTLstp-RGB150.png" alt="HTL" width=200>
<ul style="list-style-type:circle;">
  <li>REFR - Prof. Franz Reichel</li>
  <li>DSAI - Data Science and Artificial Intelligence - 4XHIF</li>
</ul>

---

# 🐼 Pandas Beispiele

[Pandas](https://pandas.pydata.org/) ist die Standard-Bibliothek für **Datenanalyse** in Python.

## 🌟 Grundideen
- **Series (1D)** – Eine beschriftete Datenreihe (wie eine einzelne Excel-Spalte).  
- **DataFrame (2D)** – Eine Tabelle aus vielen Series mit gemeinsamem Index.

---

## 🔹 Import
```python
import pandas as pd
```

---

## 🔹 Daten einlesen
```python
pd.read_csv("datei.csv")           # CSV
pd.read_excel("datei.xlsx")        # Excel
pd.read_json("data.json")          # JSON

pd.set_option('display.width', 120)
➡️ legt fest, wie viele Zeichen pro Zeile Pandas beim Anzeigen eines DataFrames nutzt.
    - Standard: meist 80
    - Wenn du viele Spalten hast, bricht Pandas die Ausgabe sonst schnell in mehrere Zeilen um.
    - Mit 120 (oder 200, 250 usw.) bleibt alles übersichtlicher in einer Zeile.

pd.set_option('display.max_columns', 20)
➡️ legt fest, wie viele Spalten Pandas gleichzeitig anzeigt.
    - Wenn dein DataFrame z. B. 50 Spalten hat, zeigt Pandas standardmäßig nur ein paar links und rechts,
    - und in der Mitte steht dann ...
    - Mit dieser Option sagst du: Zeig mir bis zu 20 Spalten gleichzeitig.
```

---

## 🔹 DataFrame & Series erstellen
```python
# 1D: Series
s = pd.Series([10, 20, 30], name="Werte")

# 2D: DataFrame
data = {"Name": ["Anna", "Ben"], "Alter": [23, 31]}
df = pd.DataFrame(data)
```
👉 `df["Name"]` gibt eine **Series** zurück, `df[["Name"]]` bleibt **DataFrame**.

---

## 🔹 Erste Blicke
```python
df.head(3)        # erste 3 Zeilen
df.tail(2)        # letzte 2 Zeilen
df.sample(5)      # zufällige 5 Zeilen

df.info(verbose=True, memory_usage="deep", show_counts=True)
# verbose=True       → alle Spalten anzeigen
# memory_usage="deep"→ exakte Speicherinfo
# show_counts=True   → Anzahl Nicht-NaN pro Spalte
df.describe(include="all")  # auch nicht-numerische Spalten
df.shape          # (Zeilen, Spalten)
df.columns        # Spaltennamen
df.dtypes         # Datentypen
```

---

## 🔹 Auswahl & Slicing

### Grundlagen
```python
df["Name"]            # Series (1D)
df[["Name","Alter"]]  # DataFrame (2D)
df.iloc[0]            # Zeile nach Position (0-basiert) → Series
df.iloc[0, 1]         # Einzelwert (Zeile 0, Spalte 1)
df.loc[0]             # Zeile nach Label (Indexwert 0) → Series
df.loc[0, "Name"]     # Einzelwert (Index 0, Spalte "Name")
```
💡 **iloc = integer location**, nur **Positionszahlen**.  
💡 **loc  = label location**, benutzt **Indexnamen/Labels** (auch Booleans, Listen, Slices).

### Bedingungen & Logik
```python
# Einfache Filter
df[df["Alter"] > 25]

# Mehrere Bedingungen – wichtig: () um jede Bedingung!
df[(df["Alter"] > 20) & (df["Name"] == "Anna")]  # UND
df[(df["Alter"] < 30) | (df["Name"] == "Ben")]   # ODER
df[~(df["Name"].isin(["Anna","Ben"]))]          # NICHT
df[(df["Alter"] > 20) ^ (df["Name"] == "Anna")]  # XOR
```

---

## 🔹 Spaltenzugriff
```python
df.Name           # Kurzform für df["Name"], nur wenn Name kein Leerzeichen/Sonderzeichen hat
df.Age.mean()     # Funktionsaufruf direkt
```

---

## 🔹 Bearbeiten & Erzeugen
```python
df["Neu"] = df["Alter"] + 10
df.rename(columns={"Alter":"Age"}, inplace=True)
df.drop("Neu", axis=1, inplace=True)
df.drop(0, axis=0, inplace=True)
```

---

## 🔹 Fehlende Werte
```python
df.isna()
df.dropna()
df.fillna({"Age":0})
```

---

## 🔹 Gruppieren & Aggregieren
```python
df.groupby("Name")["Alter"].mean()
df["Alter"].agg(["mean","max","min"])
```

---

## 🔹 Anwenden von Funktionen
```python
# apply auf Spalte
df["Alter_plus5"] = df["Alter"].apply(lambda x: x + 5)

# apply auf Zeile
def alter_klasse(row):
    return "jung" if row.Age < 30 else "alt"
df["Klasse"] = df.apply(alter_klasse, axis=1)
```

---

## 🔹 Sortieren
```python
df.sort_values("Alter", ascending=False)
```

---

## 🔹 Zusammenführen / Join / Merge
```python
pd.merge(df1, df2, on="id", how="inner")
pd.concat([df1, df2], ignore_index=True)
```

---

## 🔹 Export
```python
df.to_csv("output.csv", index=False)
df.to_excel("output.xlsx", index=False)
```

---

## 🧠 Zusammenfassung
- **Series (1D)** = eine beschriftete Spalte  
- **DataFrame (2D)** = Tabelle aus mehreren Series  
- **iloc** = positionsbasiert, **loc** = labelbasiert  
- Boolesche Logik mit `&` (UND), `|` (ODER), `^` (XOR), `~` (NICHT).  
- `apply()` erlaubt eigene Funktionen für flexible Berechnungen.

✅ Mit diesen Befehlen hast du ein sehr umfassendes Werkzeugset für Pandas.
