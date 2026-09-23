<img src="./resources/HTLstp-RGB150.png" alt="HTL" width=200>
<ul style="list-style-type:circle;">
  <li>REFR - Prof. Franz Reichel</li>
  <li>DSAI - Data Science and Artificial Intelligence - 4XHIF</li>
</ul>

---
# 🔄 Pivot-Tabelle – Einfach erklärt

Eine **Pivot-Tabelle** fasst Daten zusammen und ordnet sie neu, damit du schnell Antworten auf Fragen findest wie:

*„Wie viel Umsatz hatte ich pro Produkt und pro Tag?“*  
*„Wie viele Kunden kamen pro Monat aus jeder Stadt?“*

---

## 🧩 Grundidee
Stell dir eine **Excel-Tabelle** mit vielen Zeilen (Einkäufe) vor.  
Du möchtest die Daten so umstellen, dass:

* **Zeilen** → z. B. die **Tage** stehen  
* **Spalten** → z. B. die **Produkte** stehen  
* **Werte** → z. B. der **Gesamtumsatz** pro Tag & Produkt berechnet wird

So entsteht eine neue Tabelle, in der du Muster sofort erkennst.

---

## 🐼 Pivot in Pandas

In Pandas erzeugst du eine Pivot-Tabelle mit `pivot_table`.

### Beispiel

```python
import pandas as pd

# Beispiel-Daten
data = {
    "Tag": ["Mo","Mo","Di","Di","Di"],
    "Produkt": ["Apfel","Banane","Apfel","Banane","Apfel"],
    "Umsatz": [5, 7, 3, 4, 6]
}
df = pd.DataFrame(data)

# Pivot-Tabelle erstellen
pivot = df.pivot_table(
    values="Umsatz",     # zusammenzufassende Werte
    index="Tag",         # Zeilen
    columns="Produkt",   # Spalten
    aggfunc="sum",       # Aggregationsfunktion (sum, mean, count ...)
    fill_value=0         # fehlende Werte mit 0 füllen
)
print(pivot)
```

### Ausgabe

| Tag | Apfel | Banane |
|----|------|-------|
| Di |   9  |   4   |
| Mo |   5  |   7   |

---

## 💡 Warum nützlich?

* **Verdichtung:** Große Datenmengen auf einen Blick zusammenfassen.
* **Analyse:** Erkennen, wo Umsätze oder Mengen am höchsten sind.
* **Flexibilität:** Leicht zwischen Summe, Mittelwert, Zählung usw. wechseln.

---

Kurz gesagt:  
**Pivot-Tabellen verwandeln viele einzelne Datensätze in eine übersichtliche Zusammenfassung – ideal für Berichte und Datenanalyse.**
