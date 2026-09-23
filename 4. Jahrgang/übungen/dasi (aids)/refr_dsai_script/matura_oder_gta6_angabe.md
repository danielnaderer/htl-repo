# 🎮 Aufgabe: Lernen oder GTA 6 spielen?

---

## Szenario

Du hast morgen **Matura** und überlegst, ob du heute Abend noch lernst –
oder doch lieber **GTA 6** zockst. Ein Perzeptron soll diese Entscheidung modellieren.

> 📌 **Ausgabe-Definition:**  
> $\hat{y} = 1$ → **„Ich lerne heute Abend"**  
> $\hat{y} = 0$ → **„Ich spiele GTA 6"**

---

## Eingaben & Gewichte

| Variable | Bedeutung | Gewicht | Begründung |
|----------|-----------|---------|------------|
| $x_1$ | Hast du heute bereits gelernt? | $w_1 = 3{,}0$ | Wer schon gelernt hat, lernt eher weiter |
| $x_2$ | Ist GTA 6 gerade online / verfügbar? | $w_2 = -2{,}0$ | Verfügbares Spiel senkt Lernbereitschaft |
| $x_3$ | Haben deine Freunde dich zum Spielen eingeladen? | $w_3 = -1{,}5$ | Spieleinladung senkt Lernbereitschaft |

**Bias:** $w_0 = -1{,}0$

> 📌 **Negative Gewichte** bei $x_2$ und $x_3$:  
> Beide Faktoren verleiten zum Spielen – sie **senken** also die Aktivierung des „Ich lerne"-Neurons.

---

## Situation

- Du hast heute bereits gelernt: $x_1 = 1$
- GTA 6 ist online: $x_2 = 1$
- Deine Freunde haben dich **nicht** eingeladen: $x_3 = 0$

---

## ❓ Aufgaben

**1.** Berechne den Nettoinput $z$.

**2.** Wende die **Sigmoid-Funktion** an und interpretiere das Ergebnis als Wahrscheinlichkeit zu lernen.

**3.** Wende die **ReLU-Funktion** an und erkläre den Unterschied zur Sigmoid-Ausgabe.

**4.** Was ändert sich, wenn deine Freunde dich doch einladen ($x_3 = 1$)?  
Berechne $z$, Sigmoid und ReLU erneut und vergleiche. Lernst du noch?
