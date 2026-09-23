<img src="./resources/HTLstp-RGB150.png" alt="HTL" width=200>
<ul style="list-style-type:circle;">
  <li>REFR - Prof. Franz Reichel</li>
  <li>DSAI - Data Science and Artificial Intelligence - 4XHIF</li>
</ul>

---

# Jupyter Notebook

Ein Notebook ist eine einzelne Datei mit der Endung `.ipynb`, in der Code, seine Ausgaben, Diagramme und erklärender Text nebeneinander stehen. Man führt es nicht am Stück aus, sondern Zelle für Zelle – und kann dazwischen nachdenken, etwas ändern und noch einmal probieren.

Genau deshalb arbeiten wir im Kurs damit. Für ein Programm, das später jeden Tag laufen soll, nimmt man trotzdem eine normale `.py`-Datei.

---

# Teil A – Notebook öffnen und starten

Notebooks kannst du auf zwei Arten öffnen. Beide arbeiten mit derselben `.ipynb`-Datei und demselben Kernel – es ist nur die Oberfläche, die sich unterscheidet.

---

## Variante 1: In PyCharm

Der bequemere Weg, und der, den wir im Unterricht meistens gehen.

1. Projekt in PyCharm öffnen
2. Die `.ipynb`-Datei im Projektbaum doppelklicken
3. Oben rechts prüfen, ob als Kernel **Python (dsai)** eingestellt ist
4. Über jeder Zelle sitzt eine kleine Leiste mit Ausführen-Knöpfen

Kein Terminal, kein Server, kein Browser. Die Einrichtung steht in `00_InstallParty`, Schritt 6.

---

## Variante 2: Im Browser mit JupyterLab

Der klassische Weg. Hier startest du selbst einen kleinen Webserver auf deinem Rechner, und der Browser ist nur das Fenster dazu.

### Schritt 1: Terminal öffnen

**Windows** – „Miniforge Prompt" aus dem Startmenü.
**Linux** und **macOS** – das normale Terminal.

### Schritt 2: In den Projektordner wechseln

```powershell
cd C:\dev\dsai            # Windows
```

```bash
cd ~/dsai                  # Linux und macOS
```

Den Pfad musst du nicht abtippen: In PyCharm rechts auf den Projektordner klicken → *Copy Path/Reference…* → *Absolute Path*, dann im Terminal hinter `cd ` einfügen.

### Schritt 3: Environment aktivieren und Server starten

Ab hier ist es auf allen drei Systemen gleich:

```
conda activate dsai
jupyter lab
```

`jupyter` ist das Programm, `lab` sagt ihm, welche Oberfläche es starten soll – ähnlich wie bei `git commit`. Es ist also kein Dateiname und nichts, was du selbst benennst. Die Alternative wäre `jupyter notebook` für die ältere, schlichtere Oberfläche.

**Was du dahinter angeben kannst, ist ein Pfad.** Damit sparst du dir das `cd` aus Schritt 2:

```powershell
jupyter lab C:\dev\dsai                              # Windows: Ordner
```

```bash
jupyter lab ~/dsai                                    # Linux und macOS: Ordner
jupyter lab ~/dsai/notebooks/02_uebung_maier.ipynb    # oder gleich eine Datei
```

Gibst du einen Ordner an, startet JupyterLab mit diesem als Wurzel. Gibst du eine Datei an, wird sie zusätzlich gleich geöffnet.

Der Browser öffnet sich von selbst. Falls nicht, steht im Terminal eine Adresse, die du kopieren kannst:

```
    To access the server, open this file in a browser:
        ...
    Or copy and paste one of these URLs:
        http://localhost:8888/lab?token=a1b2c3d4e5...
```

Der `token` ist ein Zufallsschlüssel, damit nicht jeder im Netzwerk auf deinen Server zugreifen kann. Er ist bei jedem Start ein anderer.

