# Osnova prezentace: GitHub v prohlížeči (30 min)

Pořadí kopíruje běžný pracovní postup: **issue → .gitignore → rebase → merge conflict**. Každé téma navazuje na předchozí.

| # | Část | Čas | Kde se ukazuje |
|---|---|---|---|
| 1 | Úvod | 2 min | hlavní stránka repa |
| 2 | Issues | 6 min | záložka Issues, větev `main` |
| 3 | .gitignore | 5 min | větev `demo/gitignore` |
| 4 | Rebase | 7 min | PR `demo/rebase-feature` → `demo/base` |
| 5 | Merge conflict | 7 min | PR `demo/conflict-a` a `demo/conflict-b` → `demo/base` |
| 6 | Shrnutí a otázky | 3 min | hlavní stránka repa |

Větev `demo/base` hraje roli „mainu“, aby se na ukázkách nemuselo sahat do skutečné hlavní větve. Přehled demo větví je v [README](README.md#demo-větve).

---

## Příprava před prezentací

- [ ] Demo větve jsou na GitHubu: `bash scripts/setup-demo.sh --push`.
- [ ] V **Settings → General → Pull Requests** je zapnuté **Allow rebase merging**. Ať je zapnuté i **Allow merge commits** a **Allow squash merging**, aby se v ukázce nabízely všechny tři možnosti. Zapni také **Always suggest updating pull request branches**; bez toho se tlačítko „Update branch“ nemusí objevit.
- [ ] Máš otevřené tři pull requesty. **Pozor:** formulář nového PR vždy předvyplní cíl `main`. V horní řádce přepni **base:** na `demo/base`.

  | Pull request (compare → base) |
  |---|
  | `demo/rebase-feature` → `demo/base` |
  | `demo/conflict-a` → `demo/base` |
  | `demo/conflict-b` → `demo/base` |

- [ ] Máš připravené texty pro issue (jsou v části 2) někde po ruce, třeba v poznámkovém bloku.
- [ ] Máš otevřené záložky: Issues, Pull requests, hlavní stránka repa a repozitář `github/gitignore`.
- [ ] Ke každé ukázce máš záchrannou variantu (screenshot nebo hotový PR) pro případ, že selže připojení.
- [ ] V prohlížeči máš zvětšené písmo (Ctrl/Cmd +), ať je to vidět i vzadu.

---

## 1. Úvod (2 min)

1. Otevři hlavní stránku repozitáře.
2. Řekni:
   - GitHub není jen úložiště kódu, ale celý nástroj pro spolupráci.
   - Dnes se pracuje hlavně v prohlížeči. U rebase zazní, že plnohodnotný rebase se dělá v terminálu.
   - Publikum se naučí zadat práci (**issue**), vědět co nedávat do repa (**.gitignore**) a dostat změny dohromady (**rebase**, **konflikty**).
   - Větev `demo/base` hraje roli `main`.

---

## 2. Issues (6 min)

**Hlavní myšlenka:** Issue je místo, kde práce začíná. Je to úkol, bug nebo nápad s historií diskuse.

### Postup

1. Otevři záložku **Issues** a ukaž předem založenou špatnou issue.
   - Titulek: `Nefunguje to`, popis: `Spustil jsem to a nic.`
   - *Řekni:* „Co z toho pochopí ten, kdo to bude opravovat?“
2. Klikni na **New issue**. Ukaž, že GitHub nabízí šablony (ty jsou ve složce `.github/ISSUE_TEMPLATE`). U **Hlášení chyby** klikni na **Get started**.
3. Vyplň titulek `Pozdrav v app.py neobsahuje jméno uživatele` a vlož popis:

   ```markdown
   ## Co se děje
   Po spuštění `python src/app.py` se vypíše jen „Ahoj, světe!“, jméno uživatele se nikde nepoužije.

   ## Jak to zopakovat
   1. Naklonuj repozitář
   2. Spusť `python src/app.py`

   ## Co jsem čekal
   Pozdrav se jménem, např. „Ahoj, Jirko!“.

   ## Prostředí
   - Python 3.12, Windows 11

   ## Úkoly
   - [ ] Přidat parametr se jménem
   - [ ] Doplnit ukázku do README
   ```

   *Řekni:* Dobrý issue odpovídá na tři otázky: co se děje, jak to zopakovat, co čekám.
4. V pravém sloupci ukaž **Assignees** (přiřaď sebe), **Labels** (`bug`) a **Milestone** (jen ukaž, že existuje).
5. Klikni na **Submit new issue**.
6. Ukaž markdown checklist: v zobrazeném issue se `- [ ]` změní na zaškrtávací políčka a ukáže se průběh.
7. Přidej komentář, ve kterém napíšeš `@` (ukaž nabídku lidí) a `#1` (ukaž odkaz na jiné issue).
8. (Bonus) V pravém sloupci u **Development** je odkaz **Create a branch**, který založí větev rovnou svázanou s issue.
9. Ukaž soubor `.github/pull_request_template.md`. Obsahuje řádek `Closes #`.
   - *Řekni:* Když v popisu PR napíšeš `Closes #12`, po mergi se issue samo zavře.

### Pozor

- Klíčová slova (`Closes`, `Fixes`, `Resolves`) issue zavřou jen tehdy, když PR míří do **výchozí větve** repozitáře (tady `main`). Neotevírej PR z větví `demo/*` do `main` a nic takového nemerguj, rozbil bys `main`.
- Nejčastější chyba je vágní titulek. Proto začínáš špatným příkladem.

---

## 3. .gitignore (5 min)

**Hlavní myšlenka:** Některé soubory do repozitáře nepatří: hesla, závislosti, build výstupy, soubory editoru.

### Postup

1. V rozbalovací nabídce větví (vlevo nahoře) přepni na **`demo/gitignore`**.
2. Ukaž soubory v kořeni. Je tam `.env` a `debug.log`, ale chybí `.gitignore`.
3. Otevři `.env`. Je v něm `API_KEY=demo-neni-skutecny-klic`.
   - *Řekni:* „Představte si, že je to skutečný klíč.“
4. Klikni na **Add file → Create new file**. Do pole názvu napiš `.gitignore`. Vpravo nahoře se nabídne **Choose a .gitignore template**. Vyber **Python** a ukaž, co se vložilo. Pokud se šablona nenabídne, zkopíruj ji z repozitáře `github/gitignore`.
5. Klikni na **Commit changes…** a potvrď commit přímo do `demo/gitignore`.
6. Vysvětli syntaxi na `.gitignore` z větve `main`:

   | Zápis | Význam |
   |---|---|
   | `*.log` | všechny soubory s příponou `.log` |
   | `node_modules/` | celá složka |
   | `.env` | konkrétní soubor |
   | `!.env.example` | výjimka, soubor se naopak sleduje |
   | `# komentář` | řádek, který se ignoruje |

7. **Past:** vrať se na seznam souborů. `.env` a `debug.log` tam **pořád jsou**.
   - *Řekni:* `.gitignore` neovlivní soubory, které už git sleduje.
8. Otevři `.env`, klikni na tři tečky vpravo nahoře → **Delete file** → potvrď commit. Totéž udělej s `debug.log`.
   - *Řekni:* V terminálu to dělá `git rm --cached .env` (smaže soubor jen z gitu, na disku zůstane).
9. **Historie:** otevři záložku **Commits** a commit „Omylem commitnuté .env a debug.log“. Obsah `.env` je v něm pořád vidět.
   - *Řekni:* Pokud tam byl tajný klíč, musíš ho považovat za prozrazený a změnit ho. Zůstává v historii.
10. Ukaž repozitář `github/gitignore` s hotovými šablonami pro desítky jazyků a nástrojů.

### Proč

Bezpečnost (tajné klíče), velikost repa, čisté diffy. `.gitignore` se sám nezakládá a patří do repozitáře, aby ho měl celý tým.

---

## 4. Rebase (7 min)

**Hlavní myšlenka:** Rebase „přehraje“ tvé commity na novější základ, takže vznikne lineární historie bez zbytečných merge commitů.

### Postup

1. Otevři PR `demo/rebase-feature` → `demo/base`. GitHub hlásí, že větev je **out-of-date with the base branch**, a nabízí tlačítko **Update branch**.
2. Otevři záložku **Commits**. Jsou tam dva commity. Poznamenej si (nebo nech na obrazovce) prvních sedm znaků jejich SHA.
3. Vrať se na **Conversation**. Klikni na šipku u **Update branch**. Ukaž obě možnosti: **Update with merge commit** a **Update with rebase**.
4. Vyber **Update with rebase**.
5. Znovu otevři **Commits**. Commity mají **jiné SHA**, i když obsah je stejný.
   - *Řekni:* Změnil se jejich rodič, historie se přepsala. Proto se rebase nesmí dělat na sdílených větvích.
6. Rozbal šipku u tlačítka mergování a ukaž všechny tři možnosti vedle sebe:

   | Volba | Kdy ji použít |
   |---|---|
   | Create a merge commit | sdílené větve, chceš zachovat celou historii |
   | Squash and merge | čisté `main` z menších PR, z celé větve vznikne jeden commit |
   | Rebase and merge | chceš lineární historii se všemi commity |

7. Vyber **Rebase and merge** a potvrď.
8. Ukaž výsledek: historie commitů větve `demo/base` (nebo **Insights → Network**). Historie je rovná, bez merge commitu.
   - Tlačítko **Delete branch** nemačkej, zbytečně by ses připravil o ukázku.

### Řekni

- **Merge** zachová historii tak, jak se stala. **Rebase** ji přepíše do úhlednější podoby.
- Přirovnání: „Merge je jako sešít dvě knihy dohromady. Rebase je jako přepsat svoje kapitoly za novou verzi knihy.“
- **Zlaté pravidlo:** nikdy nedělej rebase na větvi, kterou už používají jiní lidé.

### Mimo prohlížeč (jen zmínit)

Klasický a interaktivní rebase (`git rebase -i`) a řešení konfliktů při něm se dělají v terminálu:

```
git switch demo/rebase-feature
git rebase demo/base
git push --force-with-lease
```

`--force-with-lease` je bezpečnější než `--force`: odmítne push, pokud mezitím někdo jiný do větve přidal commit.

---

## 5. Merge conflict (7 min)

**Hlavní myšlenka:** Konflikt není chyba. Je to git, který se ptá: „Obě strany změnily to samé, kterou verzi chceš?“

Obě větve mění **stejný řádek** v `src/greeting.py`:

| Větev | Řádek |
|---|---|
| původní stav | `GREETING = "Ahoj, světe!"` |
| `demo/conflict-a` | `GREETING = "Ahoj, GitHube!"` |
| `demo/conflict-b` | `GREETING = "Vítejte na GitHubu!"` |

### Postup

1. Otevři PR `demo/conflict-a` a zmerguj ho (**Merge pull request → Confirm merge**). Můžeš to udělat i předem.
2. Otevři PR `demo/conflict-b`. Pokud ještě konflikt nevidíš, chvíli počkej a obnov stránku. GitHub hlásí **This branch has conflicts that must be resolved** a jmenuje soubor `src/greeting.py`.
3. Klikni na **Resolve conflicts**. Otevře se webový editor.
4. Vysvětli značky:

   ```
   <<<<<<< demo/conflict-b
   GREETING = "Vítejte na GitHubu!"
   =======
   GREETING = "Ahoj, GitHube!"
   >>>>>>> demo/base
   ```

   - Mezi `<<<<<<<` a `=======` je verze z **tvé větve**.
   - Mezi `=======` a `>>>>>>>` je verze z **cílové větve**.
5. Vyřeš konflikt ručně: nech jednu verzi, nebo je spoj, například `GREETING = "Ahoj, GitHube! Vítejte na GitHubu!"`. Smaž všechny tři řádky se značkami.
6. Klikni na **Mark as resolved** a pak na **Commit merge**.
7. Vrať se na PR. Konflikt zmizel. Klikni na **Merge pull request**.
8. (Bonus) Otevři `src/greeting.py` na `demo/base` a ukaž výsledek, nebo spusť `python src/app.py`.

### Řekni

- Konflikt vzniká, když se dvě větve dotknou **stejného místa**. Změny na různých místech git spojí sám.
- Nejde o to „kdo vyhraje“. Je potřeba pochopit, co kdo chtěl, a případně se zeptat kolegy.
- Prevence: menší PR, častější aktualizace větve, domluva v týmu.
- Webový editor zvládne **textové** konflikty. U binárních souborů nebo některých případů (smazaný vs. upravený soubor, přejmenování) je potřeba terminál nebo lokální editor.

---

## 6. Shrnutí a otázky (3 min)

1. Otevři hlavní stránku repa a řekni jednu větu na každé téma:
   - **Issues:** kde práce začíná.
   - **.gitignore:** co do repozitáře nepatří.
   - **Rebase:** jak mít čistou historii.
   - **Konflikt:** jak spojit dvě změny dohromady.
2. Ukaž, co dál: repozitář `github/gitignore` a dokumentaci GitHubu (<https://docs.github.com>).
3. Zbytek času jsou otázky. Když se nikdo neptá, nabídni něco z toho, co se nevešlo: interaktivní rebase v terminálu, šablony issue nebo ochranu větví.

---

## Po prezentaci: reset dema

1. Zavři staré pull requesty.
2. Spusť `bash scripts/setup-demo.sh --push`. Demo větve se smažou a vytvoří znovu, `main` zůstane nedotčený.
3. Znovu otevři tři pull requesty z přípravy.

## Tipy

- Pokud se časově nevejdeš, nejdřív zkrať issues a nech si čas na konflikt, protože ten publikum zajímá nejvíc.
- Detaily rozhraní GitHubu (výběr šablony `.gitignore`, tlačítko „Update branch“) se občas mění. Projdi si celou ukázku jednou předem.
