<img src="./resources/HTLstp-RGB150.png" alt="HTL" width=200>
<ul style="list-style-type:circle;">
  <li>REFR - Prof. Franz Reichel</li>
  <li>DSAI - Data Science and Artificial Intelligence - 4XHIF</li>
</ul>

---

# Klassifikationsmodelle in sklearn

## Kurzfassung

> **Klassifikation** bedeutet: ein Modell lernt aus Beispielen,  
> um neue Datenpunkte einer **Kategorie** zuzuordnen.  
> Beispiele: Spam oder kein Spam, krank oder gesund, Hund oder Katze.

---

## 1. Was ist ein Klassifikationsmodell?

Ein Klassifikationsmodell beantwortet die Frage:

> *„Zu welcher Klasse gehört dieser Datenpunkt?"*

### Eingabe und Ausgabe

| | Beschreibung | Beispiel |
|---|---|---|
| Eingabe (Features) | messbare Merkmale | Alter, Einkommen, Wörter |
| Ausgabe (Label) | vorhergesagte Klasse | Spam / Kein Spam |

📌 sklearn verwendet bei allen Modellen dieselbe Schnittstelle:  
`model.fit(X_train, y_train)` → `model.predict(X_test)`

---

## 2. Logistic Regression

**Logistic Regression** berechnet die **Wahrscheinlichkeit**,  
dass ein Datenpunkt zu einer bestimmten Klasse gehört.

> *„Wie wahrscheinlich ist es, dass diese E-Mail Spam ist?"*

### Eigenschaften
- gibt Wahrscheinlichkeiten aus (via `predict_proba`)
- funktioniert gut bei **linear trennbaren** Daten
- einfach, schnell, gut erklärbar

### Code
```python
from sklearn.linear_model import LogisticRegression

model = LogisticRegression(max_iter=1000)
model.fit(X_train, y_train)

model.predict(X_test)          # Klasse: 0 oder 1
model.predict_proba(X_test)    # Wahrscheinlichkeit: z. B. [0.12, 0.88]
```

📌 Trotz des Namens ist Logistic Regression ein **Klassifikationsmodell**, kein Regressionsmodell.

---

## 3. Decision Tree (Entscheidungsbaum)

Ein **Decision Tree** trifft Entscheidungen durch eine Reihe von  
Ja/Nein-Fragen — wie ein Flussdiagramm.

> *„Enthält die E-Mail das Wort 'gratis'? → Ja → Spam"*

### Eigenschaften
- sehr gut **visualisierbar**
- leicht zu erklären und nachzuvollziehen
- neigt zu **Overfitting** bei großer Tiefe

### Code
```python
from sklearn.tree import DecisionTreeClassifier

model = DecisionTreeClassifier(max_depth=3)
model.fit(X_train, y_train)
```

📌 `max_depth` kontrolliert die Komplexität — kleiner Wert = Underfitting, kein Limit = Overfitting.

---

## 4. Random Forest

Ein **Random Forest** besteht aus **vielen Decision Trees**,  
die unabhängig voneinander trainiert werden.  
Die finale Vorhersage entsteht durch **Mehrheitsentscheid**.

> *„100 Bäume stimmen ab — die Mehrheit gewinnt."*

### Eigenschaften
- deutlich robuster als ein einzelner Baum
- reduziert Overfitting automatisch
- zeigt welche Features **am wichtigsten** sind

### Code
```python
from sklearn.ensemble import RandomForestClassifier

model = RandomForestClassifier(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

print(model.feature_importances_)  # Wichtigkeit jedes Features
```

📌 `n_estimators` = Anzahl der Bäume. Mehr Bäume → stabiler, aber langsamer.

---

## 5. K-Nearest Neighbors (KNN)

**KNN** schaut sich die **k nächsten Nachbarn** eines neuen Datenpunkts an  
und entscheidet nach der Mehrheit.

> *„Die 5 ähnlichsten E-Mails sind alle Spam → also auch Spam."*

### Eigenschaften
- sehr intuitive Idee
- kein eigentliches „Training" — Entscheidung erst bei Vorhersage
- langsam bei großen Datensätzen

### Code
```python
from sklearn.neighbors import KNeighborsClassifier

model = KNeighborsClassifier(n_neighbors=5)
model.fit(X_train, y_train)
```

📌 `n_neighbors` (k) kontrolliert die Komplexität — kleines k = Overfitting, großes k = Underfitting.

---

## 6. Support Vector Machine (SVM)

Eine **SVM** sucht die **optimale Trennlinie** (Hyperebene)  
zwischen zwei Klassen mit maximalem Abstand.

> *„Ziehe die Linie so, dass beide Klassen möglichst weit entfernt sind."*

### Eigenschaften
- sehr effektiv bei hochdimensionalen Daten (z. B. Text)
- funktioniert auch bei **nicht-linearen** Daten (via Kernel)
- steckt in vielen echten Systemen

### Code
```python
from sklearn.svm import SVC

model = SVC(kernel='linear', probability=True)
model.fit(X_train, y_train)
```

📌 `kernel='rbf'` ermöglicht nicht-lineare Trennflächen.

---

## 7. Naive Bayes