Links siehst du den **Dateibrowser**, und zwar genau den Ordner, in dem du `jupyter lab` gestartet hast. Deshalb ist das `cd` vorher wichtig: Du kommst mit JupyterLab nicht nach oben aus diesem Ordner heraus.

### Schritt 4: Wieder beenden

Das Terminal muss die ganze Zeit offen bleiben – dort läuft der Server. Schließt du es, ist das Notebook weg.

Zum sauberen Beenden im Browser *File → Shut Down*, oder im Terminal `Strg + C` und die Rückfrage mit `y` bestätigen.

> Statt `jupyter lab` gibt es auch noch `jupyter notebook` – die ältere, schlichtere Oberfläche. Beide sind installiert, JupyterLab ist die aktuelle.

---

## Variante 3: Beides gleichzeitig

Häufige Frage: *Kann ich das Notebook, das ich in PyCharm offen habe, auch im Browser aufmachen?*

Dazu muss man wissen, dass hier immer **zwei Dinge** im Spiel sind:

- die **Datei** `.ipynb` – die liegt einfach auf deiner Festplatte
- der **Server** mit dem Kernel – der rechnet

Die Datei kannst du jederzeit in beiden öffnen, sie liegt ja nur im Ordner. Aber jedes Programm bringt dann seinen eigenen Server und damit seinen eigenen Kernel mit – zwei getrennte Speicher, zwei getrennte Variablensätze. Und wenn beide dieselbe Datei speichern, gewinnt der letzte und überschreibt den anderen.

**Richtig gemacht** startest du den Server selbst und hängst beide daran:

1. Im Terminal wie oben `jupyter lab` starten und die Adresse samt `token` kopieren
2. In PyCharm: *Settings → Languages & Frameworks → Jupyter → Jupyter Servers*
3. Von *Managed server* auf *Configured server* umstellen und die kopierte Adresse einfügen

Danach arbeiten PyCharm und Browser auf demselben Server. Führst du im Browser eine Zelle aus, kennt PyCharm die Variable ebenfalls – es ist derselbe Kernel.

> **Trotzdem gilt:** Lass dieselbe Datei nicht in beiden gleichzeitig offen und bearbeite sie nicht parallel. Der gemeinsame Server löst das Kernel-Problem, nicht das Speicher-Problem.

Umgekehrt geht es übrigens nicht: PyCharms eigener Server im Hintergrund ist nicht dafür gedacht, im Browser geöffnet zu werden.

---

# Teil B – Die Begriffe

## Zelle

Ein Notebook besteht aus Zellen. Es gibt zwei Sorten:

- **Code-Zelle** – enthält Python. `Shift + Enter` führt sie aus, das Ergebnis erscheint direkt darunter.
- **Markdown-Zelle** – enthält formatierten Text, Überschriften, Formeln, Bilder. `Shift + Enter` stellt sie dar.

Eine Zelle hat außerdem zwei Zustände: im **Editiermodus** tippst du in die Zelle hinein, im **Befehlsmodus** bearbeitest du die Zelle als Ganzes – einfügen, löschen, verschieben. `Enter` führt hinein, `Esc` wieder heraus. Das ist der Grund, warum es weiter unten zwei Shortcut-Tabellen gibt.

---

## Kernel

Der Kernel ist der Python-Prozess, der im Hintergrund läuft und deinen Code tatsächlich ausführt. Er startet, sobald du die erste Zelle ausführst, und behält danach **alle Variablen im Speicher**.

Zwei Aktionen, die du kennen musst:

- **Restart Kernel** – wirft alle Variablen weg und fängt bei null an. Der Code im Notebook bleibt natürlich stehen.
- **Kernel wechseln** – schaltet auf ein anderes Python um, also auf ein anderes Conda-Environment. Bei uns muss dort `Python (dsai)` stehen.

Wenn ein `import` fehlschlägt, obwohl das Paket installiert ist, ist fast immer der falsche Kernel eingestellt. Der Unterschied zwischen Environment und Kernel ist in `00_InstallParty` erklärt.

