<img src="./resources/HTLstp-RGB150.png" alt="HTL" width=200>
<ul style="list-style-type:circle;">
  <li>REFR - Prof. Franz Reichel</li>
  <li>DSAI - Data Science and Artificial Intelligence - 4XHIF</li>
</ul>

---

# Projektthemen — sklearn Klassifikation

## Übersicht: 20 Themen

Wähle ein Thema aus der Liste. Erstelle ein Python-Skript oder Jupyter Notebook, das:
1. Trainingsdaten erstellt oder lädt
2. Das Modell trainiert (`fit`)
3. Vorhersagen macht (`predict`)
4. Die Genauigkeit ausgibt (`accuracy_score`)

---

## 🟢 Einfach (Themen 1–6)

| Nr. | Thema                | Aufgabe | Features | Empfohlenes Modell |
|-----|----------------------|---------|----------|--------------------|
| 1 | **Titanic**          | Überleben vorhersagen | Alter, Geschlecht, Klasse | Logistic Regression |
| 2 | **Pilze**            | Giftig oder essbar? | Farbe, Geruch, Form | Decision Tree |
| 3 | **Bäume**            | Wird es regnen? | Temperatur, Luftfeuchtigkeit, Bewölkung | Naive Bayes |
| 4 | **Tierart erkennen** | Hund oder Katze? | Gewicht, Größe, Lautstärke | KNN |
| 5 | **Früchte**          | Apfel oder Orange? | Gewicht, Farbe, Durchmesser | KNN |
| 6 | **Schüler bestehen** | Prüfung bestanden oder nicht? | Lernstunden, Schlaf, Vorleistung | Logistic Regression |

---

## 🟡 Mittel (Themen 7–14)

| Nr. | Thema | Aufgabe | Features | Empfohlenes Modell |
|-----|-------|---------|----------|--------------------|
| 7 | **Kreditwürdigkeit** | Kredit bewilligen oder nicht? | Einkommen, Alter, Schulden | Random Forest |
| 8 | **Diabetes** | Krank oder gesund? | BMI, Alter, Blutzucker | Logistic Regression |
| 9 | **Weinqualität** | Gut oder schlecht? | Säure, Alkohol, pH-Wert | Random Forest |
| 10 | **Herzerkrankung** | Risiko ja oder nein? | Blutdruck, Cholesterin, Alter | SVM |
| 11 | **Kundenabwanderung** | Kündigt ein Kunde oder bleibt er? | Nutzungsdauer, Beschwerden, Preis | Random Forest |
| 12 | **Unfallrisiko** | Unfall wahrscheinlich oder nicht? | Alter, Fahrerfahrung, Wetter | Decision Tree |
| 13 | **Planetenklassifikation** | Bewohnbar oder nicht? | Temperatur, Atmosphäre, Größe | KNN |
| 14 | **E-Mail Priorität** | Dringend oder nicht dringend? | Absender, Schlüsselwörter, Uhrzeit | Naive Bayes |

---

## 🔴 Anspruchsvoll (Themen 15–20)

| Nr. | Thema | Aufgabe | Features | Empfohlenes Modell |
|-----|-------|---------|----------|--------------------|
| 15 | **Hauspreise** | Teuer oder günstig? | Größe, Lage, Zimmer | Gradient Boosting |
| 16 | **Spam-Filter** | Spam oder kein Spam? | Wörter, Länge, Absender | Naive Bayes |
| 17 | **Sportleistung** | Gewinnt ein Team? | Statistiken, Siege, Gegentore | Random Forest |
| 18 | **Aktienmarkt** | Kurs steigt oder fällt? | Volumen, Vortag, Sentiment | Gradient Boosting |
| 19 | **Medikamentenwirkung** | Wirkt ein Medikament oder nicht? | Dosis, Alter, Vorerkrankungen | SVM |
| 20 | **Spracherkennung** | Welche Sprache ist das? | Wortlänge, Buchstabenhäufigkeit, Satzzeichen | Naive Bayes |

---

## Pflichtbestandteile jeder Abgabe

```python
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score, classification_report

# 1. Daten vorbereiten
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# 2. Modell trainieren
model.fit(X_train, y_train)

# 3. Vorhersagen
y_pred = model.predict(X_test)

# 4. Auswertung
print(accuracy_score(y_test, y_pred))
print(classification_report(y_test, y_pred))
```

---

## Bonus-Aufgaben (+)

| Aufgabe | Beschreibung |
|---------|-------------|
| Modellvergleich | Mindestens 2 Modelle vergleichen |
| Overfitting zeigen | Train vs. Test Accuracy gegenüberstellen |
| Cross-Validation | `cross_val_score` mit cv=5 |
| Visualisierung | Konfusionsmatrix oder Entscheidungsgrenze plotten |
| `predict_proba` | Wahrscheinlichkeiten statt nur Ja/Nein ausgeben |

---

## Modelle — Kurzreferenz

```python
from sklearn.linear_model    import LogisticRegression
from sklearn.tree            import DecisionTreeClassifier
from sklearn.ensemble        import RandomForestClassifier, GradientBoostingClassifier
from sklearn.neighbors       import KNeighborsClassifier
from sklearn.svm             import SVC
from sklearn.naive_bayes     import MultinomialNB, GaussianNB
```

📌 Alle Modelle verwenden dieselbe Schnittstelle: `fit` → `predict` → `accuracy_score`