**Naive Bayes** berechnet auf Basis der **Wahrscheinlichkeitstheorie**,  
welche Klasse am wahrscheinlichsten ist.

> *„Das Wort 'gratis' kommt in 90% aller Spam-Mails vor → wahrscheinlich Spam."*

### Eigenschaften
- sehr schnell, auch bei vielen Features
- klassisch für **Textklassifikation** (Spam-Filter)
- „naiv" weil es Features als unabhängig annimmt

### Code
```python
from sklearn.naive_bayes import MultinomialNB

model = MultinomialNB()
model.fit(X_train, y_train)
```

---

## 8. Gradient Boosting

**Gradient Boosting** baut viele schwache Modelle **nacheinander** auf —  
jedes neue Modell verbessert die Fehler des vorherigen.

> *„Modell 1 macht Fehler → Modell 2 lernt aus diesen Fehlern → usw."*

### Eigenschaften
- sehr hohe Genauigkeit
- langsamer als Random Forest (sequenziell statt parallel)
- bekannte Varianten: `XGBoost`, `LightGBM`

### Code
```python
from sklearn.ensemble import GradientBoostingClassifier

model = GradientBoostingClassifier(n_estimators=100)
model.fit(X_train, y_train)
```

---

## 9. Vergleich aller Modelle

| Modell | Erklärbarkeit | Geschwindigkeit | Overfitting-Risiko | Typischer Einsatz |
|---|---|---|---|---|
| Logistic Regression | ★★★★★ | ★★★★★ | gering | Wahrscheinlichkeiten |
| Decision Tree | ★★★★★ | ★★★★★ | hoch | Visualisierung, Lehre |
| Random Forest | ★★★☆☆ | ★★★☆☆ | gering | allgemein, robust |
| KNN | ★★★★☆ | ★★☆☆☆ | mittel | kleine Datensätze |
| SVM | ★★☆☆☆ | ★★★☆☆ | gering | Text, hohe Dimensionen |
| Naive Bayes | ★★★★☆ | ★★★★★ | gering | Spam-Filter, Text |
| Gradient Boosting | ★★☆☆☆ | ★★☆☆☆ | mittel | höchste Genauigkeit |

---

## 10. sklearn — gemeinsame Schnittstelle

Alle Modelle funktionieren in sklearn **gleich**:

```python
# 1. Modell wählen
from sklearn.ensemble import RandomForestClassifier
model = RandomForestClassifier()

# 2. Trainieren
model.fit(X_train, y_train)

# 3. Vorhersagen
y_pred = model.predict(X_test)

# 4. Auswerten
from sklearn.metrics import accuracy_score
print(accuracy_score(y_test, y_pred))
```

📌 Nur die erste Zeile ändert sich — der Rest bleibt immer gleich.

---

## 11. Unterschied zu neuronalen Netzen

### Klassisches Machine Learning (sklearn)

- verwendet **feste mathematische Formeln**
- Features müssen **manuell ausgewählt** werden
- funktioniert gut mit **wenig Daten** (100 – 10.000)
- schnell trainiert, gut erklärbar
- alle Modelle oben gehören dazu

### Neuronale Netze (Deep Learning)

- bestehen aus **Schichten von Neuronen**
- lernen **selbst**, welche Features wichtig sind
- brauchen **viel mehr Daten** (10.000 – Millionen)
- langsamer, schwerer erklärbar („Black Box")
- andere Libraries: `TensorFlow`, `PyTorch`, `Keras`

### Vergleichstabelle

| | Klassisches ML | Neuronale Netze |
|---|---|---|
| Libraries | sklearn | TensorFlow, PyTorch |
| Datenmenge | wenig bis mittel | viel |
| Feature-Auswahl | manuell | automatisch |
| Erklärbarkeit | hoch | gering |
| Trainingszeit | kurz | lang |
| Typischer Einsatz | Tabellen, Text | Bilder, Sprache, Video |

### Stufenplan

```
sklearn (klassisch)  →  MLPClassifier  →  TensorFlow / PyTorch
  Grundlagen             Brücke             Deep Learning
```

### MLP — die Ausnahme in sklearn

Der `MLPClassifier` ist technisch ein **neuronales Netz**,  
aber so simpel gehalten, dass er in sklearn enthalten ist.

```python
from sklearn.neural_network import MLPClassifier

model = MLPClassifier(hidden_layer_sizes=(10, 5), max_iter=1000)
#                      ↑ 2 Schichten: 10 Neuronen, dann 5 Neuronen
model.fit(X_train, y_train)
```

📌 Gut als **Brücke** zwischen klassischem ML und Deep Learning.

---

## 12. Analogie: Werkzeugkasten

> Kein Modell ist das Beste für alle Aufgaben.  
> sklearn ist wie ein Werkzeugkasten —  
> man wählt das **richtige Werkzeug** für die jeweilige Aufgabe.

| Aufgabe | Empfohlenes Modell |
|---|---|
| Ergebnis erklären müssen | Decision Tree, Logistic Regression |
| Höchste Genauigkeit | Random Forest, Gradient Boosting |
| Textklassifikation (Spam) | Naive Bayes, SVM |
| Wenig Daten, einfaches Problem | KNN, Logistic Regression |
| Brücke zu neuronalen Netzen | MLPClassifier |