---

## Die Ausführungsreihenfolge

Das ist der wichtigste Abschnitt auf dieser Seite.

Links neben jeder ausgeführten Zelle steht eine Zahl: `In [1]`, `In [2]`, `In [3]`. Diese Zahl sagt **in welcher Reihenfolge du die Zellen ausgeführt hast** – nicht, wo sie im Notebook stehen. Steht irgendwo `In [7]` über einem `In [3]`, dann bist du beim Arbeiten im Notebook herumgesprungen.

Der entscheidende Punkt dahinter: **Was auf dem Bildschirm steht, ist nicht das, was gerade gilt.** Eine Ausgabe bleibt stehen, bis du die Zelle erneut ausführst – auch wenn ihre Grundlage sich längst geändert hat.

### Fall 1: Du änderst etwas weiter oben

```python
# Zelle 1
preis = 100
```

```python
# Zelle 2
print(preis * 1.2)      # 120.0
```

Jetzt änderst du in Zelle 1 den Preis auf `200` und führst **nur diese eine Zelle** aus. Unter Zelle 2 steht weiterhin `120.0`. Das sieht aus wie ein aktuelles Ergebnis, ist aber ein Bild von vorhin. Erst wenn du Zelle 2 ebenfalls neu ausführst, erscheint `240.0`.

**Merksatz: Änderst du eine Zelle, musst du alle Zellen darunter neu ausführen, die davon abhängen.**

Besonders tückisch ist das bei Funktionen:

```python
# Zelle 1
def rabatt(preis):
    return preis * 0.9
```

Änderst du hier `0.9` auf `0.8`, ohne die Zelle auszuführen, rechnet der Kernel unbeirrt mit der alten Fassung weiter. Im Code steht das eine, im Speicher liegt das andere – und du suchst den Fehler an der falschen Stelle.

### Fall 2: Du löschst etwas weiter oben

```python
# Zelle 1
x = 10
```

```python
# Zelle 2
print(x * 2)            # 20
```

Löschst du Zelle 1 und führst Zelle 2 erneut aus, kommt weiterhin `20`. Denn `x` liegt im Speicher des Kernels und interessiert sich nicht dafür, dass die Zelle verschwunden ist.

Dein Notebook funktioniert also – aber nur bei dir, nur jetzt, nur in dieser Sitzung. Wer es morgen öffnet und von oben nach unten durchlaufen lässt, bekommt einen `NameError`.

### Die Gegenprobe

In beiden Fällen hilft dasselbe, und es dauert zehn Sekunden: *Restart Kernel and Run All Cells*. Der Speicher wird geleert und das Notebook von der ersten bis zur letzten Zelle frisch durchgerechnet. Läuft es dann fehlerfrei durch und stehen dieselben Ergebnisse da wie vorher, stimmt es wirklich.

Mach das, wann immer du länger an einem Notebook herumgeschraubt hast – und immer, bevor du es aus der Hand gibst.

Was gerade im Speicher liegt, verrät dir:

```python
%whos
```

---

# Teil C – Bedienung

### Überall gleich

| Shortcut | Aktion |
| --- | --- |
| `Shift + Enter` | Zelle ausführen und zur nächsten springen |
| `Ctrl + Enter` | Zelle ausführen, Cursor bleibt stehen |
| `Esc` | in den Befehlsmodus wechseln |
| `Enter` | in den Editiermodus wechseln |
| `Tab` | Code vervollständigen |
| `Shift + Tab` | Hilfe zur Funktion einblenden (im Browser; in PyCharm `Ctrl + Q`) |

### Befehlsmodus im Browser

