<img src="./resources/HTLstp-RGB150.png" alt="HTL" width=200>
<ul style="list-style-type:circle;">
  <li>REFR - Prof. Franz Reichel</li>
  <li>DSAI - Data Science and Artificial Intelligence - 4XHIF</li>
</ul>

---

# NumPy

NumPy ist die Grundlage für alles Rechnen in Python. Pandas, scikit-learn und TensorFlow bauen darauf auf — egal ob die Daten aus einer Tabelle oder einem Bild kommen, beim Modell landen sie als NumPy-Array.

Diese Seite ist zum Nachschlagen: Befehl, Beispiel, Ausgabe. Alle Ausgaben sind echt und nicht abgetippt.

---

## Warum nicht einfach eine Liste?

Eine Python-Liste kann alles enthalten — Zahlen, Text, weitere Listen. Deshalb muss Python bei jeder Rechnung für jedes Element neu nachsehen, womit es gerade zu tun hat. Ein NumPy-Array enthält dagegen nur einen einzigen Datentyp und liegt am Stück im Speicher. Damit kann die Rechnung an compilierten C-Code weitergereicht werden, statt sie Element für Element in Python abzuarbeiten.

Der zweite Unterschied ist die Schreibweise. Eine Liste braucht eine Schleife, das Array nicht:

```python
[x * 2 for x in zahlen_liste]    # Liste: für jedes Element einzeln
zahlen_array * 2                 # Array: die ganze Sache auf einmal
```

Wie groß der Unterschied in der Praxis ist, findest du selbst heraus.

### Aufgabe: Miss den Unterschied

Erzeuge **eine Python-Liste und ein NumPy-Array mit je einer Million Zahlen**, verdopple jeden Wert und miss, wie lange beides dauert.

```python
import numpy as np
import time

zahlen_liste = list(range(1_000_000))
zahlen_array = np.arange(1_000_000)
```

Zum Messen brauchst du eine Uhr vor und nach der Rechnung:

```python
start = time.perf_counter()

# hier die Rechnung einsetzen

dauer = time.perf_counter() - start
print(f"Dauer: {dauer * 1000:.2f} ms")
```

Beantworte damit:

1. Wie lange dauert die Verdopplung als **Liste**?
2. Wie lange dauert sie als **Array**?
3. Um welchen **Faktor** ist das Array schneller?
4. Wie viel Speicher belegt das Array? Der Befehl dafür ist `zahlen_array.nbytes`, das Ergebnis steht in Bytes.

Führ die Messung ein paarmal aus. Die Werte schwanken, je nachdem was dein Rechner sonst gerade tut — ein einzelner Messwert sagt wenig.

> **Kürzer messen im Notebook:** In einem Jupyter-Notebook geht es auch mit den Magic Commands aus Kapitel 02. `%timeit` misst eine Zeile, `%%timeit` die ganze Zelle, und beide wiederholen die Messung automatisch und mitteln:
>
> ```python
> %timeit zahlen_array * 2
> ```
>
> **Wichtig:** `%%timeit` muss die **allererste Zeile der Zelle** sein — kein Kommentar, keine Leerzeile davor, sonst kommt `Cell magic not found`. Und Magic Commands gibt es nur im Notebook: In einer `.py`-Datei oder in der Python-Konsole kennt Python sie nicht. Deshalb ist `time.perf_counter()` oben der Weg, der überall funktioniert.

---

## Import

```python
import numpy as np
```

Das `np` ist weltweit Konvention. Halte dich daran, jeder fremde Code macht es auch so.

---

## Arrays erzeugen

```python
np.array([1, 2, 3])
# array([1, 2, 3])

np.zeros((2, 3))
# array([[0., 0., 0.],
#        [0., 0., 0.]])

np.ones((2, 2))
# array([[1., 1.],
#        [1., 1.]])

np.eye(3)                       # Einheitsmatrix
# array([[1., 0., 0.],
#        [0., 1., 0.],
#        [0., 0., 1.]])

np.arange(0, 10, 2)             # wie range(), aber als Array
# array([0, 2, 4, 6, 8])

np.linspace(0, 1, 5)            # 5 Werte gleichmäßig von 0 bis 1
# array([0.  , 0.25, 0.5 , 0.75, 1.  ])
```

Der Unterschied zwischen den letzten beiden: Bei `arange` gibst du die **Schrittweite** an, bei `linspace` die **Anzahl** der Werte. Für Kurven in Diagrammen ist `linspace` fast immer das Richtige.

---

## Ein Array ansehen

```python
a = np.array([[1, 2, 3], [4, 5, 6]])

a.shape     # (2, 3)      Form: 2 Zeilen, 3 Spalten
a.ndim      # 2           Anzahl der Dimensionen
a.size      # 6           Anzahl der Elemente insgesamt
a.dtype     # dtype('int64')
```

`shape` ist der Wert, den du am häufigsten brauchst — die meisten Fehlermeldungen in scikit-learn und TensorFlow drehen sich darum.

Den Datentyp umwandeln:

```python
a.astype(float)
# array([[1., 2., 3.],
#        [4., 5., 6.]])
```

