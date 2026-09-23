<img src="./resources/HTLstp-RGB150.png" alt="HTL" width=200>
<ul style="list-style-type:circle;">
  <li>REFR - Prof. Franz Reichel</li>
  <li>DSAI - Data Science and Artificial Intelligence - 4XHIF</li>
</ul>

---

## 🧘 3.1 Minimalismus in der Datenvisualisierung

Minimalismus bedeutet, **nur das zu zeigen, was wirklich nötig ist**, um die Aussage klar zu vermitteln.  
Ein minimalistischer Plot verzichtet auf überflüssige grafische Elemente, Farben und Beschriftungen, die vom Wesentlichen ablenken.

### 🎯 Ziele des Minimalismus
- **Fokus auf den Inhalt:** Die Daten stehen im Mittelpunkt, nicht das Design.  
- **Kognitive Entlastung:** Weniger visuelles Rauschen erleichtert das Verständnis.  
- **Ästhetische Klarheit:** Eine schlichte Darstellung wirkt professionell und elegant.  

---

### 📐 Die Data-Ink Ratio (Edward R. Tufte)

Tufte beschreibt Minimalismus in der Datenvisualisierung mit der **Data-Ink Ratio** – also dem Verhältnis zwischen der Tinte (oder Pixeln), die **Dateninformation** vermittelt, und der gesamten verwendeten Tinte im Diagramm.

**Formel:**
$[
\text{Data-Ink Ratio} = \frac{\text{Data Ink}}{\text{Total Ink Used to Print the Graphic}}
]$

Je **näher dieser Wert bei 1 liegt**, desto **effizienter** ist die Visualisierung – das heißt: kaum Platz oder Aufmerksamkeit wird auf unnötige grafische Elemente verschwendet.

### ✂️ Praktische Tipps zur Optimierung
- Entferne unnötige Gitterlinien, Rahmen und 3D-Effekte.  
- Verwende **neutrale Farben** für Hintergrund und Achsen.  
- Zeige **nur relevante Beschriftungen** (z. B. runde Zahlen, kurze Titel).  
- Halte die **Data-Ink Ratio** so hoch wie möglich.  
- Nutze **Weißraum bewusst**, um Struktur und Ruhe zu schaffen.  

> 💡 **Edward R. Tufte:**  
> *„Above all else, show the data.“*  
> (Vor allem: Zeige die Daten.)

---

### 🧩 Beispiel (Python)
```python
import matplotlib.pyplot as plt

plt.style.use('seaborn-v0_8-whitegrid')

daten = [10, 14, 18, 21, 25]
labels = ['Jan', 'Feb', 'Mär', 'Apr', 'Mai']

plt.plot(labels, daten, marker='o', color='black', linewidth=2)
plt.title("Minimalistischer Plot", fontsize=14)
plt.xlabel("Monat")
plt.ylabel("Wert")
plt.grid(False)  # Kein Gitter
plt.show()
