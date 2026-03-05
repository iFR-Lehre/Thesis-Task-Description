\ProvidesClass{ifrscope}[2026/03/04 Custom Template for Scope of Thesis at iFR]

% Default language 
\newcommand{\@ifrlang}{ngerman}

\DeclareOption{ngerman}{\renewcommand{\@ifrlang}{ngerman}}
\DeclareOption{english}{\renewcommand{\@ifrlang}{english}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}

\ProcessOptions*\relax

\LoadClass[
    12pt,
	twoside=false, 
	headsepline, % include header in type area
	DIV=14, % divisor for construction of type area
	BCOR=5mm, % binding correction
	]{scrartcl}

\RequirePackage[\@ifrlang]{babel}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage{newtxtext}
\renewcommand{\familydefault}{\sfdefault}
\RequirePackage{scrlayer-scrpage}
\RequirePackage{hyperref}
\RequirePackage{graphicx}
\RequirePackage{enumitem}
\setlist[itemize]{noitemsep, after=\vspace{0mm}}

% -----------------------------------------------------------------------------
% Metadata commands
% -----------------------------------------------------------------------------

\newcommand{\ifrtitle}[1]{\def\@ifrtitle{#1}}

\newcommand{\ifrstudent}[1]{\def\@ifrstudent{#1}}

\def\@ifrtype{\iflanguage{ngerman}{Bachelorarbeit}{Bachelor's Thesis}} % Default to Bachelor's thesis if not specified
\newcommand{\ifrtype}[1]{%
  \ifthenelse{\equal{#1}{B}}{%
    \def\@ifrtype{\iflanguage{ngerman}{Bachelorarbeit}{Bachelor's Thesis}}%
  }{%
    \ifthenelse{\equal{#1}{M}}{%
      \def\@ifrtype{\iflanguage{ngerman}{Masterarbeit}{Master's Thesis}}%
    }{%
      \def\@ifrtype{#1}%
    }%
  }%
}

\newcommand{\ifrstartdate}[1]{\def\@ifrstartdate{#1}}

% Initialize supervisor variable as empty
\def\@ifrsupervisor{}
% Command to set supervisor(s) - can be called multiple times or with comma-separated list
\newcommand{\ifrsupervisor}[1]{%
  \ifx\@ifrsupervisor\@empty
    \def\@ifrsupervisor{#1}%
  \else
    \g@addto@macro\@ifrsupervisor{, #1}%
  \fi
}

\newcommand{\ifrmotivation}[1]{\def\@ifrmotivation{#1}}

\newcommand{\ifrobjective}[1]{\def\@ifrobjective{#1}}

% Initialize task variable as empty
\def\@ifrtask{}
% Command to set task(s) - can be called multiple times or with comma-separated list
\newcommand{\ifrtask}[1]{%
  \ifx\@ifrtask\@empty
    \def\@ifrtask{{#1}}%
  \else
    \g@addto@macro\@ifrtask{,{#1}}%
  \fi
}

% -----------------------------------------------------------------------------
% Document header
% -----------------------------------------------------------------------------

\pagestyle{scrheadings}
\clearpairofpagestyles
\rohead{\upshape \textbf{\iflanguage{ngerman}{Universität Stuttgart}{University of Stuttgart}} \\ \textbf{\iflanguage{ngerman}{Institut für Flugmechanik und Flugregelung}{Institute of Flight Mechanics and Controls}} \\[0.5ex]{\small Prof. Dr.-Ing. Walter Fichter}\vspace{-1.45\baselineskip}}
\lohead{\includegraphics[height=2\baselineskip]{ifrlogo}}
\setlength{\headsep}{3\baselineskip}
\setlength{\headheight}{34pt}
\KOMAoptions{headsepline=true}

\setlength{\parindent}{0pt}

% -----------------------------------------------------------------------------
% Document content
% -----------------------------------------------------------------------------

\newcommand{\makedocument}{%
    {\LARGE \bfseries \iflanguage{ngerman}{Aufgabenstellung der}{Task Description for the}  \@ifrtype}
    \\[\baselineskip]
    \iflanguage{ngerman}{von}{of} \@ifrstudent
    \\[\baselineskip]
    \begin{center}
        \fboxrule1.0mm
        \fbox{%
            \begin{minipage}{\dimexpr\textwidth-2\fboxsep-2\fboxrule\relax}
                \begin{center}
                    \vspace{0.5cm}
                    \large \textbf{\@ifrtitle}
                    \vspace{0.5cm}
                \end{center}
            \end{minipage}%
        }
    \end{center}
    \vspace{\baselineskip}
    {\bfseries \underline{Motivation:}}\\
    \@ifrmotivation
    \\[\baselineskip]
    {\bfseries \underline{\iflanguage{ngerman}{Zielsetzung}{Objective}:}}\\
    \@ifrobjective
    \\[\baselineskip]
    {\bfseries \underline{\iflanguage{ngerman}{Aufgaben}{Tasks}:}}
    \begin{itemize}
        \ifx\@ifrtask\@empty
            \item \textbf{No tasks specified}%
        \else
        \@for\@task:=\@ifrtask\do{%
            \item \@task%
        }%
        \fi
    \end{itemize}
    \renewcommand{\arraystretch}{2}
    \begin{tabular}{p{5cm}l}
        {\bfseries \underline{\iflanguage{ngerman}{Bearbeitungsbeginn}{Start}:}} & \@ifrstartdate \\
        {\bfseries \underline{\iflanguage{ngerman}{Betreuer/Betreuerin}{Supervisor}:}} & \@ifrsupervisor
    \end{tabular}

    \vspace{2cm}
    \parbox{7cm}{
        \hrule
        \strut \centering\footnotesize \iflanguage{ngerman}{Unterschrift Betreuer/Betreuerin}{Signature of Supervisor}
    }
    \hfill
    \parbox{7cm}{
        \hrule
        \strut \centering\footnotesize \iflanguage{ngerman}{Unterschrift}{Signature of} \@ifrstudent
    }
}
