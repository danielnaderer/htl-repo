<img src="./resources/HTLstp-RGB150.png" alt="HTL" width=200>
<ul style="list-style-type:circle;">
  <li>REFR - Prof. Franz Reichel</li>
  <li>DSAI - Data Science and Artificial Intelligence - 4XHIF</li>
</ul>

---

# 🤖 scikit-learn Cheat Sheet – Klassisches Machine Learning

scikit-learn (**sklearn**) ist eine der wichtigsten Bibliotheken für klassisches Machine Learning.
Sie bietet Werkzeuge für Datenvorbereitung, Modelltraining, Evaluierung und vieles mehr.


## 🔹 Hauptbereiche
- **Datenaufbereitung**: `train_test_split`, `StandardScaler`, `OneHotEncoder`, `PCA`
- **Supervised Learning**: Klassifikation (`LogisticRegression`, `RandomForestClassifier`) und Regression (`LinearRegression`, `SVR`)
- **Unsupervised Learning**: Clustering (`KMeans`, `DBSCAN`), Dimensionsreduktion (`PCA`)
- **Evaluation**: `cross_val_score`, `accuracy_score`, `f1_score`, `mean_squared_error`


# scikit-learn (sklearn) – Kurzüberblick

**scikit-learn** ist eine Python-Bibliothek für klassisches Machine Learning mit strukturieren Daten.  
Sie bietet eine einheitliche API für Modelle, Datenvorverarbeitung und Evaluation.

---

## Grundprinzip

Typischer Workflow:

1. Daten laden
2. Vorverarbeitung
3. Modell trainieren (`fit`)
4. Vorhersagen (`predict`)
5. Bewertung (`score` oder Metrics)

---



## 🔹 Typischer Workflow
```python
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score

# Daten laden
iris = load_iris()
X, y = iris.data, iris.target

# Train/Test Split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Skalieren
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)

# Modell trainieren
model = LogisticRegression(max_iter=200)
model.fit(X_train_scaled, y_train)

# Bewertung
y_pred = model.predict(X_test_scaled)
print("Accuracy:", accuracy_score(y_test, y_pred))
```


---

## Wichtige Konzepte

### One-Hot Encoding
Technik zur Umwandlung kategorialer Variablen in numerische Features.  
Jede Kategorie wird zu einer eigenen binären Spalte.

Beispiel:

| Farbe | Rot | Blau | Grün |
|------|-----|------|------|
| Blau | 0 | 1 | 0 |

Warum nötig:
Viele ML-Algorithmen können nur Zahlen verarbeiten.

---

### Cross-Validation
Methode zur robusten Modellbewertung.

Statt nur einmal zu testen:
- Datensatz wird in mehrere Teilmengen aufgeteilt
- Modell wird mehrfach trainiert und getestet
- Durchschnittliche Leistung wird berechnet

Vorteil: stabilere Schätzung der Modellqualität.

---

## Wichtige Modellklassen

### Random Forest
Ensemble-Modell aus vielen Entscheidungsbäumen.

Eigenschaften:
- robust gegen Overfitting
- funktioniert gut ohne viel Tuning
- gut für strukturierte Daten

Prinzip:
Viele Bäume → Abstimmung → finale Entscheidung

---

### Gradient Boosting
Sequenzielles Ensembleverfahren.

Idee:
Jeder neue Baum korrigiert Fehler der vorherigen.

Stärken:
- sehr hohe Genauigkeit
- Standardlösung für Tabellendaten
- flexibel

---

## Clustering-Algorithmen

### KMeans
Partitioniert Daten in **k Gruppen**.

Funktionsweise:
- zufällige Zentren
- Datenpunkte werden nächstem Zentrum zugeordnet
- Zentren werden neu berechnet
- wiederholen bis stabil

Gut für:
- klar getrennte Cluster

---

### DBSCAN
Dichtebasierter Clustering-Algorithmus.

Eigenschaften:
- erkennt Cluster beliebiger Form
- findet Ausreißer automatisch
- braucht keine Clusterzahl

Gut für:
- Daten mit Rauschen
- unregelmäßige Clusterformen

---

## Kurzfazit

scikit-learn ist die Standardbibliothek für klassisches Machine Learning in Python, weil sie:

- konsistente API bietet
- viele Algorithmen enthält
- gut dokumentiert ist
- schnell und zuverlässig läuft


