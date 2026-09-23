import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

mu, sigma = 178, 7
x = np.linspace(mu - 4*sigma, mu + 4*sigma, 800)
y = 1/(sigma*np.sqrt(2*np.pi)) * np.exp(-(x-mu)**2/(2*sigma**2))

fig, ax = plt.subplots(figsize=(8.4, 4.2), dpi=160)
fig.patch.set_facecolor("white")
ax.set_facecolor("white")

BLAU, FLAECHE, GRAU = "#3f6ea8", "#bcd4ee", "#6b7480"

# Flaeche 175 bis 185
maske = (x >= 175) & (x <= 185)
ax.fill_between(x[maske], y[maske], color=FLAECHE, zorder=1)
ax.plot(x, y, color=BLAU, lw=2, zorder=3)

# Mittelwert
ax.vlines(mu, 0.0235, 1/(sigma*np.sqrt(2*np.pi)), color=BLAU, ls=(0, (5, 3)), lw=1.3, zorder=4)
ax.text(mu, 0.0605, r"$\mu = 178$ cm", ha="center", fontsize=10.5, color="#24405f")

# Flaechenbeschriftung
ax.text(180, 0.0135, "50,7 %", ha="center", fontsize=15, color="#1d3a52",
        fontweight="bold")
ax.annotate("", xy=(175, 0.0072), xytext=(185, 0.0072),
            arrowprops=dict(arrowstyle="<->", color="#24405f", lw=1.1))
ax.text(180, 0.0022, "175 cm bis 185 cm", ha="center", fontsize=9.5, color="#24405f")

# Sigma-Bereich
ax.annotate("", xy=(mu-sigma, 0.0655), xytext=(mu+sigma, 0.0655),
            arrowprops=dict(arrowstyle="<->", color=GRAU, lw=1))
ax.text(mu, 0.0672, "68 % liegen innerhalb einer Standardabweichung (171–185 cm)",
        ha="center", fontsize=9, color=GRAU)

ax.set_xlabel("Körpergröße in cm", fontsize=10.5, color="#3d4650")
ax.set_ylabel("Dichte  f(x)   pro cm", fontsize=10.5, color="#3d4650")
ax.set_xlim(mu-3.6*sigma, mu+3.6*sigma)
ax.set_ylim(0, 0.075)
ax.set_xticks([157, 164, 171, 178, 185, 192, 199])
ax.tick_params(colors="#5a636c", labelsize=9.5)
for rand in ("top", "right"):
    ax.spines[rand].set_visible(False)
for rand in ("left", "bottom"):
    ax.spines[rand].set_color("#c3cad1")
ax.grid(axis="y", color="#e8ebee", lw=0.8)
ax.set_axisbelow(True)

fig.tight_layout()
fig.savefig("/tmp/koerpergroesse_pdf.png", facecolor="white")
print("gespeichert")