Das brauchst du zum Beispiel bei Bildern: Pillow liefert Ganzzahlen von 0 bis 255, Modelle wollen meistens Kommazahlen zwischen 0 und 1.

---

## Rechnen

Operationen wirken auf **jedes Element einzeln**, ohne dass du eine Schleife schreibst:

```python
a = np.array([1, 2, 3])
b = np.array([4, 5, 6])

a + b       # array([5, 7, 9])
a * b       # array([ 4, 10, 18])   elementweise, keine Matrixmultiplikation
a * 2       # array([2, 4, 6])
a ** 2      # array([1, 4, 9])
```

Für das Skalarprodukt beziehungsweise die Matrixmultiplikation gibt es das `@`:

```python
a @ b           # 32
np.dot(a, b)    # 32   dasselbe, ältere Schreibweise
```

### Broadcasting

Das ist die wichtigste Idee in NumPy. Wenn zwei Arrays verschiedene Formen haben, streckt NumPy das kleinere automatisch passend — ohne es tatsächlich zu kopieren.

```python
a = np.array([[1, 2, 3],
              [4, 5, 6]])

a + 10
# array([[11, 12, 13],
#        [14, 15, 16]])          die 10 wird auf alle sechs Felder angewandt

a + np.array([10, 20, 30])
# array([[11, 22, 33],
#        [14, 25, 36]])          die Zeile wird auf beide Zeilen angewandt
```

Das ist der Grund, warum `a * 2` überhaupt funktioniert. Und es ist auch der Grund für eine der häufigsten Fehlermeldungen:

```
ValueError: operands could not be broadcast together with shapes (2,3) (2,)
```

Die heißt: Die Formen passen nicht zusammen. Mit `a.shape` nachsehen, was tatsächlich drinsteht.

---

## Mathematische Funktionen

Alle arbeiten elementweise auf dem ganzen Array:

```python
np.sin([0, np.pi/2, np.pi])     # array([0., 1., 0.])
np.cos(x)  np.tan(x)

np.exp([0, 1, 2])               # array([1.   , 2.718, 7.389])
np.log([1, np.e])               # array([0., 1.])      natürlicher Logarithmus
np.log10(x)  np.log2(x)

np.sqrt([1, 4, 9])              # array([1., 2., 3.])
np.abs([-3, 3])                 # array([3, 3])
np.round([1.234, 5.678], 2)     # array([1.23, 5.68])

np.pi                           # 3.141592653589793
np.e                            # 2.718281828459045
```

`np.maximum` vergleicht elementweise gegen einen Wert — damit ist die ReLU-Funktion aus Kapitel 11 eine einzige Zeile:

```python
np.maximum([-2, 0, 3], 0)       # array([0, 0, 3])
```

---

## Auswählen

### Index und Slicing

```python
arr = np.array([10, 20, 30, 40, 50])

arr[0]      # 10
arr[-1]     # 50            das letzte Element
arr[1:4]    # array([20, 30, 40])
arr[:3]     # array([10, 20, 30])
arr[::2]    # array([10, 30, 50])     jedes zweite

matrix = np.array([[1, 2, 3], [4, 5, 6]])
matrix[1, 2]    # 6         Zeile 1, Spalte 2
matrix[0]       # array([1, 2, 3])    die ganze erste Zeile
matrix[:, 1]    # array([2, 5])       die ganze zweite Spalte
```

Die Schreibweise `matrix[:, 1]` liest sich als „alle Zeilen, Spalte 1".

### Boolesche Maske

Die Form, die du am häufigsten brauchst. Ein Vergleich liefert ein Array aus Wahrheitswerten, und mit dem kann man auswählen:

```python
arr = np.array([10, 20, 30, 40, 50])

arr > 25            # array([False, False,  True,  True,  True])
arr[arr > 25]       # array([30, 40, 50])
```

Mehrere Bedingungen verbindet man mit `&` und `|` — **nicht** mit `and` und `or` — und jede Bedingung braucht Klammern:

```python
arr[(arr > 15) & (arr < 45)]    # array([20, 30, 40])
```

### np.where

Mit einem Argument liefert es die **Positionen**:

```python
np.where(arr > 25)      # (array([2, 3, 4]),)
```

Mit drei Argumenten wird es zu einem Wenn-Dann für ganze Arrays:

```python
np.where(arr > 25, "gross", "klein")
# array(['klein', 'klein', 'gross', 'gross', 'gross'], dtype='<U5')
```

### Vorsicht: Slice ist keine Kopie

Ein Ausschnitt zeigt auf **dieselben Daten**. Wer hineinschreibt, ändert das Original:

```python
v = np.array([1, 2, 3, 4, 5])
teil = v[1:4]
teil[0] = 99

v       # array([ 1, 99,  3,  4,  5])     ← v hat sich mitverändert
```

Wenn du das nicht willst, ausdrücklich kopieren:

```python
teil = v[1:4].copy()
```

Bei Python-Listen ist das anders — dort erzeugt ein Slice immer eine Kopie. Dieser Unterschied kostet regelmäßig eine halbe Stunde Fehlersuche.

---

