\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cv}[2026/11/08 Modern single-column CV class]

% ---------------------------------------------------------------
% Basis
% ---------------------------------------------------------------
\LoadClass[10pt,a4paper]{article}
\RequirePackage[a4paper,left=19mm,right=19mm,top=16mm,bottom=18mm,footskip=8mm]{geometry}

\RequirePackage[T1]{fontenc}
\RequirePackage{titlesec}
\RequirePackage{enumitem}
\RequirePackage{xcolor}
\RequirePackage{microtype}   % Feinsatz + \textls (Sperrschrift der Abschnittstitel)
\RequirePackage{ragged2e}    % Flattersatz mit massvoller Silbentrennung

% ---------------------------------------------------------------
% Schrift: Source Sans Pro (modern, gut lesbar, mit Semibold).
% lmodern liefert skalierbare Ersatzschriften (noetig fuer microtype).
% ---------------------------------------------------------------
\RequirePackage{lmodern}
\RequirePackage[default,semibold,lining]{sourcesanspro}
\pdfmapfile{=SourceSansThree.map}  % Font-Map direkt laden (MiKTeX aktiviert sie nicht immer)

% Grundschrift ca. 9.8 pt mit grosszuegigem Zeilenabstand
\renewcommand{\normalsize}{\fontsize{9.8}{13.6}\selectfont}
\renewcommand{\small}{\fontsize{8.9}{12}\selectfont}
\renewcommand{\footnotesize}{\fontsize{8.4}{11}\selectfont}
\renewcommand{\large}{\fontsize{11}{14}\selectfont}
\normalsize
\setlength{\parindent}{0pt}
\setlength{\parskip}{0pt}

% Fusszeile: Name, Dokument, Seitenzahl (dezent grau, zentriert)
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\fancypagestyle{cv}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}%
  \fancyfoot[C]{\footnotesize\color{mymuted}Dr.~André Kaderli\enspace\textperiodcentered\enspace Lebenslauf\enspace\textperiodcentered\enspace Seite \thepage/\pageref*{LastPage}}%
}
\pagestyle{cv}

% Flattersatz statt Blocksatz: keine Luecken zwischen Woertern, wenig Trennungen
\AtBeginDocument{\RaggedRight}
\setlength{\RaggedRightRightskip}{0pt plus 4em}
\hyphenpenalty=2000
\exhyphenpenalty=2000
\clubpenalty=10000
\widowpenalty=10000

% ---------------------------------------------------------------
% Farben
% ---------------------------------------------------------------
\definecolor{myblue}{HTML}{1A4D7C}     % Akzentfarbe
\definecolor{mytext}{HTML}{222B36}     % Haupttext
\definecolor{mymuted}{HTML}{66768A}    % Datum, Kontaktzeile
\definecolor{myrule}{HTML}{D3DCE5}     % feine Linie
\AtBeginDocument{\color{mytext}}

% ---------------------------------------------------------------
% Listen
% ---------------------------------------------------------------
\setlist[itemize]{leftmargin=4.2mm,labelsep=2mm,itemsep=0.9mm,topsep=1mm,parsep=0pt,partopsep=0pt,
  label={\color{myblue}\raisebox{0.1ex}{\small\textbullet}}}

% ---------------------------------------------------------------
% Gliederung
%   section       : Abschnittstitel (Grossbuchstaben, gesperrt, Linie)
%   subsection    : Organisation / Titel (fett, Haupttextfarbe)
%   subsubsection : Position (halbfett, blau), Datum rechts in Grau
% ---------------------------------------------------------------
\titleformat{\section}
  {\color{myblue}\fontsize{9.4}{12}\selectfont\bfseries\raggedright}
  {}{0em}{}
  [\nobreak\vspace{-0.6mm}\nobreak{\color{myblue}\titlerule[0.7pt]}\nobreak]
\titlespacing*{\section}{0pt}{6.5mm}{2.6mm}

\titleformat{\subsection}
  {\color{mytext}\large\bfseries\raggedright}
  {}{0em}{}
\titlespacing*{\subsection}{0pt}{3.6mm}{0.8mm}

\titleformat{\subsubsection}
  {\color{myblue}\normalsize\fontseries{sb}\selectfont\raggedright}
  {}{0em}{}
\titlespacing*{\subsubsection}{0pt}{2.4mm}{0.4mm}

% Datum (rechts, grau, nicht fett, tabellarische Ziffern)
\newcommand{\cvdate}[1]{{\normalfont\small\color{mymuted}#1}}

% Abschnitt: Titel in gesperrten Grossbuchstaben (Datum optional)
\newcommand{\datedsection}[2]{%
  \section[#1]{\textls[140]{\MakeUppercase{#1}}\hfill\cvdate{#2}}%
}
% Organisation / Eintrag mit optionalem Datum
\newcommand{\datedsubsection}[2]{%
  \subsection[#1]{#1\hfill\cvdate{#2}}%
}
% Position mit Datum
\newcommand{\datedsubsubsection}[2]{%
  \subsubsection[#1]{#1\hfill\cvdate{#2}}%
}

% Platzhalter (rot, fett) fuer noch zu ergaenzende Angaben
\newcommand{\tbd}[1]{{\color{red}\bfseries[#1]}}

% Beschreibungszeile ohne Bullet (fuer Eintraege mit nur einer Aussage)
\newcommand{\desc}[1]{\par\addvspace{0.8mm}{\color{mytext!88}#1}\par}

% Eintrag "Label: Text" (Kenntnisse, Zertifizierungen, Weitere Angaben)
% (\addvspace verschmilzt mit dem Abstand unter dem Abschnittstitel -> keine Doppel-Abstaende)
\newcommand{\kv}[2]{\par\addvspace{2.2mm}\noindent{\fontseries{sb}\selectfont\color{myblue}#1}\ #2\par}

% ---------------------------------------------------------------
% Kopf: Name, Leitzeile, Kontaktzeile
% ---------------------------------------------------------------
\newcommand{\name}[1]{%
  \noindent{\fontsize{27}{31}\selectfont\bfseries\color{myblue}#1}\par\vspace{3.2mm}}

\newcommand{\tagline}[1]{%
  \noindent{\color{myblue}\vrule width 2.2pt}\hspace{3mm}%
  \begin{minipage}[t]{\dimexpr\linewidth-5.2mm\relax}
    \RaggedRight\fontsize{10}{13.8}\selectfont\color{mytext!80} #1
  \end{minipage}\par\vspace{3.6mm}}

\newenvironment{contactline}
  {\noindent\small\color{mymuted}}
  {\par\vspace{2mm}{\color{myrule}\hrule height 0.5pt}\vspace{0.5mm}}

% Trenner in der Kontaktzeile
\newcommand{\sep}{\hspace{2.2mm}{\color{myblue!45}\textbar}\hspace{2.2mm}}