> **Zuerst `Esc` drücken.** Diese Tasten funktionieren **nur** im Befehlsmodus. Tippst du sie, während der Cursor in der Zelle blinkt, schreibst du einfach den Buchstaben in den Code.
>
> Woran du erkennst, wo du bist: am farbigen Balken links neben der Zelle. **Blau** heißt Befehlsmodus – die Zelle ist als Ganzes ausgewählt und der Cursor ist verschwunden. **Grün** heißt Editiermodus – du schreibst gerade hinein.

| Shortcut | Aktion |
| --- | --- |
| `A` | neue Zelle **oberhalb** einfügen |
| `B` | neue Zelle **unterhalb** einfügen |
| `D D` | Zelle löschen (zweimal `D`) |
| `Z` | Löschen rückgängig machen |
| `M` | Zelle in **Markdown** umwandeln |
| `Y` | Zelle in **Code** umwandeln |
| `Shift + M` | markierte Zellen zusammenführen |
| `Ctrl + Shift + -` | Zelle an der Cursorposition teilen |
| `0 0` | Kernel neu starten (zweimal die Null, zügig hintereinander) – **in PyCharm nicht belegt** |

### Zusätzlich in PyCharm

PyCharm kennt die Zellen-Shortcuts von oben größtenteils ebenfalls, bringt aber seine eigenen Editor-Funktionen mit:

| Shortcut | Aktion |
| --- | --- |
| `Ctrl + /` | markierte Zeilen aus- und einkommentieren |
| `Ctrl + Num +` | Codeblock aufklappen |
| `Ctrl + Num -` | Codeblock zuklappen |
| `Ctrl + Shift + A` | Aktion suchen, wenn du den Shortcut nicht weißt |

**Der Kernel-Neustart hat in PyCharm keinen Shortcut.** Das `0 0` aus der Tabelle oben ist hier nicht belegt und tut nichts. Stattdessen den Knopf mit dem Kreispfeil in der Werkzeugleiste über dem Notebook verwenden, oder *Run → Restart Kernel*. Wer unbedingt eine Taste dafür will, kann sich unter *Settings → Keymap* selbst eine zuweisen.

Die vollständige und für deine Version garantiert richtige Liste steht in PyCharm unter *Settings → Keymap*, dort im Suchfeld `Jupyter` eingeben.

---

# Teil D – Werkzeuge im Notebook

## Hilfe, ohne den Browser zu wechseln

Wenn du wissen willst, was eine Funktion macht und welche Parameter sie kennt, musst du nicht googeln. Es gibt drei Wege – und sie funktionieren nicht überall gleich.

### Überall: `help()`

Das ist normales Python und läuft in jedem Notebook, in jeder Konsole und in jeder `.py`-Datei:

```python
import pandas as pd

help(pd.read_csv)
```

### Nur im Notebook: das Fragezeichen

```python
pd.read_csv?        # Kurzhilfe: Beschreibung und Parameter
pd.read_csv??       # dazu der Quelltext der Funktion
```

**Achtung:** Das ist *kein* Python, sondern eine Abkürzung der Notebook-Umgebung IPython. In einer `.py`-Datei oder der normalen Python-Konsole bekommst du dafür einen `SyntaxError`. Es muss außerdem allein in der Zeile stehen, nicht hinter anderem Code.

Am zuverlässigsten funktioniert es in JupyterLab im Browser. Dort blendet `Shift + Tab` mit dem Cursor in einem Funktionsnamen dieselbe Information direkt ein, ohne die Zelle auszuführen.

### In PyCharm: die IDE fragen

In PyCharm brauchst du das Fragezeichen gar nicht – dafür gibt es eingebaute Funktionen, die besser dargestellt werden:

| Shortcut | Aktion |
| --- | --- |
| `Ctrl + Q` (macOS `F1`) | Quick Documentation zum Namen unter dem Cursor |
| `Ctrl + B` | zur Definition springen, also zum Quelltext |
| `Ctrl + P` | Parameterliste einblenden, während du die Klammern tippst |

Merksatz: **Im Browser das Fragezeichen, in PyCharm `Ctrl + Q`, und `help()` immer.**

---

