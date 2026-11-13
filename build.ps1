# Baut alle CV-Varianten (und ggf. Anschreiben) und legt die fertigen PDFs in pdf/<variante>/ ab.
# Aufruf im Projektordner:  .\build.ps1
# Nur eine Variante:         .\build.ps1 lehrauftrag-fh

param([string[]]$Variants)

# Nicht 'Stop': MiKTeX schreibt harmlose Hinweise nach stderr, die PowerShell 5.1 sonst als Fehler wertet
$ErrorActionPreference = 'Continue'
$root = $PSScriptRoot

# Variante (Ordnername unter cv/) -> Dateiname des Lebenslaufs in pdf/<variante>/
# (ein anschreiben.tex erhaelt denselben Namen mit "Motivationsschreiben_" statt "Lebenslauf_")
$names = @{
    'allgemein'      = 'Lebenslauf_Andre_Kaderli.pdf'
    'lehrauftrag-fh' = 'Lebenslauf_Andre_Kaderli_Lehrauftrag_FH.pdf'
    'data-ai'        = 'Lebenslauf_Andre_Kaderli_Data_AI.pdf'
    'professur-fh'   = 'Lebenslauf_Andre_Kaderli_Professur_FH.pdf'
    'dozentur-quantum-zhaw' = 'Lebenslauf_Andre_Kaderli_Dozentur_Quantum_ZHAW.pdf'
}

# Dokumente pro Variante: .tex-Basisname -> Praefix fuer den PDF-Namen
$docs = [ordered]@{
    'lebenslauf'  = 'Lebenslauf_'
    'anschreiben' = 'Motivationsschreiben_'
}

if (-not $Variants) {
    $Variants = Get-ChildItem (Join-Path $root 'cv') -Directory | Select-Object -ExpandProperty Name
}

$failed = @()

foreach ($v in $Variants) {
    $dir = Join-Path $root "cv\$v"
    if (-not (Test-Path (Join-Path $dir 'lebenslauf.tex'))) { Write-Warning "Keine lebenslauf.tex in cv\$v"; continue }

    $out = Join-Path $dir 'build'
    New-Item -ItemType Directory -Force $out | Out-Null
    # PDFs landen in pdf\<variante>\ (gleiche Struktur wie cv\)
    $pdfDir = Join-Path $root "pdf\$v"
    New-Item -ItemType Directory -Force $pdfDir | Out-Null
    $cvName = if ($names.ContainsKey($v)) { $names[$v] } else { "Lebenslauf_Andre_Kaderli_$v.pdf" }

    foreach ($doc in $docs.Keys) {
        $tex = Join-Path $dir "$doc.tex"
        if (-not (Test-Path $tex)) { continue }

        Write-Host "Baue $v/$doc ..." -NoNewline
        # Zwei Durchlaeufe, damit die Gesamtseitenzahl in der Fusszeile stimmt
        $ok = $true
        foreach ($pass in 1..2) {
            & pdflatex -interaction=nonstopmode -halt-on-error -synctex=1 `
                "-include-directory=$root\class" "-output-directory=$out" $tex *> $null
            if ($LASTEXITCODE -ne 0) { $ok = $false; break }
        }

        if ($ok) {
            $target = $cvName -replace '^Lebenslauf_', $docs[$doc]
            Copy-Item (Join-Path $out "$doc.pdf") (Join-Path $pdfDir $target) -Force
            Write-Host " ok -> pdf\$v\$target" -ForegroundColor Green
        } else {
            Write-Host " FEHLER (siehe cv\$v\build\$doc.log)" -ForegroundColor Red
            $failed += "$v/$doc"
        }
    }
}

if ($failed) { exit 1 }
