<img src="./resources/HTLstp-RGB150.png" alt="HTL" width=200>
<ul style="list-style-type:circle;">
  <li>REFR - Prof. Franz Reichel</li>
  <li>DSAI - Data Science and Artificial Intelligence - 4XHIF</li>
</ul>

---
# Klassifikationsmetriken: Precision, Recall, F1-Score & Support

Diese vier Begriffe werden in jedem `classification_report` von scikit-learn ausgegeben.  
Sie beschreiben, wie gut ein Klassifikationsmodell für jede Klasse funktioniert.

---

## 1. Precision (Genauigkeit der Positiven)

**Frage:**  
*Wie viele der als positiv vorhergesagten Fälle sind wirklich positiv?*

**Formel:**

$[
\text{Precision} = \frac{TP}{TP + FP}
$]

- **TP (True Positives):** richtig erkannte positive Beispiele  
- **FP (False Positives):** fälschlicherweise positiv klassifiziert  

**Beispiel:**  
Modell sagt 20-mal „Klasse 3“, aber nur 15 davon sind wirklich 3 →  
Precision = 15 / 20 = **0.75**

**Wann wichtig?**  
Wenn falsche Alarme vermieden werden sollen (Spamfilter).

---

## 2. Recall (Trefferquote / Sensitivität)

**Frage:**  
*Wie viele der tatsächlich positiven Fälle hat das Modell gefunden?*

**Formel:**

$[
\text{Recall} = \frac{TP}{TP + FN}
$]

- **FN (False Negatives):** positive Beispiele, die nicht erkannt wurden  

**Beispiel:**  
Es gibt 100 echte „3“ → Modell findet 80 →  
Recall = 80 / 100 = **0.80**

**Wann wichtig?**  
Wenn kein positiver Fall übersehen werden darf (medizinische Diagnose).

---

## 3. F1-Score (harmonisches Mittel aus Precision & Recall)

Der F1-Score kombiniert **Precision und Recall** zu einer einzigen Metrik.

**Formel:**

$[
F1 = 2 \cdot \frac{Precision \cdot Recall}{Precision + Recall}
$]

Eigenschaften:
- hoch nur, wenn **beides** hoch ist  
- sinnvoll bei **unausgeglichenen Klassen**  
- gute Gesamtmetrik zur Trade-off-Bewertung  

**Beispiel:**  
Precision = 0.75, Recall = 0.80 → F1 ≈ **0.77**

---

## 4. Support (Anzahl der echten Beispiele pro Klasse)

**Support** ist die Anzahl der tatsächlichen Beispiele einer Klasse im Testset.

Es ist **keine Qualitätsmetrik**, sondern beschreibt die Datenverteilung.

Beispiel (MNIST Testset):

| Klasse | Support |
|-------|---------|
| 0     | 980     |
| 1     | 1135    |
| 2     | 1032    |

Support hilft zu verstehen:
- ob die Klassen **balanciert** sind  
- wie aussagekräftig die Precision/Recall-Werte sind  

---

## Zusammenfassung der vier Begriffe

| Metrik | Bedeutung |
|--------|-----------|
| **Precision** | Wie zuverlässig sind Positiv-Vorhersagen? |
| **Recall** | Wie viele echte Positive wurden gefunden? |
| **F1-Score** | Harmonie aus Precision und Recall |
| **Support** | Anzahl der echten Beispiele pro Klasse |

---

## Beispiel eines `classification_report`
          precision    recall  f1-score   support
       0       0.98      0.96      0.97      980
       1       0.97      0.98      0.97     1135


**Interpretation für Klasse 0:**

- Precision = 0.98 → kaum Fehlalarme  
- Recall = 0.96 → fast alle 0er erkannt  
- F1 = 0.97 → sehr gute Gesamtleistung  
- Support = 980 → so viele 0er gibt es im Testset  

