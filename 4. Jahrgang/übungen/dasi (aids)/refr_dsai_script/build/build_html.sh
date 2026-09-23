#!/usr/bin/env bash
#
# Baut aus den Markdown-Handouts im Hauptverzeichnis eine Webseite
# (fuer GitLab Pages).
#
#   ./build/build_html.sh
#
# Ergebnis liegt in ./public/: index.html und pro Handout eine HTML-Datei.
# Die Startseite entsteht automatisch aus den Ueberschriften, ein neues
# Handout muss also nirgends eingetragen werden.
#
# Nur die *.md im Hauptverzeichnis kommen auf die Webseite. Notebooks und
# Daten werden nicht kopiert, Verweise darauf zeigen ins GitLab-Repository.
#
set -euo pipefail

# Feste Reihenfolge, egal in welcher Systemsprache das laeuft
# (06_Pandas.md vor 06_Pandas_Dataframe.md, Kleingeschriebenes zuletzt).
export LC_COLLATE=C

BUILD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(dirname "$BUILD_DIR")"
OUT="$ROOT/public"
CSS="$BUILD_DIR/web.css"

# Wohin Verweise auf notebooks/ und data/ zeigen. In der CI setzt GitLab
# die beiden Variablen, lokal gelten die Vorgaben.
REPO_BLOB="${CI_PROJECT_URL:-https://gitlab.com/reif1337/refr_dsai_script}/-/blob/${CI_DEFAULT_BRANCH:-main}"

if ! command -v pandoc >/dev/null 2>&1; then
  echo "FEHLER: pandoc fehlt." >&2
  echo "  Arch:   sudo pacman -S pandoc" >&2
  echo "  Debian: sudo apt install pandoc" >&2
  echo "  macOS:  brew install pandoc" >&2
  exit 1
fi

# pandoc hat die Option fuer Syntax-Highlighting umbenannt.
if pandoc --help 2>/dev/null | grep -q -- "--syntax-highlighting"; then
  HL_OPT="--syntax-highlighting=tango"
else
  HL_OPT="--highlight-style=tango"
fi

cd "$ROOT"
rm -rf "$OUT"
mkdir -p "$OUT"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

# Text fuer HTML unschaedlich machen (in Titeln steht z.B. ein &)
esc() { sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g'; }

# Front-Matter (--- ... ---) ganz am Dateianfang entfernen. Die Mindmap-Datei
# beginnt damit, auf der Webseite waere es sonst als Text zu sehen.
ohne_frontmatter() {
  awk '
    BEGIN { kopf = 1; block = 0 }
    kopf && /^---[ \t]*$/ { block = !block; next }
    kopf && block         { next }
    { kopf = 0; print }
  ' "$1"
}

: > "$TMP/karten.html"
built=0

for md in *.md; do
  [ -f "$md" ] || continue
  [ "$md" = "README.md" ] && continue
  base="${md%.md}"

  # Nummer fuer die Karte: 06_... -> 06, 09_1_... -> 09.1, ohne Nummer -> ★
  if [[ "$base" =~ ^([0-9]{2})_([0-9]+)_ ]]; then
    nr="${BASH_REMATCH[1]}.${BASH_REMATCH[2]}"
  elif [[ "$base" =~ ^([0-9]{2})_ ]]; then
    nr="${BASH_REMATCH[1]}"
  else
    nr="★"
  fi

  # Titel: erste Ueberschrift, sonst aus dem Dateinamen
  titel="$(grep -m1 '^# ' "$md" | sed 's/^# //' || true)"
  if [ -z "$titel" ]; then
    titel="$(printf '%s' "$base" | sed -E 's/^[0-9]{2}_([0-9]+_)?//; s/_/ /g')"
  fi

  # Link zurueck zur Startseite, wird vor den Inhalt gesetzt
  printf '<nav class="topnav"><a href="index.html">&larr; Übersicht</a></nav>\n' > "$TMP/nav.html"

  # Mermaid-Diagramme braucht ein kleines Skript, nur dort wo es welche gibt
  extra=()
  if grep -q '^```mermaid' "$md"; then
    extra=(--include-after-body="$BUILD_DIR/mermaid.html")
  fi

  # --embed-resources packt CSS und Bilder direkt in die HTML-Datei,
  # jede Seite laesst sich also auch einzeln weitergeben.
  # --mathml stellt Formeln ($...$, $$...$$) ohne Internet und ohne JavaScript dar.
  ohne_frontmatter "$md" |
  sed -E "s#\]\((notebooks|data)/#](${REPO_BLOB}/\1/#g" |
  pandoc --from=markdown-yaml_metadata_block-simple_tables-multiline_tables+raw_html+task_lists+pipe_tables+backtick_code_blocks \
         --to=html5 --standalone --embed-resources --mathml \
         "$HL_OPT" \
         --css="$CSS" \
         --resource-path="$ROOT" \
         --include-before-body="$TMP/nav.html" \
         ${extra[@]+"${extra[@]}"} \
         --metadata=lang=de-AT \
         --metadata=pagetitle="$titel" \
         -o "$OUT/$base.html"

  {
    printf '    <div class="karte">\n'
    printf '      <div class="nr">%s</div>\n' "$nr"
    printf '      <div>\n'
    printf '        <h3><a href="%s.html">%s</a></h3>\n' "$base" "$(printf '%s' "$titel" | esc)"
    printf '      </div>\n'
    printf '    </div>\n'
  } >> "$TMP/karten.html"

  printf '  %-46s -> public/%s.html\n' "$md" "$base"
  built=$((built + 1))
done

# Startseite: Vorlage mit den erzeugten Karten an der Markierung
awk -v karten="$TMP/karten.html" '
  /<!--KARTEN-->/ { while ((getline zeile < karten) > 0) print zeile; next }
  { print }
' "$BUILD_DIR/index.html" > "$OUT/index.html"

# Die Handouts betten ihre Bilder selbst ein, die Startseite braucht nur das Logo
mkdir -p "$OUT/resources"
cp resources/HTLstp-RGB150.png "$OUT/resources/"

echo
echo "Fertig. $built Seiten. public/index.html im Browser oeffnen."
