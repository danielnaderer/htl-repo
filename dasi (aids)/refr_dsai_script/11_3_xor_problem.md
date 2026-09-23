<img src="./resources/HTLstp-RGB150.png" alt="HTL" width=200>
<ul style="list-style-type:circle;">
  <li>REFR - Prof. Franz Reichel</li>
  <li>DSAI - Data Science and Artificial Intelligence - 4XHIF</li>
</ul>

---
# ✖️ Das XOR-Problem beim Perzeptron

---

## Was ist XOR?

**XOR** (exklusives Oder) ist eine logische Funktion mit zwei Eingaben:

| $x_1$ | $x_2$ | $x_1$ ^ $x_2$ |
|--------|--------|---------------|
| 0 | 0 | 0             |
| 0 | 1 | 1             |
| 1 | 0 | 1             |
| 1 | 1 | 0             |

> Das Ergebnis ist **1**, wenn **genau eine** der beiden Eingaben 1 ist – aber nicht beide.

---

## Das Problem

Ein einzelnes Perzeptron kann XOR **nicht** lernen.

### Warum nicht?

Ein Perzeptron trifft seine Entscheidung durch eine **lineare Trennlinie** (Gerade) im Koordinatensystem.
Es kann nur Probleme lösen, bei denen sich die zwei Klassen durch eine einzige Gerade trennen lassen –
man nennt das **lineare Separierbarkeit**.

Trägt man die vier XOR-Punkte in ein Koordinatensystem ein:

```
x2
 1 |  O(0,1)    X(1,1)
   |
 0 |  X(0,0)    O(1,0)
   +-------------------> x1
      0          1
```

- **X** = Ausgabe 1 → $(0,1)$ und $(1,0)$
- **O** = Ausgabe 0 → $(0,0)$ und $(1,1)$

Die X-Punkte liegen **diagonal gegenüber**, die O-Punkte ebenfalls.
Es gibt **keine einzige Gerade**, die X von O trennt.

---

## Vergleich: AND ist lösbar, XOR nicht

**AND** – linear separierbar ✅

```
x2
 1 |  O(0,1)   \X(1,1)
   |            \
 0 |  O(0,0)    O(1,0)
   +-------------------> x1
```

Eine Gerade kann hier X von O trennen.

**XOR** – nicht linear separierbar ❌

```
x2
 1 |  X(0,1)    O(1,1)
   |       \   /
   |        \ /
   |        / \
   |       /   \
 0 |  O(0,0)    X(1,0)
   +-------------------> x1
```

Keine Gerade kann hier X von O trennen.

---

## Die Lösung: Mehrschichtige Netze

Um XOR zu lösen, braucht man ein **mehrschichtiges neuronales Netz** (Multi-Layer Perceptron, MLP)
mit mindestens einer **versteckten Schicht** (Hidden Layer).

```
Eingabe     Hidden Layer     Ausgabe
  x1  ──┐
        ├──► h1 ──┐
  x2  ──┤         ├──► ŷ
        ├──► h2 ──┘
      ──┘
```

Die Hidden Layer transformiert den Eingaberaum so, dass die Klassen
plötzlich **linear trennbar** werden – in einem höherdimensionalen Raum.

---

## Historische Bedeutung

> Das XOR-Problem wurde 1969 von **Minsky & Papert** im Buch *Perceptrons* formalisiert.
> Es zeigte die fundamentale Grenze des einfachen Perzeptrons und
> führte zum ersten **KI-Winter** – einer Phase, in der die Forschung an neuronalen Netzen
> fast vollständig zum Erliegen kam.

Erst mit der Entwicklung des **Backpropagation-Algorithmus** in den 1980er Jahren
und mehrschichtigen Netzen konnte XOR – und damit viele komplexere Probleme – gelöst werden.

---

## Zusammenfassung

| | Einfaches Perzeptron | MLP (mehrschichtig) |
|---|---|---|
| Trennlinie | eine Gerade | mehrere / gekrümmt |
| AND, OR | ✅ lösbar | ✅ lösbar |
| XOR | ❌ nicht lösbar | ✅ lösbar |
| Lernfähigkeit | begrenzt | universell* |

*\*Ein MLP mit genug Neuronen kann theoretisch jede Funktion annähern (Universal Approximation Theorem).*
