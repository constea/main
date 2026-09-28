% petrovsky «Сетка» — класс учебных документов (pdfLaTeX, A4).
% \documentclass[dz]{petrovsky}
% Типы: konspekt, dz, kr, metod, list, tetrad, bilety, otvety
% Опции: grid (клетка 5 мм на фоне), ptmath (буквы формул из PT Serif; по умолчанию Computer Modern, как KaTeX)
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{petrovsky}[2026/09/28 petrovsky documents]

\def\pv@type{Конспект лекции}
\newif\ifpv@grid \pv@gridfalse
\def\pv@tokopts{}
\DeclareOption{konspekt}{\def\pv@type{Конспект лекции}}
\DeclareOption{dz}{\def\pv@type{Домашнее задание}}
\DeclareOption{kr}{\def\pv@type{Контрольная работа}}
\DeclareOption{metod}{\def\pv@type{Методическое пособие}}
\DeclareOption{list}{\def\pv@type{Раздаточный лист}}
\DeclareOption{tetrad}{\def\pv@type{Рабочая тетрадь}\pv@gridtrue}
\DeclareOption{bilety}{\def\pv@type{Экзаменационные билеты}}
\DeclareOption{otvety}{\def\pv@type{Ответы и решения}}
\DeclareOption{grid}{\pv@gridtrue}
\DeclareOption{ptmath}{\def\pv@tokopts{ptmath}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass[a4paper]{article}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T2A]{fontenc}
\RequirePackage[russian]{babel}
\RequirePackage[\pv@tokopts]{petrovsky-tokens}
\RequirePackage[a4paper,left=40mm,textwidth=150mm,top=25mm,bottom=25mm,
  headheight=5mm,headsep=10mm,footskip=10mm]{geometry}
\RequirePackage{eso-pic,tikz,fancyhdr,titlesec,enumitem,booktabs,needspace}

% --- строка = 5 мм ---
\renewcommand\normalsize{\@setfontsize\normalsize{10pt}{5mm}%
  \abovedisplayskip 2.5mm plus 1mm \belowdisplayskip 2.5mm plus 1mm
  \abovedisplayshortskip 1.25mm \belowdisplayshortskip 1.25mm}
\renewcommand\small{\@setfontsize\small{8.5pt}{3.75mm}}
\renewcommand\footnotesize{\@setfontsize\footnotesize{7.5pt}{3.75mm}}
\normalsize
\setlength\parindent{0pt}
\setlength\parskip{2.5mm plus 0.5mm}
\raggedright
\raggedbottom
\color{pv-text}

\ifpv@grid\AddToShipoutPictureBG{\AtPageLowerLeft{\begin{tikzpicture}[x=1mm,y=1mm]
  \draw[pv-grid,line width=0.25pt,step=5] (0,0) grid (210,297);\end{tikzpicture}}}\fi

