# STCGitHub

Repozitář s ukázkami pro prezentaci o GitHubu v prohlížeči: osnova s návodem krok za krokem, základní kód a větve připravené na demo **Issues**, **.gitignore**, **Rebase** a **Merge conflict**.

## Kde začít

Otevři [OSNOVA.md](OSNOVA.md): časový plán, příprava a postup ke každé z částí prezentace.

## Struktura repozitáře

```
STCGitHub/
├── README.md
├── OSNOVA.md                      osnova prezentace s návodem krok za krokem
├── .gitignore                     ukázkový .gitignore pro tento projekt
├── .gitattributes                 jednotné konce řádků (skripty musí mít LF)
├── .env.example                   vzor konfigurace; skutečný .env se necommituje
├── .github/
│   ├── ISSUE_TEMPLATE/            šablony issue (chyba, nápad)
│   └── pull_request_template.md   šablona popisu PR (včetně „Closes #“)
├── src/                           základní ukázkový kód (Python)
└── scripts/
    └── setup-demo.sh              vytvoří demo větve
```

## Ukázkový kód

Jednoduchý program, který vypíše pozdrav. Potřebuješ jen Python 3.

```
python src/app.py
```

Výstup: `Ahoj, světe!`

Pozdrav je schválně v samostatném souboru `src/greeting.py` na jediném řádku. Právě ten řádek se v ukázce merge conflictu změní ve dvou větvích najednou.

## Demo větve

Skript vytvoří větve s předpřipraveným stavem. Větev `main` nikdy nemění, všechny demo větve začínají na `demo/`.

```
bash scripts/setup-demo.sh           # jen lokálně
bash scripts/setup-demo.sh --push    # a pošle je na GitHub (přepíše stávající demo/*)
```

Ve Windows ho spusť v **Git Bash**, nebo z PowerShellu:

```
& 'C:\Program Files\Git\bin\bash.exe' scripts/setup-demo.sh --push
```

Skript lze pouštět opakovaně: demo větve vždy smaže a vytvoří znovu, takže je to zároveň „reset“ po zkoušce. Starší pull requesty z minulého kola je ale potřeba zavřít ručně.

| Větev | Co na ní je | Na čem se ukazuje |
|---|---|---|
| `demo/base` | `main` + 2 commity (`CHANGELOG.md`) | Cíl pull requestů, hraje roli `main`. |
| `demo/rebase-feature` | `main` + 2 commity (`src/farewell.py`) | **Rebase**: je o 2 commity pozadu za `demo/base`. PR do `demo/base`. |
| `demo/conflict-a`, `demo/conflict-b` | Obě jinak mění řádek `GREETING` v `src/greeting.py`. | **Merge conflict**: PR obou do `demo/base`. Po mergi prvního má druhý konflikt. |
| `demo/gitignore` | Chybí `.gitignore`, `.env` a `debug.log` jsou commitnuté. | **.gitignore** |

**Issues** se ukazují přímo na `main`: šablony jsou ve složce `.github/ISSUE_TEMPLATE` a šablona pull requestu obsahuje řádek `Closes #`.
