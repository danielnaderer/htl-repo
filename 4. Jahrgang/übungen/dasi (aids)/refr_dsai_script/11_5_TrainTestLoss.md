<img src="./resources/HTLstp-RGB150.png" alt="HTL" width=200>
<ul style="list-style-type:circle;">
  <li>REFR - Prof. Franz Reichel</li>
  <li>DSAI - Data Science and Artificial Intelligence - 4XHIF</li>
</ul>

---

# Train Loss vs. Test Loss  

## Kurzfassung

> **Train Loss** zeigt, wie gut ein neuronales Netz die **Trainingsdaten** trifft.  
> **Test Loss** zeigt, wie gut das Netz auf **neue, unbekannte Daten** reagiert.

---

## 1. Was ist der Train Loss?

Der **Train Loss** wird auf den Daten berechnet,  
mit denen das neuronale Netz **trainiert** wurde.

Er beantwortet die Frage:

> *„Wie gut passt das Modell zu den Beispielen, die es bereits gesehen hat?“*

### Eigenschaften
- sinkt meist während des Trainings
- zeigt, ob das Netz **lernen kann**
- misst **Anpassung an bekannte Daten**

📌 Ein niedriger Train Loss allein ist **kein Garant** für ein gutes Modell.

---

## 2. Was ist der Test Loss?

Der **Test Loss** wird auf Daten berechnet,
die das Modell **während des Trainings nicht gesehen hat**.

Er beantwortet die Frage:

> *„Wie gut kann das Modell sein Wissen auf neue Daten übertragen?“*

### Eigenschaften
- misst **Generalisierungsfähigkeit**
- ist entscheidend für den Praxiseinsatz
- sollte möglichst niedrig sein

---

## 3. Warum braucht man beide?

Train Loss und Test Loss messen **unterschiedliche Dinge**.

| Loss | Bedeutung |
|----|----------|
| Train Loss | Wie gut merkt sich das Modell die Trainingsdaten? |
| Test Loss | Wie gut versteht das Modell das zugrunde liegende Muster? |

📌 Nur wenn **beide** niedrig sind, ist das Modell gut.

---

## 4. Analogie: Lernen in der Schule

| Schule | Neuronales Netz |
|------|----------------|
| Übungsaufgaben | Trainingsdaten |
| Klassenarbeit | Testdaten |
| gute Übung | niedriger Train Loss |
| gute Klassenarbeit | niedriger Test Loss |

> Ein Schüler, der nur auswendig lernt,  
> ist bei neuen Aufgaben oft schlechter.

---

## 5. Overfitting (Überanpassung)

**Overfitting** bedeutet:

> Das Modell passt sich zu stark an die Trainingsdaten an  
> und verliert die Fähigkeit, neue Daten richtig zu beurteilen.

Typisches Verhalten:
- Train Loss sinkt weiter
- Test Loss erreicht ein Minimum
- Test Loss steigt danach wieder

📌 Das Modell **lernt auswendig**, statt zu verstehen.

---

## 6. Wie erkennt man Overfitting?

In der Fehlerkurve:

- **Train Loss ↓**  
- **Test Loss ↑**

➡️ Warnsignal für Überanpassung.

---

## 7. Underfitting (Unteranpassung)

**Underfitting** bedeutet:

> Das Modell ist zu einfach, um die Struktur der Daten zu erkennen.  
> Es lernt weder die Trainingsdaten noch neue Daten richtig.

Typisches Verhalten:
- Train Loss bleibt hoch
- Test Loss bleibt hoch
- kaum Unterschied zwischen beiden

📌 Das Modell **lernt zu wenig**, statt zu viel.

### Wie erkennt man Underfitting?

- **Train Loss ↑** (hoch, sinkt kaum)
- **Test Loss ↑** (hoch, ähnlich wie Train Loss)

➡️ Warnsignal für ein zu simples Modell.

### Ursachen
- Modell zu simpel (z. B. Decision Tree mit Tiefe 1)
- zu wenige Trainingsepochen
- zu wenige Features / Eingabedaten

### Analogie: Lernen in der Schule

> Ein Schüler, der gar nicht lernt,  
> scheitert sowohl bei den Übungsaufgaben als auch in der Klassenarbeit.

---

## 8. Overfitting vs. Underfitting — Vergleich

| | Underfitting | Gut | Overfitting |
|---|---|---|---|
| Train Loss | hoch | niedrig | niedrig |
| Test Loss | hoch | niedrig | **hoch** |
| Problem | zu simpel | ✓ | zu komplex |
| Lösung | Modell komplexer machen | — | Modell vereinfachen |

📌 Das Ziel ist immer: **beide Losses niedrig und ähnlich**.

---

## 9. Cross-Validation (Kreuzvalidierung)

**Cross-Validation** ist eine Methode, um Overfitting zuverlässig zu erkennen  
und die Modellqualität besser einzuschätzen als mit einem einzelnen Test-Split.

### Idee

Statt die Daten einmal in Training und Test aufzuteilen,  
wird die Aufteilung **mehrfach wiederholt** — jedes Mal anders.

### k-Fold Cross-Validation (häufigste Variante)

1. Daten werden in **k gleich große Teile** (Folds) aufgeteilt
2. Das Modell wird **k-mal** trainiert
3. Jedes Mal ist ein anderer Fold der Testdatensatz
4. Am Ende wird der **Durchschnitt** aller k Ergebnisse berechnet

Beispiel mit k = 5:

```
Fold 1: [TEST] [TRAIN] [TRAIN] [TRAIN] [TRAIN]
Fold 2: [TRAIN] [TEST] [TRAIN] [TRAIN] [TRAIN]
Fold 3: [TRAIN] [TRAIN] [TEST] [TRAIN] [TRAIN]
Fold 4: [TRAIN] [TRAIN] [TRAIN] [TEST] [TRAIN]
Fold 5: [TRAIN] [TRAIN] [TRAIN] [TRAIN] [TEST]
```

### Vorteile gegenüber einfachem Train/Test-Split

| | Train/Test-Split | Cross-Validation |
|---|---|---|
| Aufteilung | einmal, zufällig | k-mal, systematisch |
| Ergebnis | ein einzelner Wert | Durchschnitt + Streuung |
| Zuverlässigkeit | abhängig vom Zufall | stabiler, belastbarer |
| Aufwand | gering | höher (k-faches Training) |

### Code-Beispiel (sklearn)

```python
from sklearn.model_selection import cross_val_score
from sklearn.linear_model import LogisticRegression

model = LogisticRegression(max_iter=1000)
scores = cross_val_score(model, X, y, cv=5)

print(scores)          # Accuracy pro Fold
print(scores.mean())   # Durchschnitt
print(scores.std())    # Streuung → wie stabil ist das Modell?
```

📌 Eine **hohe Streuung** der Fold-Scores ist ein Hinweis auf Overfitting.

### Analogie: Lernen in der Schule

> Statt nur eine Klassenarbeit zu schreiben,  
> werden **fünf verschiedene Schularbeiten** aus unterschiedlichem Stoff geprüft.  
> Das Ergebnis ist fairer und aussagekräftiger.

---

## 10. Mathematischer Hintergrund (kurz)

Beide Loss-Werte werden mit derselben Loss-Funktion berechnet, z. B.:

$
L = -\big(y \log(y_{\text{pred}}) + (1-y)\log(1-y_{\text{pred}})\big)
$

Der Unterschied liegt **nicht in der Formel**,  sondern **in den verwendeten Daten**.
