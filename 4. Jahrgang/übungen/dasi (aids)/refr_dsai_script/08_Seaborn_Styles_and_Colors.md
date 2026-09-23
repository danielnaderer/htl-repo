<img src="./resources/HTLstp-RGB150.png" alt="HTL" width=200>
<ul style="list-style-type:circle;">
  <li>REFR - Prof. Franz Reichel</li>
  <li>DSAI - Data Science and Artificial Intelligence - 4XHIF</li>
</ul>

---

# 🎨 Seaborn Styles, Farben & Layouts

## 🎯 Ziel
Dieses Handout zeigt, wie du Seaborn-Grafiken mit **Farben, Themes, Styles und Layouts** verschönerst.  
Es umfasst alle wichtigen Optionen von **Farbschemata**, **Designs** und **Rahmenanpassungen** bis hin zu `sns.despine()`.

---

## ⚙️ Basis-Setup
```python
import seaborn as sns
import matplotlib.pyplot as plt

sns.set_theme(style="whitegrid", context="notebook", palette="deep")
```
- **style:** `"darkgrid"`, `"whitegrid"`, `"dark"`, `"white"`, `"ticks"`  
- **context:** `"paper"`, `"notebook"`, `"talk"`, `"poster"`  
- **palette:** `"deep"`, `"muted"`, `"pastel"`, `"bright"`, `"dark"`, `"colorblind"`

💡 *Tipp:*  
- Unterricht & Präsentation → `context="talk"` oder `"poster"`  
- Saubere Reports → `style="whitegrid"`  
- Barrierefreiheit → `palette="colorblind"`

---

## 🧩 Stil- und Kontextanpassung
```python
sns.set_style("ticks")
sns.set_context("talk", font_scale=1.1)
sns.set_palette("pastel")
```
**Spines entfernen:**  
```python
sns.despine()
sns.despine(left=True)     # entfernt auch linke Achse
sns.despine(offset=10)     # kleiner Abstand zur Achse
```

---

## 🌈 Farbpaletten-Typen

### 🔸 Qualitativ (Kategorien)
```python
sns.color_palette("Set2", n_colors=6)
```

### 🔸 Sequenziell (Werteverlauf)
```python
pal = sns.color_palette("viridis", as_cmap=True)
```

### 🔸 Divergierend (um Nullpunkt herum)
```python
div = sns.diverging_palette(240, 10, s=90, l=50, as_cmap=True)
```

### 🔸 Zyklisch (z. B. Phasen)
```python
cyc = sns.cubehelix_palette(start=.5, rot=-.75, as_cmap=True)
```

---

## 🎨 Eigene Paletten
```python
custom = sns.color_palette(["#0ea5e9", "#22c55e", "#f59e0b", "#ef4444"])
sns.set_palette(custom)

greens = sns.light_palette("#16a34a", n_colors=8)
reds   = sns.dark_palette("#dc2626", n_colors=8)
```

---

## 📊 Paletten in Plots
```python
df = sns.load_dataset("penguins")
sns.scatterplot(data=df, x="bill_length_mm", y="bill_depth_mm",
                hue="species", palette="Set2", s=70, edgecolor="none")
sns.despine()
plt.title("Scatter mit Set2-Palette")
plt.show()
```

---

## 🔥 Heatmaps mit Farbverlauf
```python
corr = df.corr(numeric_only=True)
cmap = sns.diverging_palette(250, 15, s=95, l=40, as_cmap=True)
sns.heatmap(corr, annot=True, fmt=".2f", cmap=cmap, center=0, linewidths=0.5)
sns.despine(left=True, bottom=True)
plt.title("Korrelationsmatrix (diverging colormap)")
plt.show()
```

---

## 🖌️ Kontexte für Präsentationen
```python
sns.set_context("talk", font_scale=1.2, rc={"lines.linewidth": 2.5})
```
**Tipp:**  
`rc={}` erlaubt das gezielte Überschreiben von Matplotlib-Parametern (z. B. Schriftgröße, Linienbreite).

---

## ⚙️ Style feinjustieren
```python
sns.set_style("whitegrid", {
    "axes.edgecolor": ".2", 
    "grid.color": ".9", 
    "axes.grid": True,
    "grid.linestyle": "--"
})
```

---

## 💡 Komplettes Beispiel
```python
df = sns.load_dataset("penguins")
sns.set_theme(style="whitegrid", context="talk", palette="colorblind")

# Scatterplot
sns.scatterplot(data=df, x="bill_length_mm", y="bill_depth_mm", hue="species", style="sex", s=80)
sns.despine()
plt.title("Schnabelmaße nach Species & Sex")
plt.show()

# Histogramm
sns.histplot(data=df, x="flipper_length_mm", hue="species", kde=True, element="step")
sns.despine()
plt.title("Flossenlängen – Verteilungen je Species")
plt.show()

# Boxplot
order = df.groupby("species")["body_mass_g"].median().sort_values().index
sns.boxplot(data=df, x="species", y="body_mass_g", order=order)
sns.despine()
plt.title("Körpergewicht (Median-sortiert)")
plt.show()

# Heatmap
cmap = sns.cubehelix_palette(start=.5, rot=-.5, as_cmap=True)
corr = df.corr(numeric_only=True)
sns.heatmap(corr, cmap=cmap, annot=True, fmt=".2f")
sns.despine(left=True, bottom=True)
plt.title("Korrelationen (cubehelix)")
plt.show()
```

---

## 🧩 `sns.despine()` – Achsenrahmen entfernen

`sns.despine()` entfernt Rahmenlinien (engl. *spines*) und sorgt für ein minimalistisches, modernes Design.

### Beispiel:
```python
sns.scatterplot(data=df, x="bill_length_mm", y="bill_depth_mm")
sns.despine()
plt.title("Ohne obere und rechte Achsenlinie")
plt.show()
```

### Erweiterte Optionen
```python
sns.despine(left=True, bottom=True)  # alle Linien entfernen
sns.despine(offset=10)               # Achsen leicht nach innen verschieben
```

### Vorteile:
| Vorteil | Beschreibung |
|----------|---------------|
| ✨ Ästhetik | Modernes, minimalistisches Design |
| 🧠 Fokus | Der Blick liegt auf den **Daten**, nicht auf Rahmenlinien |
| 📚 Lesbarkeit | Besonders für Präsentationen & Reports |
| 📰 Wissenschaftlich | Standard in vielen Paper-Grafiken |

---

## 🚀 Empfehlungskombi
```python
sns.set_theme(style="whitegrid", context="talk", palette="colorblind")
sns.despine()
```
💬 „Entferne den Lärm – zeige die Daten.“

---

## 🧠 Fazit
Seaborn bietet unzählige Möglichkeiten, deine Diagramme optisch zu verbessern:  
Farben, Paletten, Themes und Layouts – alles mit wenigen Zeilen Code.  
Und mit `sns.despine()` machst du jedes Diagramm **präsentationsreif**.
