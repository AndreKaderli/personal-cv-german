# personal-cv-german

Deutschsprachige Lebensläufe von Dr. André Kaderli in mehreren Varianten, alle im selben Design (LaTeX, pdfLaTeX/MiKTeX).

## Varianten

| Ordner | Zweck | Seiten | Fertiges PDF |
|---|---|---|---|
| `cv/allgemein/` | Allgemeiner Lebenslauf | 2 | `pdf/Lebenslauf_Andre_Kaderli.pdf` |
| `cv/lehrauftrag-fh/` | Anfrage für ein Lehrmandat an einer Fachhochschule | 2 | `pdf/Lebenslauf_Andre_Kaderli_Lehrauftrag_FH.pdf` |
| `cv/data-ai/` | Bewerbung für Data-/AI-Rollen (Principal/Lead) | 2 | `pdf/Lebenslauf_Andre_Kaderli_Data_AI.pdf` |
| `cv/professur-fh/` | Bewerbung für eine FH-Professur in angewandter Mathematik (Entwurf) | 3 | `pdf/Lebenslauf_Andre_Kaderli_Professur_FH.pdf` |

Rote, fette Angaben in `[eckigen Klammern]` sind Platzhalter (`\tbd{...}`). Sie müssen vor dem Versand ausgefüllt oder entfernt werden.

## Struktur

```
class/cv.cls              gemeinsames Design (Schrift, Farben, Abschnitte, Fusszeile)
cv/<variante>/            eine Variante pro Ordner (Platz für z. B. anschreiben.tex)
  lebenslauf.tex          Inhalt
  build/                  Build-Artefakte (von git ignoriert)
pdf/                      fertige PDFs zum Versenden
build.ps1                 baut alle Varianten und kopiert die PDFs nach pdf/
```

## Bauen

- **VS Code (LaTeX Workshop):** eine `lebenslauf.tex` öffnen und speichern. Die PDF entsteht in `build/` neben der Datei und öffnet sich mit `Ctrl+Alt+V`.
- **Alle Varianten:** im Projektordner `.\build.ps1` ausführen. Für einzelne Varianten den Ordnernamen angeben, z. B. `.\build.ps1 lehrauftrag-fh`.
- **Manuell:** `pdflatex -include-directory=<Projektordner>\class -output-directory=build lebenslauf.tex` im Ordner der Variante, **zweimal** ausführen (für die Gesamtseitenzahl in der Fusszeile).

Neue Variante: Ordner unter `cv/` mit einer `lebenslauf.tex` anlegen (`\documentclass{cv}`). Optional den Dateinamen für `pdf/` in `build.ps1` eintragen.
