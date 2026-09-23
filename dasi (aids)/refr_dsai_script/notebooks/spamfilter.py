import re
import numpy as np
from sklearn.neural_network import MLPClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import classification_report

# -----------------------------
# Mini-Daten (du kannst sie erweitern)
# -----------------------------
texts = [
    "Hey, kommst du morgen zum Lernen?",
    "ACHTUNG!!! Du hast GEWONNEN! Klicke hier für 1000€",
    "Kannst du mir die Hausaufgabe schicken?",
    "Gratis Gutschein nur heute!!! Jetzt anmelden!",
    "Treffen wir uns um 16:00 bei der Bibliothek?",
    "Letzte Chance: Verdiene schnell Geld von zuhause!!!",
    "Schick mir bitte den Link zum Arbeitsblatt.",
    "Du bist ausgewählt: Kostenloses iPhone, nur Klick!",
    "Danke für deine Hilfe :)",
    "JETZT kaufen und 50% sparen!!! http://deal.example"
]

# 0 = Ham (normal), 1 = Spam
y = np.array([0,1,0,1,0,1,0,1,0,1])

# -----------------------------
# Feature-Extractor (erklärbar!)
# -----------------------------
spam_words = {"gratis", "kostenlos", "gewonnen", "gutschein", "verdiene", "chance", "kaufen", "sparen", "iphone"}

def featurize(t: str):
    t_lower = t.lower()
    has_link = 1 if re.search(r"http[s]?://|www\.", t_lower) else 0
    has_money = 1 if ("€" in t) or ("eur" in t_lower) or ("geld" in t_lower) else 0
    exclam = t.count("!")
    upper_ratio = sum(1 for c in t if c.isupper()) / max(1, sum(1 for c in t if c.isalpha()))
    length = len(t)
    word_hits = sum(1 for w in spam_words if w in t_lower)
    return [has_link, has_money, exclam, upper_ratio, length, word_hits]

X = np.array([featurize(t) for t in texts], dtype=float)

# Train/Test Split
X_train, X_test, y_train, y_test, t_train, t_test = train_test_split(
    X, y, texts, test_size=0.3, random_state=0, stratify=y
)

# -----------------------------
# Kleines neuronales Netz (MLP)
# -----------------------------
clf = MLPClassifier(hidden_layer_sizes=(6,), activation="relu", max_iter=5000, random_state=0)
clf.fit(X_train, y_train)

# Auswertung
pred = clf.predict(X_test)
print(classification_report(y_test, pred, target_names=["Ham", "Spam"]))

# -----------------------------
# Test mit neuen Nachrichten
# -----------------------------
new_texts = [
    "Hi, hast du Zeit für Mathe?",
    "GEWINNE 500€ jetzt!!! Klicke http://spam.example",
    "Kostenloser Gutschein nur heute!!!"
]
new_X = np.array([featurize(t) for t in new_texts], dtype=float)
proba = clf.predict_proba(new_X)[:, 1]  # Spam-Wahrscheinlichkeit
for t, p in zip(new_texts, proba):
    print(f"{p:5.2f}  ->  {t}")
