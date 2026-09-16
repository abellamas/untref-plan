% =====================================================================
%  untref-plan.cls -- Plan de Investigacion, UNTREF Ingenieria de Sonido
%  Replica de "Formato Plan de investigacion Modelo Rev. 7.docx".
%
%  Todas las medidas salen del XML del .docx (twips/566.93 = cm,
%  w:sz/2 = pt, EMU/360000 = cm) y estan verificadas contra el PDF que
%  produce Word al abrir ese mismo .docx.
%
%  Compilar con LuaLaTeX (o XeLaTeX): usa fontspec para tomar las
%  fuentes reales de Windows.
% =====================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{untref-plan}[2026/08/28 Plan de Investigacion UNTREF Ing. de Sonido]
% Opcion apacite: bibliografia gestionada con un archivo .bib, segun la
% seccion 3 de la "Guia de estilo APA para citas y referencias" de la
% catedra (doc/guia_APA.pdf). Sin la opcion, las referencias se escriben a
% mano en el entorno {referencias}.
% La opcion [biblatex] usa biblatex-apa, que si implementa APA 7.
\newif\ifuntref@apacite
\newif\ifuntref@biblatex
\DeclareOption{apacite}{\untref@apacitetrue}
\DeclareOption{biblatex}{\untref@biblatextrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[12pt,a4paper]{article}   % Normal = 12 pt (w:sz 24)

\RequirePackage[spanish,es-noquoting,es-tabla]{babel}
\RequirePackage{graphicx}
\RequirePackage{amsmath}
\RequirePackage{titlesec}
\RequirePackage{enumitem}
\RequirePackage{caption}
\RequirePackage{array}
\RequirePackage{multirow}
\RequirePackage[table]{xcolor}
\RequirePackage{setspace}

% ---------------------------------------------------------------- pagina
% <w:pgSz w:h="16838" w:w="11906"/> = A4
% <w:pgMar top=1134 bottom=1134 left=1701 right=1134/> twips = 2/2/3/2 cm
\RequirePackage[a4paper,top=2cm,bottom=2cm,left=3cm,right=2cm]{geometry}
% el .docx no trae header1.xml ni footer1.xml: sin encabezado, pie ni folio
\pagestyle{empty}

% ---------------------------------------------------------------- fuentes
\RequirePackage{fontspec}
% CUERPO = Times New Roman. Ni los parrafos, ni el estilo Normal, ni
% docDefaults declaran <w:rFonts>, asi que Word cae a su fuente por
% defecto (Times New Roman) -- NO a la minorFont del tema (Calibri).
% Ligatures=TeX solo habilita los atajos de tipeo de LaTeX (-- da un guion
% medio, --- una raya, `` y '' dan comillas tipograficas). No altera la fuente.
\IfFontExistsTF{Times New Roman}
  {\setmainfont{Times New Roman}[Ligatures=TeX]}
  {\setmainfont{TeX Gyre Termes}[Ligatures=TeX]%
   \ClassWarning{untref-plan}{Times New Roman NO encontrada: se usa TeX Gyre
   Termes, que tiene las mismas metricas pero NO es la fuente pedida. En
   Windows deberia estar; si aparece este aviso, revisar la instalacion}}
% "las ecuaciones deben ser hechas en la misma fuente del texto": matematica
% con metricas de Times. Si no esta el paquete tex-gyre-math (MiKTeX:
% mpm --install=tex-gyre-math), cae a la matematica por defecto de LaTeX.
\IfFontExistsTF{texgyretermes-math.otf}
  {\RequirePackage{unicode-math}\setmathfont{texgyretermes-math.otf}}
  {\ClassWarning{untref-plan}{tex-gyre-math no encontrado: la matematica no
   coincidira con el texto. Instalar con: mpm --install=tex-gyre-math}}
% PORTADA = Calibri, la unica parte del .docx con <w:rFonts w:ascii="Calibri">
\IfFontExistsTF{Calibri}
  {\newfontfamily\portadafont{Calibri}[Ligatures=TeX]}
  {\newfontfamily\portadafont{Carlito}[Ligatures=TeX]}  % Carlito = metricas de Calibri

% ---------------------------------------------------------------- parrafo
% <w:ind w:firstLine="357"/> = 0.63 cm ; sin <w:spacing> => interlineado
% simple, 0 pt antes y despues
\setlength{\parindent}{0.63cm}
\setlength{\parskip}{0pt}

% ------------------------------------------- opciones para parecerse a Word
% El texto compone identico a Word en cuanto a fuente (Times New Roman 12 pt),
% pero el renglon se arma distinto. Si hace falta acercarlo mas, descomentar:
%
% (1) INTERLINEADO. Word con interlineado "simple" en Times 12 pt deja unos
%     13.8 pt entre lineas base; LaTeX en clase 12pt deja 14.5 pt.
% \setstretch{0.952}
%
% (2) SEPARACION EN SILABAS. Word, por defecto, NO corta palabras al final de
%     renglon; LaTeX si. Al desactivarla, los cortes de linea coinciden mas con
%     Word, pero el texto justificado queda con espacios entre palabras mas
%     grandes y pueden aparecer avisos de "Overfull hbox".
% \hyphenpenalty=10000
% \exhyphenpenalty=10000
% \setlength{\emergencystretch}{3em}

% ---------------------------------------------------------------- titulos
% numbering.xml abstractNum 2: "%1." y "%1.%2.", negrita, 14 pt (w:sz 28)
% nivel 1: <w:ind left=348 hanging=360> -> numero al margen, texto a 0.614 cm
% nivel 2: <w:ind left=780 hanging=432> -> numero a 0.614 cm, texto a 1.376 cm
\newcommand{\untrefheadfont}{\bfseries\fontsize{14pt}{17pt}\selectfont}
% Sangria francesa a la Word: el numero ocupa un ancho fijo; si no entra,
% se corre y deja un espacio minimo en vez de pegarse al titulo.
\newcommand{\untrefnum}[2]{%
  \settowidth{\@tempdima}{#2}%
  \ifdim\@tempdima<#1\relax\makebox[#1][l]{#2}\else#2\hspace{0.25em}\fi}
\titleformat{\section}[hang]{\untrefheadfont}%
  {\untrefnum{0.614cm}{\thesection.}}{0pt}{}
\titleformat{\subsection}[hang]{\untrefheadfont}%
  {\hspace*{0.614cm}\untrefnum{0.762cm}{\thesubsection.}}{0pt}{}
% ponytail: el .docx separa titulos con parrafos vacios de 14 pt; aca es el
% \titlespacing equivalente. Tocar estos dos valores si el ojo pide mas aire.
\titlespacing*{\section}{0pt}{17pt}{17pt}
\titlespacing*{\subsection}{0pt}{17pt}{17pt}
\setcounter{secnumdepth}{2}

% ---------------------------------------------------------------- listas
% numbering.xml abstractNum 1 lvl0: vineta U+25CF, <w:ind left=714 hanging=357>
\setlist[itemize,1]{label=\raisebox{0.1ex}{\footnotesize\char"25CF},
                    leftmargin=1.259cm, labelwidth=0.629cm, labelsep=0pt,
                    align=left, topsep=0pt, partopsep=0pt, parsep=0pt, itemsep=0pt}

% ---------------------------------------------------------------- figuras
% <w:jc center>, negrita + cursiva, w:sz 21 = 10.5 pt, <w:spacing after=200> = 10 pt
% El .docx cierra el epigrafe con punto: "Figura 1. ... al pie."
\DeclareCaptionFont{untrefcap}{\fontsize{10.5pt}{12.6pt}\selectfont}
\captionsetup{labelsep=period, justification=centering, singlelinecheck=false,
              font={untrefcap,bf,it}, labelfont={bf,it}, textfont={bf,it},
              aboveskip=6pt, belowskip=10pt}
% titulo AL PIE: poner \caption despues del \includegraphics

% ---------------------------------------------------------------- ecuaciones
% "centradas, numeradas en secuencia, numero a la derecha entre parentesis,
%  numeracion arabiga; formulas y texto separados por una linea"
\g@addto@macro\normalsize{%
  \setlength{\abovedisplayskip}{12pt}\setlength{\belowdisplayskip}{12pt}%
  \setlength{\abovedisplayshortskip}{12pt}\setlength{\belowdisplayshortskip}{12pt}}

% ---------------------------------------------------------------- Gantt
% tabla 2: 10 filas (2 de encabezado + 8 de actividades), 17 columnas,
% bordes simples de 0.5 pt (w:sz 4), celdas marcadas con relleno d9d9d9.
% Word mide el ancho de celda incluyendo el margen interno; LaTeX suma
% \tabcolsep aparte, por eso el p{} va con (ancho Word - 0.141 cm).
\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}}
\definecolor{ganttfill}{HTML}{D9D9D9}
\newcommand{\gX}{\cellcolor{ganttfill}X}          % semana marcada
\newcommand{\ganttfont}{\fontsize{9pt}{11pt}\selectfont}   % w:sz 18 = 9 pt
\newenvironment{gantt}
  {\setlength{\tabcolsep}{2pt}\renewcommand{\arraystretch}{1.5}\ganttfont
   \noindent\begin{tabular}{|p{4.42cm}|*{16}{C{0.558cm}|}}\hline
   \multirow{2}{4.42cm}{\centering Actividad /Semana}
   & & & & & & & & & & & & & & & & \tabularnewline\cline{2-17}
   & 1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 & 10 & 11 & 12 & 13 & 14 & 15 & 16
   \tabularnewline\hline}
  {\end{tabular}}

% ---------------------------------------------------------------- referencias
% <w:ind w:left="426" w:hanging="426"/> = sangria francesa de 0.75 cm,
% justificado, 12 pt, sin espacio extra entre entradas.
\newenvironment{referencias}
  {\section{Referencias.}\par
   \setlength{\parindent}{-0.751cm}\setlength{\leftskip}{0.751cm}}
  {\par}

% Con la opcion [apacite]: \referenciasbib{archivo} inserta la lista generada
% desde archivo.bib con el estilo apacite, respetando la misma sangria
% francesa de 0.75 cm y sin espacio extra entre entradas.
% Citas: \citeA{clave} para narrativas, \cite{clave} para parenteticas.
\ifuntref@apacite
  \RequirePackage[numberedbib]{apacite}
  \setlength{\bibleftmargin}{0.751cm}
  \setlength{\bibindent}{-0.751cm}
  \setlength{\bibitemsep}{0pt}
  % babel y apacite fijan sus cadenas en \begin{document}, asi que las
  % redefiniciones van despues: el titulo con punto, como en el modelo, y
  % "et al." en lugar del "y cols." que apacite usa en espanol (la guia de la
  % catedra pide "et al.", seccion 1).
  \AtBeginDocument{%
    \renewcommand{\refname}{Referencias.}%
    \renewcommand{\bibname}{Referencias.}%
    \renewcommand{\BOthers}[1]{et al.\hbox{}}%
    \renewcommand{\BOthersPeriod}[1]{et al.\hbox{}}}
  \newcommand{\referenciasbib}[1]{\bibliographystyle{apacite}\bibliography{#1}}
  % Limitaciones conocidas de apacite frente a la guia de la catedra:
  %  - apacite implementa APA 6: con tres o mas autores lista todos en la
  %    primera cita narrativa, mientras APA 7 pide "et al." desde la primera
  %    mencion. \shortcites no lo corrige. Esas citas hay que escribirlas a
  %    mano o usar el entorno {referencias}.
  %  - con babel espanol inserta coma antes de la "y" final de la cita
  %    narrativa ("Aletta, Oberman, y Kang").
\fi

% Con la opcion [biblatex]: biblatex-apa, que implementa APA 7 (et al. desde la
% primera cita, "&" en la lista, tesis entre corchetes). Requiere biber.
%   preambulo:  \bibliografia{referencias}      % lee referencias.bib
%   cuerpo:     \referenciasbib
%   citas:      \textcite{clave} narrativa, \parencite{clave} parentetica
%   compilar:   lualatex -> biber -> lualatex -> lualatex
% En el .bib, el campo doi va sin la URL: doi = {10.3390/ijerph15112392}.
\ifuntref@biblatex
  \RequirePackage[style=apa,backend=biber]{biblatex}
  \DeclareLanguageMapping{spanish}{spanish-apa}
  \setlength{\bibhang}{0.751cm}      % misma sangria francesa que el modelo
  \setlength{\bibitemsep}{0pt}       % sin espacio extra entre entradas
  % biblatex deja glue elastico entre los caracteres de una URL, y al justificar
  % el DOI aparece con espacios ("https : / / doi . org"). Esto lo elimina.
  \appto{\biburlsetup}{\Urlmuskip=0mu\relax}
  \newcommand{\bibliografia}[1]{\addbibresource{#1.bib}}
  \newcommand{\referenciasbib}{\section{Referencias.}\printbibliography[heading=none]}
\fi

% ---------------------------------------------------------------- portada
\newcommand{\carrera}[1]{\def\untref@carrera{#1}}
\newcommand{\subtitulo}[1]{\def\untref@subtitulo{#1}}
\newcommand{\tutor}[1]{\def\untref@tutor{#1}}
\newcommand{\cotutor}[1]{\def\untref@cotutor{#1}}
\newcommand{\defensa}[1]{\def\untref@defensa{#1}}
\newcommand{\investigador}[1]{\def\untref@investigador{#1}}
\carrera{INGENIER\'IA DE SONIDO}
\subtitulo{}\cotutor{}\investigador{}

% Tabla de maquetado del encabezado (tabla 1 del .docx): 1 fila x 2 columnas
% de 2149 y 8200 twips, bordes visibles, sangrada -743 twips hacia el margen
% izquierdo. El logo tapa los bordes internos porque tiene fondo blanco.
% ponytail: comentar esta macro y dejar solo el \includegraphics si el marco molesta.
\newcommand{\untref@encabezado}{%
  \hspace*{-1.31cm}%
  \setlength{\tabcolsep}{0pt}%
  \begin{tabular}{|p{3.79cm}|p{14.46cm}|}\hline
    \rule{0pt}{3.11cm} & \includegraphics[width=13.58cm,height=3.11cm]{figuras/logo-untref.png}\tabularnewline\hline
  \end{tabular}}

\renewcommand{\maketitle}{%
  \begin{titlepage}
  \centering\portadafont
  \vspace*{34pt}%                         [0][1] parrafos vacios de 14 pt
  \untref@encabezado\par
  {\fontsize{16pt}{19.5pt}\selectfont\untref@carrera\par}
  \vspace{66pt}%                          [5][6][7] vacios de 18 pt
  {\bfseries\fontsize{22pt}{26.8pt}\selectfont\@title\par}
  \vspace{26.8pt}%                        [9] vacio de 22 pt
  {\fontsize{18pt}{22pt}\selectfont\untref@subtitulo\par}
  \vspace{139.2pt}%                       [11]-[18] vacios
  {\bfseries\fontsize{14pt}{17.1pt}\selectfont\setstretch{2.0}%  w:line=480 = doble
   Autor: \@author\par
   TUTOR/A: \untref@tutor\par
   \ifx\untref@cotutor\empty\else COTUTOR/A: \untref@cotutor\par\fi}
  \vfill
  % grupo de dos lineas de 15.75 cm que encierra la fecha (wpg de 5669280 EMU)
  \rule{15.75cm}{0.5pt}\par\vspace{3pt}
  {\fontsize{14pt}{17.1pt}\selectfont\untref@defensa\par}
  \vspace{3pt}\rule{15.75cm}{0.5pt}\par
  \vspace*{28pt}
  \end{titlepage}
  % parrafos [36] y [37]: ya sin <w:rFonts>, es decir Times como el cuerpo
  {\centering
   {\bfseries\fontsize{14pt}{17pt}\selectfont\@title\par}
   {\bfseries\fontsize{12pt}{14.5pt}\selectfont\untref@investigador\par}\par}
  \vspace{17pt}}