% --- метаданные ---
\def\pv@course{Математика}\def\pv@group{}\def\pv@num{}\def\pv@deadline{}\def\pv@variant{}
\newcommand\course[1]{\def\pv@course{#1}}
\newcommand\group[1]{\def\pv@group{#1}}
\newcommand\docnumber[1]{\def\pv@num{#1}}
\newcommand\deadline[1]{\def\pv@deadline{#1}}
\newcommand\doctype[1]{\def\pv@type{#1}}

% --- колонтитулы: знак слева в колонке индексов, курс справа, номер страницы в колонке ---
\fancypagestyle{pv}{\fancyhf{}%
  \fancyhead[L]{\llap{\makebox[\pvindexwidth][l]{\pvmonogram}\hspace{\pvindexsep}}\color{pv-muted}\pvlabel{\pv@course\ifx\pv@group\@empty\else\quad\pv@group\fi}}%
  \fancyhead[R]{\color{pv-muted}\pvlabel{\pv@type\ifx\pv@num\@empty\else\ \pv@num\fi}}%
  \fancyfoot[L]{\llap{\makebox[\pvindexwidth][l]{\color{pv-muted}\pvmetafont\thepage}\hspace{\pvindexsep}}}%
  \renewcommand\headrulewidth{0pt}}
\fancypagestyle{pvfirst}{\fancyhf{}%
  \fancyhead[L]{\llap{\makebox[\pvindexwidth][l]{\pvwordmark}\hspace{\pvindexsep}}}%
  \fancyfoot[L]{\llap{\makebox[\pvindexwidth][l]{\color{pv-muted}\pvmetafont\thepage}\hspace{\pvindexsep}}}%
  \renewcommand\headrulewidth{0pt}}
\pagestyle{pv}

% --- титул: чёрная линейка, метки, крупный номер в колонке, название ---
\renewcommand\maketitle{\thispagestyle{pvfirst}%
  \pvindex{\color{pv-muted}\pvlabel{\pv@group}}%
  \textcolor{pv-strong}{\rule[3.2mm]{\linewidth}{\pvstrong}}\par\vspace{-7.5mm}%
  \pvindex{}{\color{pv-muted}\pvlabel{\pv@type\ifx\pv@variant\@empty\else, вариант~\pv@variant\fi}%
    \hfill\ifx\pv@deadline\@empty\else\pvlabel{до~\pv@deadline}\fi}\par\vspace{5mm}%
  \pvindex{\ifx\pv@num\@empty\else{\bfseries\fontsize{30pt}{10mm}\selectfont\textls[-40]{\two@digits{\pv@num}}}\fi}%
  {\bfseries\fontsize{20pt}{10mm}\selectfont\textls[-20]{\@title}\par}%
  \vspace{7.5mm}}

\newcommand\namefield{\pvindex{\color{pv-muted}\pvlabel{Студент}}%
  \rule[-1mm]{95mm}{\pvhair}\hspace{5mm}{\color{pv-muted}\pvlabel{Группа}}\ \rule[-1mm]{30mm}{\pvhair}\par\vspace{2.5mm}}

% --- разделы: номер в колонке, чёрная линейка сверху ---
\titleformat{\section}{\bfseries\fontsize{14pt}{7.5mm}\selectfont}
  {\llap{\makebox[\pvindexwidth][l]{\textcolor{pv-accent}{\two@digits{\thesection}}}\hspace{\pvindexsep}}}{0pt}{}
  [\vspace{-1mm}]
\titlespacing*{\section}{0pt}{10mm}{2.5mm}
\titleformat{\subsection}{\bfseries\normalsize}
  {\llap{\makebox[\pvindexwidth][l]{\textcolor{pv-muted}{\thesubsection}}\hspace{\pvindexsep}}}{0pt}{}
\titlespacing*{\subsection}{0pt}{5mm}{0pt}
\let\pv@oldsection\section
\renewcommand\section{\par\addvspace{7.5mm}\pvfullrule[strong]\vspace{-10mm}\pv@oldsection}

% --- блоки: светлая линейка на всю сетку, метка в колонке, без рамок и заливок ---
\newcounter{pvthm}[section]
\renewcommand\thepvthm{\ifnum\c@section>\z@\thesection.\fi\arabic{pvthm}}
\newcommand\pv@block[2]{\par\addvspace{2.5mm}\needspace{3\baselineskip}\pvfullrule\vspace{-1.25mm}%
  \pvindex{#1}\if\relax\detokenize{#2}\relax\else{\bfseries #2.}\ \fi\ignorespaces}
\newcommand\pv@endblock{\par\addvspace{2.5mm}}
\newcommand\pv@lab[2]{{\color{#1}\pvlabel{#2}}}

\newenvironment{theorem}[1][]{\refstepcounter{pvthm}\pv@block{\pv@lab{pv-accent-text}{Теорема~\thepvthm}}{#1}}{\pv@endblock}
\newenvironment{lemma}[1][]{\refstepcounter{pvthm}\pv@block{\pv@lab{pv-accent-text}{Лемма~\thepvthm}}{#1}}{\pv@endblock}
\newenvironment{corollary}[1][]{\refstepcounter{pvthm}\pv@block{\pv@lab{pv-accent-text}{Следствие~\thepvthm}}{#1}}{\pv@endblock}
\newenvironment{definition}[1][]{\refstepcounter{pvthm}\pv@block{\pv@lab{pv-text}{Определение~\thepvthm}}{#1}}{\pv@endblock}
\newenvironment{example}[1][]{\pv@block{\pv@lab{pv-muted}{Пример}}{#1}}{\pv@endblock}
\newenvironment{remark}[1][]{\pv@block{\pv@lab{pv-muted}{Замечание}}{#1}}{\pv@endblock}
\newenvironment{proof}{\par\pvindex{\pv@lab{pv-muted}{Доказ.}}\ignorespaces}{\hfill\textcolor{pv-text}{\rule{0.5em}{0.5em}}\pv@endblock}
\newenvironment{solution}{\par\pvindex{\pv@lab{pv-muted}{Решение}}\ignorespaces}{\hfill\textcolor{pv-text}{\rule{0.5em}{0.5em}}\pv@endblock}
\newenvironment{hint}{\par\pvindex{\pv@lab{pv-muted}{Подсказка}}\color{pv-muted}\ignorespaces}{\pv@endblock}
\newcommand\answer[1]{\par\pvindex{\pv@lab{pv-correct}{Ответ}}#1\par}

% задача: красный номер в колонке; [баллы/уровень] — меткой под номером
\newcounter{pvtask}
\newenvironment{task}[1][]{\refstepcounter{pvtask}%
  \pv@block{{\pvindexfont\textcolor{pv-accent}{\thepvtask}}\if\relax\detokenize{#1}\relax\else\\[1mm]\pv@lab{pv-muted}{#1}\fi}{}}{\pv@endblock}
\newenvironment{parts}{\begin{enumerate}[label={\bfseries\asbuk*)},leftmargin=7.5mm,itemsep=0pt,topsep=1.25mm]}{\end{enumerate}}

\newenvironment{variant}[1]{\clearpage\def\pv@variant{#1}\setcounter{pvtask}{0}\maketitle\namefield}{}

\newcounter{pvticket}
\newenvironment{ticket}{\refstepcounter{pvticket}\par\needspace{45mm}\addvspace{7.5mm}\pvfullrule[strong]\vspace{-1.25mm}%
  \pvindex{{\bfseries\fontsize{30pt}{10mm}\selectfont\textcolor{pv-accent}{\two@digits{\thepvticket}}}}%
  {\color{pv-muted}\pvlabel{Билет}}\par
  \begin{enumerate}[label={\bfseries\arabic*.},leftmargin=5mm,itemsep=1.25mm]}{\end{enumerate}}

% место для ответа: \answerspace{высота в клетках}
\newcommand\answerspace[1]{\par\vspace{1.25mm}\noindent\begin{tikzpicture}[x=1mm,y=1mm]
  \draw[pv-grid,line width=0.25pt,step=5] (0,0) grid (150,#1*5);
  \draw[pv-rule,line width=0.3pt] (0,0) rectangle (150,#1*5);\end{tikzpicture}\par}

% --- списки, таблицы, ссылки ---
\setlist{itemsep=0pt,topsep=1.25mm}
\setlist[itemize,1]{label={\rule[0.55ex]{2.5mm}{0.5pt}},leftmargin=5mm}
\setlist[enumerate,1]{label={\bfseries\arabic*)},leftmargin=5mm}
\setlength\heavyrulewidth{0.5pt}\setlength\lightrulewidth{0.3pt}\setlength\cmidrulewidth{0.3pt}
\renewcommand\arraystretch{1.25}
\RequirePackage[hidelinks]{hyperref}
\endinput