## Magic Commands

Befehle, die mit `%` beginnen, sind keine Python-Befehle, sondern Anweisungen an die Notebook-Umgebung. Ein `%` gilt für eine Zeile, `%%` für die ganze Zelle.

```python
%whos               # welche Variablen liegen gerade im Speicher?
%time  summe = sum(range(1000000))   # wie lange dauert diese eine Zeile?
%pwd                # in welchem Ordner arbeite ich gerade?
```

```python
%%timeit
summe = sum(range(1000000))          # misst die ganze Zelle, mehrfach, mit Mittelwert
```

Mit einem Rufzeichen führst du Kommandozeilenbefehle aus, ohne das Notebook zu verlassen:

```python
!pip list           # installierte Pakete
!ls                 # Dateien im Ordner (Windows: !dir)
```

> **`%matplotlib inline`** findest du in fast jedem älteren Tutorial. Du brauchst es nicht mehr – Diagramme erscheinen seit Jahren von selbst im Notebook. Es schadet nicht, ist aber überflüssig.

---

## Markdown und Formeln

In Markdown-Zellen gilt die übliche Markdown-Syntax: `#` für Überschriften, `-` für Listen, Backticks für Code.

Formeln schreibst du in LaTeX-Notation zwischen Dollarzeichen. Unten steht jeweils zuerst, **was du tippst**, und darunter, **wie es aussieht**.

### Einfache Dollarzeichen – mitten im Text

Du schreibst:

```markdown
Die Fläche wächst mit $r^2$, der Fehler sinkt mit $1/\sqrt{n}$.
```

Das ergibt:

Die Fläche wächst mit $r^2$, der Fehler sinkt mit $1/\sqrt{n}$.

### Doppelte Dollarzeichen – freigestellt und zentriert

Du schreibst:

```markdown
$$
\bar{x} = \frac{1}{n} \sum_{i=1}^{n} x_i
$$
```

Das ergibt:

$$
\bar{x} = \frac{1}{n} \sum_{i=1}^{n} x_i
$$

Das ist die Formel für den Mittelwert – sie begegnet dir in `03_Statistic` wieder.

Setz die beiden `$$` möglichst in eigene Zeilen, so wie oben. In einer einzigen Zeile funktioniert es zwar meistens auch, aber manche Betrachter stolpern darüber.

### Wenn nichts gerendert wird

Zwei Ursachen, in dieser Reihenfolge prüfen:

1. **Die Zelle wurde nicht ausgeführt.** Eine Markdown-Zelle zeigt ihren Rohtext, bis du sie mit `Shift + Enter` bestätigst.
2. **In PyCharms Markdown-Vorschau ist LaTeX abgeschaltet.** Das betrifft `.md`-Dateien, nicht Notebooks. Einschalten unter *Settings → Languages & Frameworks → Markdown → Markdown Extensions*, dort das Häkchen bei **Mathematics** setzen. PyCharm lädt dafür beim ersten Mal eine Komponente nach.

Steht die Formel in einem Codeblock mit drei Backticks, wird sie übrigens nie gerendert – dort ist roher Text ja gerade der Zweck.

---

## Speichern und Checkpoints

Jupyter speichert automatisch. *File → Save and Create Checkpoint* legt zusätzlich einen Wiederherstellungspunkt an, zu dem du zurückspringen kannst. PyCharm speichert ebenfalls automatisch und hat mit *Local History* seine eigene, feinere Variante davon.

> **Nebenbei, arbeiten mit git:** Eine `.ipynb`-Datei speichert nicht nur den Code, sondern auch sämtliche Ausgaben – Bilder als lange Zeichenketten mittendrin. Zwei Notebooks zu vergleichen wird dadurch unmöglich, und das Repository wird groß. Wer das sauber halten will, löscht vor dem Commit die Ausgaben (*Kernel → Restart and Clear Outputs*) oder verwendet ein Werkzeug wie `nbstripout`.
