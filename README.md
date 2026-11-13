# personal-cv-german

Deutschsprachige Lebensläufe von Dr. André Kaderli in mehreren Varianten, alle im selben Design (LaTeX, pdfLaTeX/MiKTeX).

## Varianten

| Ordner | Zweck | Seiten | Fertiges PDF |
|---|---|---|---|
| `cv/allgemein/` | Allgemeiner Lebenslauf | 2 | `pdf/allgemein/Lebenslauf_Andre_Kaderli.pdf` |
| `cv/lehrauftrag-fh/` | Anfrage für ein Lehrmandat an einer Fachhochschule | 2 | `pdf/lehrauftrag-fh/Lebenslauf_Andre_Kaderli_Lehrauftrag_FH.pdf` |
| `cv/data-ai/` | Bewerbung für Data-/AI-Rollen (Principal/Lead) | 2 | `pdf/data-ai/Lebenslauf_Andre_Kaderli_Data_AI.pdf` |
| `cv/professur-fh/` | Bewerbung für eine FH-Professur in angewandter Mathematik (Entwurf) | 3 | `pdf/professur-fh/Lebenslauf_Andre_Kaderli_Professur_FH.pdf` |
| `cv/dozentur-quantum-zhaw/` | Bewerbung für die Dozentur Quantencomputing/QML am IAMP der ZHAW (Entwurf) | 2 + 1 | `pdf/dozentur-quantum-zhaw/Lebenslauf_Andre_Kaderli_Dozentur_Quantum_ZHAW.pdf`, `pdf/dozentur-quantum-zhaw/Motivationsschreiben_Andre_Kaderli_Dozentur_Quantum_ZHAW.pdf` |

Rote, fette Angaben in `[eckigen Klammern]` sind Platzhalter (`\tbd{...}`). Sie müssen vor dem Versand ausgefüllt oder entfernt werden.

## Struktur

```
class/cv.cls              gemeinsames Design (Schrift, Farben, Abschnitte, Fusszeile)
cv/<variante>/            eine Variante pro Ordner
  lebenslauf.tex          Inhalt
  anschreiben.tex         optional: Motivationsschreiben im gleichen Design (wird mitgebaut)
  build/                  Build-Artefakte (von git ignoriert)
pdf/<variante>/           fertige PDFs zum Versenden (gleiche Ordner wie cv/)
build.ps1                 baut alle Varianten und kopiert die PDFs nach pdf/<variante>/
```

## Bauen

- **VS Code (LaTeX Workshop):** eine `lebenslauf.tex` öffnen und speichern. Die PDF entsteht in `build/` neben der Datei und öffnet sich mit `Ctrl+Alt+V`.
- **Alle Varianten:** im Projektordner `.\build.ps1` ausführen. Für einzelne Varianten den Ordnernamen angeben, z. B. `.\build.ps1 lehrauftrag-fh`.
- **Manuell:** `pdflatex -include-directory=<Projektordner>\class -output-directory=build lebenslauf.tex` im Ordner der Variante, **zweimal** ausführen (für die Gesamtseitenzahl in der Fusszeile).

Neue Variante: Ordner unter `cv/` mit einer `lebenslauf.tex` anlegen (`\documentclass{cv}`). Optional den Dateinamen für `pdf/<variante>/` in `build.ps1` eintragen.

Anschreiben: `anschreiben.tex` in den Ordner der Variante legen (Vorlage: `cv/dozentur-quantum-zhaw/anschreiben.tex`). Die Brief-Makros `\recipient`, `\placedate`, `\lettersubject`, `letterbody`, `\closing` und `\enclosures` kommen aus `class/cv.cls`. Mit `\renewcommand{\doclabel}{...}` wird die Fusszeile angepasst. Das PDF heisst wie der Lebenslauf, nur mit `Motivationsschreiben_` statt `Lebenslauf_`.
