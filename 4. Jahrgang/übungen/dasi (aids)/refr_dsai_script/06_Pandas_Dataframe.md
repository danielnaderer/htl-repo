<img src="./resources/HTLstp-RGB150.png" alt="HTL" width=200>
<ul style="list-style-type:circle;">
  <li>REFR - Prof. Franz Reichel</li>
  <li>DSAI - Data Science and Artificial Intelligence - 4XHIF</li>
</ul>

---
# 🐼 Was ist ein Pandas DataFrame?

Ein **DataFrame** ist das zentrale Datenobjekt in **pandas** – eine **intelligente Tabelle für Python**.

---

## 🧩 Aufbau

- **Zeilen** = Beobachtungen / Datensätze  
- **Spalten** = Merkmale / Variablen  
- **Index** = Zeilenbeschriftung (ähnlich wie Zeilennummern, aber frei wählbar)

Beispiel:

| Index | Name    | Alter | Stadt   |
|------:|--------|------:|--------|
| 0     | Alice  | 25    | Berlin |
| 1     | Bob    | 30    | Hamburg |
| 2     | Charlie| 35    | München |

Jede **Spalte** ist intern eine `pandas.Series` (ähnlich einem beschrifteten NumPy-Array).  
Jede **Zeile** ist ein kompletter Datensatz.

---

## 🔑 Eigenschaften

- **Zweidimensional** (wie eine Tabelle oder ein Excel-Sheet)
- Kann **unterschiedliche Datentypen** pro Spalte enthalten (Zahlen, Text, Datum …)
- Mächtige Funktionen zum **Filtern, Gruppieren, Zusammenfassen, Umformen**

---

## 💡 Beispiel in Python

```python
import pandas as pd

data = {
    "Name": ["Alice", "Bob", "Charlie"],
    "Alter": [25, 30, 35],
    "Stadt": ["Berlin", "Hamburg", "München"]
}

df = pd.DataFrame(data)
print(df)
```

Ausgabe:

```
      Name  Alter     Stadt
0    Alice     25    Berlin
1      Bob     30   Hamburg
2  Charlie     35   München
```

---

## 🎯 Stärken des DataFrames

| Fähigkeit                | Nutzen                                                     |
|--------------------------|------------------------------------------------------------|
| **Filtern/Indexieren**   | `df[df["Alter"] > 30]` → nur Personen >30                 |
| **Gruppieren/Aggregieren** | `df.groupby("Stadt").mean()`                             |
| **Fehlende Werte**       | `df.dropna()`, `df.fillna(0)`                              |
| **Lesen/Schreiben**      | `read_csv`, `to_excel`, `to_sql` usw.                      |
| **Join/Merge**           | Tabellen verbinden wie in SQL                               |
| **Vektorisierte Berechnungen** | Sehr schnell, da intern NumPy-Arrays genutzt werden   |

---

## 📊 Bildhafter Vergleich

- **Excel-Tabelle**: ähnlich, aber pandas kann Millionen Zeilen effizient handhaben und ist skriptgesteuert.
- **SQL-Tabelle**: vergleichbar, aber DataFrame arbeitet direkt in Python und ohne Datenbankserver.

---

### ✨ Kurz gesagt

Ein **DataFrame** ist eine **mächtige, programmierbare Tabelle**, die
- **wie Excel aussieht**,
- **wie SQL arbeitet**, und
- **die Geschwindigkeit von NumPy** nutzt.

Damit kannst du in Python **Daten einlesen, bereinigen, analysieren und visualisieren** – alles in einem einzigen, komfortablen Objekt.
