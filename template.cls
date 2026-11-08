\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{template}[2026/11/08 Modern single-column CV class]

% ---------------------------------------------------------------
% Basis
% ---------------------------------------------------------------
\LoadClass[10pt,a4paper]{article}
\RequirePackage[a4paper,left=17mm,right=17mm,top=14mm,bottom=14mm]{geometry}

\RequirePackage[T1]{fontenc}
\RequirePackage{titlesec}
\RequirePackage{enumitem}
\RequirePackage{xcolor}
\RequirePackage{microtype}   % fuer \textls (Sperrschrift der Abschnittstitel)

% ---------------------------------------------------------------
% Schrift: serifenlos (Helvetica). Fuer Inter stattdessen die zwei
% Zeilen darunter aktivieren (Paket "inter" muss installiert sein).
% ---------------------------------------------------------------
\RequirePackage[scaled=0.96]{helvet}
\renewcommand{\familydefault}{\sfdefault}
%\RequirePackage[sfdefault]{inter}

% Etwas kleinere Grundschrift (ca. 9.2 pt) und lockerer Zeilenabstand
\renewcommand{\normalsize}{\fontsize{9.2}{12.8}\selectfont}
\renewcommand{\small}{\fontsize{8.4}{11.4}\selectfont}
\renewcommand{\large}{\fontsize{9.8}{13}\selectfont}
\normalsize
\setlength{\parindent}{0pt}
\setlength{\parskip}{0pt}
\pagestyle{empty}

% ---------------------------------------------------------------
% Farben
% ---------------------------------------------------------------
\definecolor{myblue}{HTML}{1F4E79}     % Akzentfarbe
\definecolor{mytext}{HTML}{1C2733}     % Haupttext
\definecolor{mymuted}{HTML}{5B6B7A}    % Datum, Kontaktzeile
\definecolor{myrule}{HTML}{C9D3DC}     % feine Linie
\AtBeginDocument{\color{mytext}}

% ---------------------------------------------------------------
% Listen
% ---------------------------------------------------------------
\setlist[itemize]{leftmargin=4mm,labelsep=1.6mm,itemsep=0.6mm,topsep=0.8mm,parsep=0pt,partopsep=0pt,
  label={\color{myblue}\raisebox{0.05ex}{\footnotesize\textbullet}}}

% ---------------------------------------------------------------
% Gliederung
%   section       : Abschnittstitel (Grossbuchstaben, gesperrt, blaue Linie)
%   subsection    : Organisation / Titel (fett, Haupttextfarbe)
%   subsubsection : Position (halbfett, blau), Datum rechts in Grau
% ---------------------------------------------------------------
\titleformat{\section}
  {\color{myblue}\footnotesize\bfseries\raggedright}
  {}{0em}{}
  [{\color{myblue}\titlerule[0.9pt]}]
\titlespacing*{\section}{0pt}{4.6mm}{1.8mm}

\titleformat{\subsection}
  {\color{mytext}\large\bfseries\raggedright}
  {}{0em}{}
\titlespacing*{\subsection}{0pt}{2.8mm}{0.7mm}

\titleformat{\subsubsection}
  {\color{myblue}\normalsize\bfseries\raggedright}
  {}{0em}{}
\titlespacing*{\subsubsection}{0pt}{1.8mm}{0.3mm}

% Datum (rechts, grau, nicht fett)
\newcommand{\cvdate}[1]{{\normalfont\small\color{mymuted}#1}}

% Abschnitt: Titel in gesperrten Grossbuchstaben (Datum optional)
\newcommand{\datedsection}[2]{%
  \section[#1]{\textls[110]{\MakeUppercase{#1}}\hfill\cvdate{#2}}%
}
% Organisation / Eintrag mit optionalem Datum
\newcommand{\datedsubsection}[2]{%
  \subsection[#1]{#1\hfill\cvdate{#2}}%
}
% Position mit Datum
\newcommand{\datedsubsubsection}[2]{%
  \subsubsection[#1]{#1\hfill\cvdate{#2}}%
}

% Eintrag "Label: Text" (Kenntnisse, Zertifizierungen, Weitere Angaben)
\newcommand{\kv}[2]{\par\noindent{\bfseries\color{myblue}#1}\ #2\par\vspace{1.5mm}}

% ---------------------------------------------------------------
% Kopf: Name, Leitzeile, Kontaktzeile
% ---------------------------------------------------------------
\newcommand{\name}[1]{%
  \noindent{\fontsize{25}{28}\selectfont\bfseries\color{myblue}#1}\par\vspace{2.6mm}}

\newcommand{\tagline}[1]{%
  \noindent{\color{myblue}\vrule width 2.5pt}\hspace{3mm}%
  \begin{minipage}[t]{\dimexpr\linewidth-5.6mm\relax}
    \fontsize{9.6}{13.4}\selectfont\mdseries #1
  \end{minipage}\par\vspace{3mm}}

\newenvironment{contactline}
  {\noindent\small\color{mymuted}}
  {\par\vspace{1.2mm}{\color{myrule}\hrule height 0.5pt}\vspace{1mm}}

% Trenner in der Kontaktzeile
\newcommand{\sep}{\hspace{1.8mm}{\color{myblue!50}\textperiodcentered}\hspace{1.8mm}}
