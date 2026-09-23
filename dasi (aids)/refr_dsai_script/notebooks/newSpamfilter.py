"""
Spam-Filter mit sklearn
========================
Thema: Klassifikation von E-Mails als Spam oder Kein Spam
Modelle: Naive Bayes vs. Logistic Regression (Vergleich)
Bonus:   Overfitting & Underfitting Demo mit Decision Tree
"""

import numpy as np
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.naive_bayes import MultinomialNB
from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score, classification_report, confusion_matrix

# ─────────────────────────────────────────────
# 1. Trainingsdaten (E-Mail Texte)
# ─────────────────────────────────────────────

emails = [
    # SPAM (Label = 1)
    "Gewinne jetzt 1000 Euro gratis klick hier",
    "Dringend Ihr Konto wurde gesperrt jetzt entsperren",
    "Sonderangebot Viagra günstig kaufen",
    "Sie haben gewonnen Preis abholen jetzt klicken",
    "Kostenlos Geld verdienen von zu Hause",
    "Gratis iPhone gewinnen jetzt teilnehmen",
    "Dringende Nachricht Ihr Passwort abgelaufen",
    "Million Euro Erbschaft klick hier",
    "Abnehmen ohne Sport Wunderpille jetzt bestellen",
    "Casino online jetzt spielen Bonus gratis",
    "Kredit ohne Schufa sofort auszahlung",
    "Deine Rechnung ist fällig sofort bezahlen klick",
    "Lottogewinn abholen dringend antworten",
    "Gratis Reise gewinnen jetzt registrieren",
    "Investiere jetzt Bitcoin Gewinn garantiert",
    "Handy Vertrag kostenlos jetzt sichern",
    "Ihr Amazon Konto gesperrt bestätigen",
    "Schnell reich werden Geheimtipp klick",
    "Günstig Medikamente online bestellen",
    "Freie Stellen von zu Hause arbeiten Geld verdienen",

    # KEIN SPAM (Label = 0)
    "Hallo wie geht es dir heute",
    "Das Meeting findet morgen um 10 Uhr statt",
    "Kannst du mir bitte die Datei schicken",
    "Ich habe die Hausaufgaben fertig gemacht",
    "Das Wetter heute ist sehr schön",
    "Wir treffen uns um 14 Uhr im Büro",
    "Danke für deine schnelle Antwort",
    "Die Bestellung ist unterwegs und kommt morgen",
    "Bitte denk an das Teammeeting am Freitag",
    "Hast du das Buch schon gelesen",
    "Ich schicke dir die Unterlagen per Mail",
    "Das Projekt läuft gut wir sind im Zeitplan",
    "Kannst du heute Abend kommen",
    "Die Rechnung liegt im Anhang bitte prüfen",
    "Herzlichen Glückwunsch zum Geburtstag",
    "Das neue Update wurde erfolgreich installiert",
    "Bitte fülle das Formular aus bis Freitag",
    "Ich rufe dich morgen an wegen dem Termin",
    "Das Essen war wirklich sehr lecker gestern",
    "Der Bericht ist fertig und kann verschickt werden",
]

labels = [1]*20 + [0]*20  # 1 = Spam, 0 = Kein Spam

# ─────────────────────────────────────────────
# 2. Text in Zahlen umwandeln (Bag of Words)
# ─────────────────────────────────────────────

vectorizer = CountVectorizer()
X = vectorizer.fit_transform(emails)
y = np.array(labels)

# Train/Test Split (80% Training, 20% Test)
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

print("=" * 55)
print("SPAM-FILTER — MODELLVERGLEICH")
print("=" * 55)
print(f"Trainingsdaten: {X_train.shape[0]} E-Mails")
print(f"Testdaten:      {X_test.shape[0]} E-Mails")
print(f"Features:       {X_train.shape[1]} Wörter (Bag of Words)")

# ─────────────────────────────────────────────
# 3. Modelle vergleichen: Naive Bayes vs. Logistic Regression
# ─────────────────────────────────────────────

print("\n" + "=" * 55)
print("MODELLVERGLEICH")
print("=" * 55)

modelle = {
    "Naive Bayes":         MultinomialNB(),
    "Logistic Regression": LogisticRegression(max_iter=1000),
}

