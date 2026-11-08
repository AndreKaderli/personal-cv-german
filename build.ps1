# Baut alle CV-Varianten und legt die fertigen PDFs in pdf/ ab.
# Aufruf im Projektordner:  .\build.ps1
# Nur eine Variante:         .\build.ps1 lehrauftrag-fh

param([string[]]$Variants)

# Nicht 'Stop': MiKTeX schreibt harmlose Hinweise nach stderr, die PowerShell 5.1 sonst als Fehler wertet
$ErrorActionPreference = 'Continue'
$root = $PSScriptRoot

# Variante (Ordnername unter cv/) -> Dateiname in pdf/
$names = @{
    'allgemein'      = 'Lebenslauf_Andre_Kaderli.pdf'
    'lehrauftrag-fh' = 'Lebenslauf_Andre_Kaderli_Lehrauftrag_FH.pdf'
    'data-ai'        = 'Lebenslauf_Andre_Kaderli_Data_AI.pdf'
    'professur-fh'   = 'Lebenslauf_Andre_Kaderli_Professur_FH.pdf'
}

if (-not $Variants) {
    $Variants = Get-ChildItem (Join-Path $root 'cv') -Directory | Select-Object -ExpandProperty Name
}

New-Item -ItemType Directory -Force (Join-Path $root 'pdf') | Out-Null
$failed = @()

foreach ($v in $Variants) {
    $dir = Join-Path $root "cv\$v"
    $tex = Join-Path $dir 'lebenslauf.tex'
    if (-not (Test-Path $tex)) { Write-Warning "Keine lebenslauf.tex in cv\$v"; continue }

    $out = Join-Path $dir 'build'
    New-Item -ItemType Directory -Force $out | Out-Null

    Write-Host "Baue $v ..." -NoNewline
    # Zwei Durchlaeufe, damit die Gesamtseitenzahl in der Fusszeile stimmt
    $ok = $true
    foreach ($pass in 1..2) {
        & pdflatex -interaction=nonstopmode -halt-on-error -synctex=1 `
            "-include-directory=$root\class" "-output-directory=$out" $tex *> $null
        if ($LASTEXITCODE -ne 0) { $ok = $false; break }
    }

    if ($ok) {
        $target = if ($names.ContainsKey($v)) { $names[$v] } else { "Lebenslauf_Andre_Kaderli_$v.pdf" }
        Copy-Item (Join-Path $out 'lebenslauf.pdf') (Join-Path $root "pdf\$target") -Force
        Write-Host " ok -> pdf\$target" -ForegroundColor Green
    } else {
        Write-Host " FEHLER (siehe cv\$v\build\lebenslauf.log)" -ForegroundColor Red
        $failed += $v
    }
}

if ($failed) { exit 1 }
