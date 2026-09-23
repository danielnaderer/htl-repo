<img src="./resources/HTLstp-RGB150.png" alt="HTL" width=200>
<ul style="list-style-type:circle;">
  <li>REFR - Prof. Franz Reichel</li>
  <li>DSAI - Data Science and Artificial Intelligence - 4XHIF</li>
</ul>

---

# 🐧 Einführung in Seaborn – Datenvisualisierung leicht gemacht

## 🎯 Ziel
Seaborn ist eine leistungsstarke Python-Bibliothek zur **statistischen Datenvisualisierung**, 
die auf Matplotlib aufbaut und viele Standardaufgaben vereinfacht.

---

## 💡 Warum Seaborn?
| Vorteil | Beschreibung |
|----------|---------------|
| 🎨 Ästhetisch | Automatisch schöne Standarddesigns |
| 📊 Statistisch | Integrierte Statistikplots (Boxplot, Violinplot, Regression) |
| 🧩 Einfach | Weniger Code, intuitiv mit DataFrames |
| 🧠 Intelligent | Automatische Farbwahl, Gruppierungen und Legenden |


---

## 🔹 Erste Schritte
```python
import seaborn as sns
import matplotlib.pyplot as plt

# Beispiel-Datensatz laden
df = sns.load_dataset("penguins")
df.head()
```

---

## 🔹 Beispielplots

### 1️⃣ Scatterplot – Beziehung zwischen zwei Variablen

```python
sns.scatterplot(data=df, x="bill_length_mm", y="bill_depth_mm", hue="species")
plt.title("Pinguin-Schnabel: Länge vs. Tiefe")
plt.show()
```

📘 **Beschreibung:**
Ein **Scatterplot (Punktdiagramm)** zeigt die Beziehung zwischen zwei numerischen Variablen.  
Jeder Punkt steht für eine Beobachtung.  
Hier z. B. wie sich **Schnabellänge** und **Schnabeltiefe** unterscheiden.  
Durch `hue="species"` werden die Arten farblich unterschieden.

📊 **Einsatz:**  
- Erkennung von Mustern, Gruppen oder Ausreißern  
- Analyse von Zusammenhängen (Korrelationen)

---

### 2️⃣ Histogramm mit Dichtekurve – Verteilung von Werten

```python
sns.histplot(data=df, x="flipper_length_mm", hue="species", kde=True)
plt.title("Verteilung der Flossenlänge nach Art")
plt.show()
```

📘 **Beschreibung:**
Das **Histogramm** zeigt, wie häufig bestimmte Werte vorkommen (Häufigkeitsverteilung).  
Mit `kde=True` wird zusätzlich eine **Dichtekurve** (glatte Schätzung) angezeigt.

📊 **Einsatz:**  
- Erkennen, ob Werte normalverteilt sind  
- Vergleich von Verteilungen über mehrere Gruppen (`hue`)

---

### 3️⃣ Boxplot & Violinplot – Verteilung und Ausreißer

```python
sns.boxplot(data=df, x="species", y="body_mass_g")
plt.title("Körpergewicht nach Pinguinart (Boxplot)")
plt.show()

sns.violinplot(data=df, x="species", y="body_mass_g")
plt.title("Körpergewicht nach Pinguinart (Violinplot)")
plt.show()
```

📘 **Beschreibung:**
Ein **Boxplot** zeigt Median, Quartile und Ausreißer.  
Ein **Violinplot** kombiniert den Boxplot mit einer Dichteverteilung (wie ein vertikales Histogramm).  

📊 **Einsatz:**  
- Vergleich mehrerer Gruppen oder Kategorien  
- Erkennung von Ausreißern, Medianwerten und Spannbreiten

---

### 4️⃣ Pairplot – Beziehungen zwischen allen Variablen

```python
sns.pairplot(df, hue="species")
plt.suptitle("Pinguin-Daten – Korrelationsübersicht", y=1.02)
plt.show()
```

📘 **Beschreibung:**
Der **Pairplot** erzeugt für jede Kombination von Variablen einen Scatterplot  
und zeigt auf der Diagonalen Histogramme der einzelnen Variablen.  

📊 **Einsatz:**  
- Erste **Explorationsanalysen** von Datensätzen  
- Erkennen von linearen Mustern, Clustern oder Korrelationen

---

### 5️⃣ Heatmap – Beziehungen zwischen numerischen Variablen

```python
corr = df.corr(numeric_only=True)
sns.heatmap(corr, annot=True, cmap="coolwarm", fmt=".2f")
plt.title("Korrelationsmatrix der numerischen Variablen")
plt.show()
```

📘 **Beschreibung:**
Eine **Heatmap** visualisiert eine Matrix mit Farben.  
Hier: die **Korrelationen** zwischen numerischen Variablen.  
Positive Werte (rot) bedeuten, dass zwei Variablen gemeinsam steigen;  
negative Werte (blau), dass sie gegensätzlich verlaufen.

📊 **Einsatz:**  
- Analyse von Zusammenhängen zwischen Variablen  
- Feature-Auswahl oder Data-Exploration

---

## 🎨 Bonus: Stil und Farben anpassen
```python
sns.set_style("whitegrid")  # Alternativen: darkgrid, white, dark, ticks
sns.set_palette("pastel")   # Farbpalette ändern
```

📘 **Beschreibung:**
Mit `set_style()` und `set_palette()` kannst du das Design deiner Diagramme anpassen.  
Das sorgt für konsistente, klare und moderne Visuals in Präsentationen oder Reports.

---

## 🧠 Aufgaben

1. Erstelle eigene Scatterplots mit anderen Variablen.  
2. Vergleiche Boxplot vs. Violinplot – welcher zeigt mehr Informationen?  
3. Erzeuge eine Heatmap für andere Datensätze (`iris`, `tips`).  
4. Experimentiere mit verschiedenen Themes und Paletten.  

---

## 🎯 Lernziele
* Verständnis für **statistische Plots**
* Nutzung von **Farbgruppen und Kategorien**
* Erkennen von **Zusammenhängen zwischen Variablen**
* Visuelle Kommunikation mit minimalem Code
