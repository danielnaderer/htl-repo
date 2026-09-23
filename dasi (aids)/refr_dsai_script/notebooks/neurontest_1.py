import numpy as np
import matplotlib.pyplot as plt

# -----------------------------
# 1) Trainingsdaten (2D): zwei Klassen, linear trennbar
# -----------------------------
np.random.seed(0)
# Easy
n = 80
X_pos = np.random.randn(n, 2) * 0.6 + np.array([2.0, 2.0])   # Klasse +1
X_neg = np.random.randn(n, 2) * 0.6 + np.array([-2.0, -2.0]) # Klasse -1

# Hard
# n = 60
# X_pos = np.random.randn(n, 2) * 1.2 + np.array([1.0, 1.0])
# X_neg = np.random.randn(n, 2) * 1.2 + np.array([-1.0, -1.0])

#
X = np.vstack([X_pos, X_neg])
y = np.hstack([np.ones(n), -np.ones(n)])  # Labels: +1 und -1

# Bias als extra Eingabe x0 = 1
Xb = np.hstack([np.ones((X.shape[0], 1)), X])  # (1, x1, x2)

# XOR Artige Punkte
# np.random.seed(0)
# n = 80
# X = np.random.uniform(-1, 1, size=(n, 2))
# y = np.where(X[:,0] * X[:,1] >= 0, 1, -1)  # gleiche Vorzeichen => +1, sonst -1
# Xb = np.hstack([np.ones((X.shape[0], 1)), X])


# -----------------------------
# 2) Perzeptron: Vorhersage und Update-Regel
# -----------------------------
def predict(w, x):
    # Aktivierung: Signum von w·x
    return 1 if np.dot(w, x) >= 0 else -1

def train_perceptron(Xb, y, epochs=20, lr=0.1):
    w = np.zeros(Xb.shape[1])  # (w0, w1, w2)
    history = []
    for epoch in range(epochs):
        mistakes = 0
        for xi, yi in zip(Xb, y):
            yhat = predict(w, xi)
            if yhat != yi:
                # Update: w <- w + lr * yi * xi
                w = w + lr * yi * xi
                mistakes += 1
        history.append((w.copy(), mistakes))
        print(f"Epoch {epoch+1:02d}: mistakes={mistakes}")
    return history

hist = train_perceptron(Xb, y, epochs=15, lr=0.1)
w_final = hist[-1][0]
print("Finale Gewichte:", w_final)

# -----------------------------
# 3) Plot: Datenpunkte + Entscheidungslinie
# -----------------------------
plt.figure()
plt.scatter(X_pos[:, 0], X_pos[:, 1], marker="o", label="Klasse +1")
plt.scatter(X_neg[:, 0], X_neg[:, 1], marker="x", label="Klasse -1")

# Entscheidungslinie: w0 + w1*x + w2*y = 0  => y = -(w0 + w1*x)/w2
w0, w1, w2 = w_final
xs = np.linspace(X[:,0].min()-1, X[:,0].max()+1, 200)

if abs(w2) > 1e-9:
    ys = -(w0 + w1*xs) / w2
    plt.plot(xs, ys, label="Entscheidungslinie")
else:
    # Sonderfall: vertikale Linie
    x_line = -w0 / w1 if abs(w1) > 1e-9 else 0
    plt.axvline(x_line, label="Entscheidungslinie (vertikal)")

plt.title("Perzeptron lernt eine lineare Trennung")
plt.xlabel("x1")
plt.ylabel("x2")
plt.legend()
plt.show()