## Umformen und zusammensetzen

```python
a = np.array([[1, 2, 3], [4, 5, 6]])

a.reshape(3, 2)
# array([[1, 2],
#        [3, 4],
#        [5, 6]])

a.T                             # transponieren, Zeilen und Spalten tauschen
# array([[1, 4],
#        [2, 5],
#        [3, 6]])

a.flatten()                     # alles in eine Zeile
# array([1, 2, 3, 4, 5, 6])
```

Bei `reshape` darf eine Angabe `-1` sein, dann rechnet NumPy sie selbst aus:

```python
a.reshape(-1, 2)        # „zwei Spalten, Zeilen egal"
```

Zwei Arrays zusammensetzen:

```python
b = np.array([1, 2, 3])
c = np.array([4, 5, 6])

np.vstack([b, c])       # übereinander (vertical)
# array([[1, 2, 3],
#        [4, 5, 6]])

np.hstack([b, c])       # hintereinander (horizontal)
# array([1, 2, 3, 4, 5, 6])

np.c_[b, c]             # als Spalten nebeneinander
# array([[1, 4],
#        [2, 5],
#        [3, 6]])
```

`np.c_` begegnet dir in den Machine-Learning-Notebooks, wenn aus einzelnen Merkmalen eine Merkmalsmatrix gebaut wird.

---

## Zeilen- oder spaltenweise rechnen

Bei zweidimensionalen Daten musst du sagen, in welche Richtung gerechnet werden soll. Das macht der `axis`-Parameter — und dort rutscht jeder einmal aus.

```python
a = np.array([[1, 2, 3],
              [4, 5, 6]])

a.mean()            # 3.5                 über alles
a.mean(axis=0)      # array([2.5, 3.5, 4.5])    spaltenweise, nach unten
a.mean(axis=1)      # array([2., 5.])           zeilenweise, nach rechts
```

**Merkhilfe:** `axis=0` ist die Achse der Zeilen — sie wird zusammengefasst, übrig bleiben die Spalten. `axis=1` umgekehrt. Wenn du unsicher bist: `a.shape` ist `(2, 3)`, und `axis=0` fasst die 2 zusammen, `axis=1` die 3.

Das funktioniert mit `sum`, `min`, `max`, `std` und den meisten anderen genauso.

---

## Statistische Funktionen

```python
data = np.array([1, 2, 3, 4, 5])

np.mean(data)       # 3.0
np.median(data)     # 3.0
np.min(data)        # 1
np.max(data)        # 5
np.sum(data)        # 15
np.var(data)        # 2.0
np.std(data)        # 1.4142135623730951
```

Die Begriffe dazu stehen in `03_Statistic`.

> **Achtung bei Varianz und Standardabweichung:** NumPy teilt standardmäßig durch $n$. Willst du durch $n-1$ teilen, also die Stichprobenvariante, brauchst du `ddof=1`:
>
> ```python
> np.var(data)            # 2.0    geteilt durch n
> np.var(data, ddof=1)    # 2.5    geteilt durch n − 1
> ```
>
> pandas macht es genau andersherum und teilt standardmäßig durch $n-1$. Wenn zwei Werkzeuge verschiedene Zahlen liefern, ist meistens das der Grund.

---

## Zufallszahlen

Die aktuelle Schreibweise geht über einen Generator. Die Zahl in `default_rng()` ist der Startwert — mit demselben Startwert kommen immer dieselben Zufallszahlen heraus, und genau das braucht man, damit ein Versuch wiederholbar ist:

```python
rng = np.random.default_rng(42)

rng.random(3)               # 3 Werte zwischen 0 und 1
rng.normal(0, 1, 3)         # array([ 0.305, -1.04 ,  0.75 ])   normalverteilt
rng.integers(0, 10, (2, 3))
# array([[0, 7, 6],
#        [4, 4, 8]])
```

Bei `normal` sind die drei Angaben Mittelwert, Standardabweichung und Anzahl beziehungsweise Form.

> Die ältere Schreibweise `np.random.seed(42)` mit `np.random.rand()`, `np.random.randn()` und `np.random.randint()` steht in fast jedem Tutorial und funktioniert weiterhin. Für neuen Code ist der Generator die empfohlene Variante.

---

## Nützliche Hilfen

```python
arr = np.array([1, 2, 2, 3, 4, 4, 4])

np.unique(arr)      # array([1, 2, 3, 4])      jeder Wert nur einmal
np.sort(arr)        # sortiert die Werte
np.argsort(arr)     # die Indizes in sortierter Reihenfolge

np.any(arr > 3)     # True     ist irgendeiner größer als 3?
np.all(arr > 0)     # True     sind alle größer als 0?

np.isnan(np.array([1, np.nan, 3]))
# array([False,  True, False])      fehlende Werte finden

np.clip([-5, 0, 8, 15], 0, 10)
# array([ 0,  0,  8, 10])           alles unter 0 wird 0, alles über 10 wird 10
```

`np.clip` ist praktisch, um Ausreißer zu kappen oder Werte in einen gültigen Bereich zu zwingen — etwa Pixelwerte zwischen 0 und 255.