for name, model in modelle.items():
    model.fit(X_train, y_train)
    y_pred = model.predict(X_test)
    acc    = accuracy_score(y_test, y_pred)
    print(f"\n--- {name} ---")
    print(f"Genauigkeit (Accuracy): {acc:.2%}")
    print(classification_report(y_test, y_pred, target_names=["Kein Spam", "Spam"]))

# ─────────────────────────────────────────────
# 4. predict_proba — Wahrscheinlichkeit statt nur Ja/Nein
# ─────────────────────────────────────────────

print("=" * 55)
print("PREDICT_PROBA — Wahrscheinlichkeit ausgeben")
print("(Logistic Regression)")
print("=" * 55)

lr_model = LogisticRegression(max_iter=1000)
lr_model.fit(X_train, y_train)

test_emails = [
    "Klick hier und gewinne gratis Geld",
    "Bitte komm morgen zum Meeting um 9 Uhr",
    "Dringend Ihr Konto wurde gesperrt",
    "Danke für die schnelle Antwort auf meine Frage",
]

test_X = vectorizer.transform(test_emails)
predictions  = lr_model.predict(test_X)
probabilities = lr_model.predict_proba(test_X)  # [[P(kein Spam), P(Spam)], ...]

for email, pred, prob in zip(test_emails, predictions, probabilities):
    label      = "SPAM     " if pred == 1 else "Kein Spam"
    prob_spam  = prob[1] * 100
    prob_ham   = prob[0] * 100
    print(f"\nE-Mail:        {email}")
    print(f"Vorhersage:    {label}")
    print(f"P(Kein Spam):  {prob_ham:.1f}%")
    print(f"P(Spam):       {prob_spam:.1f}%")

# ─────────────────────────────────────────────
# 5. OVERFITTING & UNDERFITTING DEMO
#    mit Decision Tree (max_depth variieren)
# ─────────────────────────────────────────────

print("\n" + "=" * 55)
print("OVERFITTING & UNDERFITTING DEMO")
print("(Decision Tree mit verschiedenen Tiefen)")
print("=" * 55)
print(f"{'Tiefe':>10} | {'Train Acc':>10} | {'Test Acc':>10} | {'Bewertung':>22}")
print("-" * 60)

depths = [1, 2, 3, 5, 10, None]

for depth in depths:
    tree = DecisionTreeClassifier(max_depth=depth, random_state=42)
    tree.fit(X_train, y_train)

    train_acc = accuracy_score(y_train, tree.predict(X_train))
    test_acc  = accuracy_score(y_test,  tree.predict(X_test))
    diff      = train_acc - test_acc

    if depth == 1:
        bewertung = "Underfitting (zu simpel)"
    elif diff > 0.15:
        bewertung = "Overfitting (zu komplex)"
    else:
        bewertung = "Gut ausgewogen"

    depth_str = str(depth) if depth else "unbegrenzt"
    print(f"{depth_str:>10} | {train_acc:>9.1%} | {test_acc:>9.1%} | {bewertung:>22}")

print("\nErklärung:")
print("  Underfitting: Train UND Test Accuracy niedrig")
print("               → Modell zu simpel, lernt kaum etwas")
print("  Overfitting:  Train Accuracy hoch, Test Accuracy niedrig")
print("               → Modell hat auswendig gelernt, kein echtes Wissen")
print("  Ziel:         Train und Test Accuracy beide hoch und ähnlich")

# ─────────────────────────────────────────────
# 6. Cross-Validation (zuverlässigere Auswertung)
# ─────────────────────────────────────────────

print("\n" + "=" * 55)
print("CROSS-VALIDATION (5-Fold)")
print("=" * 55)

for name, model in modelle.items():
    cv_scores = cross_val_score(model, X, y, cv=5)
    print(f"\n{name}:")
    print(f"  Scores:       {[f'{s:.2%}' for s in cv_scores]}")
    print(f"  Durchschnitt: {cv_scores.mean():.2%} (+/- {cv_scores.std():.2%})")

print("\nCross-Validation teilt die Daten 5x anders auf")
print("→ zuverlässigeres Ergebnis als ein einzelner Test-Split")
