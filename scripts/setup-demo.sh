#!/usr/bin/env bash
#
# Připraví demo větve pro prezentaci. Všechny začínají na "demo/".
# Větev main se nikdy nemění.
#
#   bash scripts/setup-demo.sh           # jen lokálně
#   bash scripts/setup-demo.sh --push    # a pošle je na origin (PŘEPÍŠE stávající demo/*)
#
# Skript lze pouštět opakovaně: demo větve vždy smaže a vytvoří znovu.
# Pouštěj ho z repozitáře bez neuložených změn.

set -euo pipefail

PUSH=0
case "${1:-}" in
  "") ;;
  --push) PUSH=1 ;;
  *) echo "Neznámý parametr: $1 (povolen je jen --push)" >&2; exit 1 ;;
esac

cd "$(git rev-parse --show-toplevel)"

if [ -n "$(git status --porcelain)" ]; then
  echo "Pracovní složka obsahuje neuložené změny. Nejdřív je commitni nebo stashni." >&2
  exit 1
fi

if ! git rev-parse --verify --quiet main >/dev/null; then
  echo "Větev main neexistuje. Založ nejdřív první commit na main." >&2
  exit 1
fi

BRANCHES=(demo/gitignore demo/base demo/rebase-feature demo/conflict-a demo/conflict-b)

git checkout -q main
for b in "${BRANCHES[@]}"; do
  git branch -D "$b" >/dev/null 2>&1 || true
done

commit() {
  git add -A
  git commit -q -m "$1"
}

# Přepíše řádek GREETING v src/greeting.py (sed bez -i, ať to jede všude stejně).
set_greeting() {
  sed "s/^GREETING = .*/GREETING = \"$1\"/" src/greeting.py > src/greeting.py.tmp
  mv src/greeting.py.tmp src/greeting.py
}

# --- demo/base: hraje roli "mainu", je o dva commity před main -----------------
git checkout -q -b demo/base main
cat > CHANGELOG.md <<'EOF'
# Changelog

## Nepublikováno
- Založen soubor CHANGELOG.
EOF
commit "Přidán CHANGELOG"
cat >> CHANGELOG.md <<'EOF'
- Doplněn popis změn k verzi 0.1.
EOF
commit "Doplněn popis verze 0.1 do CHANGELOGu"

# --- demo/conflict-a a demo/conflict-b: mění STEJNÝ řádek ----------------------
git checkout -q -b demo/conflict-a demo/base
set_greeting "Ahoj, GitHube!"
commit "Pozdrav: oslovení GitHubu"

git checkout -q -b demo/conflict-b demo/base
set_greeting "Vítejte na GitHubu!"
commit "Pozdrav: uvítání na GitHubu"

# --- demo/rebase-feature: vychází z main, takže je pozadu za demo/base ---------
git checkout -q -b demo/rebase-feature main
cat > src/farewell.py <<'EOF'
"""Rozloučení: ukázková funkce pro demo rebase."""

FAREWELL = "Nashledanou!"
EOF
commit "Přidán soubor farewell.py s textem rozloučení"
cat >> src/farewell.py <<'EOF'


def say_farewell():
    print(FAREWELL)
EOF
commit "Přidána funkce say_farewell"

# --- demo/gitignore: chybí .gitignore, .env a debug.log jsou commitnuté --------
git checkout -q -b demo/gitignore main
git rm -q .gitignore
printf 'API_KEY=demo-neni-skutecny-klic\n' > .env
printf '2026-11-01 10:00:01 INFO  Aplikace spuštěna\n2026-11-01 10:00:02 ERROR Něco se pokazilo (demo)\n' > debug.log
git add -f .env debug.log
git commit -q -m "Omylem commitnuté .env a debug.log (a chybí .gitignore)"

git checkout -q main

echo
echo "Hotovo. Demo větve:"
git branch --list 'demo/*'

if [ "$PUSH" = 1 ]; then
  if ! git remote get-url origin >/dev/null 2>&1; then
    echo "Chybí remote 'origin', nemám kam pushnout." >&2
    exit 1
  fi
  echo
  echo "Posílám demo větve na origin (přepisuji stávající demo/*)..."
  git push --force origin "${BRANCHES[@]}"
fi
