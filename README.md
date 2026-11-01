# STCGitHub

Podklady k 30minutové prezentaci **GitHub v prohlížeči**: plán a poznámky pro řečníka, úplně základní ukázkový kód a větve připravené na živé demo.

Čtyři témata: **Issues**, **.gitignore**, **Rebase** a **Merge conflict**.

## Kde začít

1. Přečti si [plán prezentace](docs/00-plan-prezentace.md): časy, příprava a tipy.
2. Ke každé části je vlastní stránka s tím, co ukázat a co říct (`docs/01` až `docs/06`).
3. Demo větve vytvoříš jedním skriptem, viz [Příprava dema](#příprava-dema).

## Struktura repozitáře

```
STCGitHub/
├── README.md                      tento soubor
├── .gitignore                     ukázkový .gitignore pro tento projekt
├── .gitattributes                 jednotné konce řádků (skripty musí mít LF)
├── .env.example                   vzor konfigurace; skutečný .env se necommituje
├── .github/
│   ├── ISSUE_TEMPLATE/            šablony issue (chyba, nápad)
│   └── pull_request_template.md   šablona popisu PR (včetně „Closes #“)
├── docs/                          plán prezentace a poznámky k jednotlivým částem
├── src/                           základní ukázkový kód (Python)
└── scripts/
    └── setup-demo.sh              vytvoří demo větve pro živé ukázky
```

## Ukázkový kód

Jednoduchý program, který vypíše pozdrav. Potřebuješ jen Python 3.

```
python src/app.py
```

Výstup: `Ahoj, světe!`

Pozdrav je schválně v samostatném souboru `src/greeting.py` na jediném řádku. Právě ten řádek se v ukázce merge conflictu změní ve dvou větvích najednou.

## Příprava dema

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

Přehled větví a co která slouží ukázat je v [plánu prezentace](docs/00-plan-prezentace.md#demo-větve).
