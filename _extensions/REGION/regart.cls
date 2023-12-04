\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{regart}[1995/04/01 Article Class for REGION]
\RequirePackage[breakwithin]{parnotes}
\RequirePackage[pagewise]{lineno}
\RequirePackage{fancyhdr}
\RequirePackage{ifthen}
\newboolean{isfinal}
\newboolean{isreview}
\newboolean{showheader}
\setboolean{isfinal}{false}
\setboolean{isreview}{false}
\setboolean{showheader}{false}
\RequirePackage{draftwatermark}
%\RequirePackage{hyperref}
  \SetWatermarkText{}
  \SetWatermarkScale{0}
\DeclareOption{review}{%
  \setboolean{isreview}{true}
  \setboolean{showheader}{true}
  \SetWatermarkText{For REVIEW ONLY}
  \SetWatermarkScale{2.5}
  \linenumbers
}
\DeclareOption{final}{%
  \setboolean{isfinal}{true}
  \setboolean{showheader}{true}
}
\DeclareOption{uncorrected}{%
  \setboolean{isfinal}{true}
  \setboolean{showheader}{true}
  \SetWatermarkText{uncorrected proofs}
  \SetWatermarkScale{2.5}
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
  
\ProcessOptions\relax
\LoadClass[10pt]{article}

\setlength{\textwidth}{13.4cm}
\setlength{\textheight}{20.8cm}
\setlength{\oddsidemargin}{1.3cm}

\setlength{\textwidth}{13.5cm}
\setlength{\textheight}{24.3cm}
\setlength{\oddsidemargin}{1.3cm}
\setlength{\evensidemargin}{1.3cm}
\setlength{\topmargin}{-1cm}



\newcommand{\jel}[1]{\par
  \vspace{3mm}
  \noindent \textbf{JEL classification: }#1
  \vspace{3mm}
}

\newcommand{\keywords}[1]{\par
  \vspace{3mm}
  \noindent \textbf{Key words: }#1
  \vspace{3mm}
}

\newcommand{\receivedaccepted}[1]{\footnotesize \par
  \vspace{3mm}
  \noindent #1
  \vspace{3mm}
}

%% Define RECEIVED and ACCEPTED

\def\@received{MISSING}
\newcommand{\received}[1]{\def\@received{#1}}
\newcommand{\show@received}{\footnotesize \par
  \vspace{3mm}
  \noindent Received: \@received /%
}

\def\@accepted{MISSING}
\newcommand{\accepted}[1]{\def\@accepted{#1}}
\newcommand{\show@accepted}{\footnotesize 
  \noindent Accepted: \@accepted
  \vspace{3mm}
}


%% Define JVOL, JNUM, JYEAR, JPAGES and JAUTHOR

\def\@jvol{MISSING}
\newcommand{\jvol}[1]{\def\@jvol{#1}}

\def\@jnum{MISSING}
\newcommand{\jnum}[1]{\def\@jnum{#1}}

%\def\@jmonth{MISSING}
%\newcommand{\jmonth}[1]{\def\@jmonth{#1}}

\def\@jyear{MISSING}
\newcommand{\jyear}[1]{\def\@jyear{#1}}

\def\@jpages{MISSING}
\newcommand{\jpages}[1]{\def\@jpages{#1}}

\def\@jauthor{MISSING}
\newcommand{\jauthor}[1]{\def\@jauthor{#1}}

\def\@jdoi{MISSING}
\newcommand{\jdoi}[1]{\def\@jdoi{#1}}

\ifisreview
  \def\@jauthor{SUPPRESSED}
\fi

\ifisfinal 
  \pagestyle{fancy}
  \fancyhead[RO,LE]{\thepage}
  \fancyhead[LO,RE]{\@jauthor}
  \fancyfoot{}
  \fancyfoot[RO,LE]{\emph{REGION}: Volume \@jvol, Number \@jnum, \@jyear}
  \renewcommand\headrulewidth{1.0pt}
  \renewcommand\footrulewidth{1.0pt}
\fi

\ifisreview
  \pagestyle{fancy}
  \fancyhead[RO,LE]{\thepage}
  \fancyhead[LO,RE]{}
  \fancyfoot{}
  \fancyfoot[RO,LE]{\emph{REGION}}
  \fancyfoot[LO,RE]{journal homepage: region.ersa.org}
  \fancyfoot[LO,RE]{ISSN: 2409-5370}
  \renewcommand\headrulewidth{1.0pt}
  \renewcommand\footrulewidth{1.0pt}
\fi



\renewcommand\maketitle{\par
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
      \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@maketitle
    \fi
    \thispagestyle{plain}\@thanks
  \endgroup
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}

\renewcommand\@maketitle{%
  \ifisreview
    \def\@author{Author(s): SUPPRESSED}
  \fi
  \newpage
  \null \vskip -4em%
  \ifshowheader
    \noindent\rule{\textwidth}{0.5pt}
    \vspace{0pt}
    {\setlength\fboxsep{0pt}
      \hspace{-6pt}
      \parbox{9.3cm}{
        \includegraphics[height=1.9cm]{titlepage_21}
%        {\vspace{9pt}\sffamily\large{\bfseries\noindent REGION \\[4pt] The Journal of ERSA} \\[4pt] Powered by WU}\\[8pt] {\footnotesize journal homepage: region.ersa.org}
      } %% parbox
      \parbox{4.1cm}{\noindent\hspace{3mm}\includegraphics[height=8mm]{titlepage_22}\\ \includegraphics[height=7mm]{ERSA_logo}\includegraphics[height=8mm]{wutext}\includegraphics[height=4mm]{fwf}}

%      \parbox{2.0cm}{\vspace{1pt}\noindent\includegraphics[width=1.88cm]{titlepage_rahmen}}
    } %%setlength wrapper
    \noindent\rule{\textwidth}{0.5pt}
  \fi
  \ifisfinal
    {\footnotesize Volume \@jvol, Number \@jnum, \@jyear, \@jpages \hfill journal homepage: region.ersa.org\\[-1mm] 
      DOI: \@jdoi \hfill ISSN: 2409-5370}\\
%    \rule[4pt]{76mm}{0mm} \parbox[h]{6cm}{\tiny \centering \includegraphics[height=3mm]{license}\hspace*{20mm}\\This work is licensed under a Creative Commons\\Attribution-NonCommercial 4.0 International License\\}
  \fi
  \ifisreview
    {\footnotesize for review only \hfill journal homepage: region.ersa.org}
  \fi
%  \vskip 3em%
  \vskip 4em%
  \let \footnote \thanks
    {\Large \noindent \textbf{\@title} \par}%
    \vskip 1.5em%
    {\normalsize
      \lineskip .5em%
        \noindent {\bf \@author}
    }%
    \vskip 1em%
    \setcounter{footnote}{0}%
    \parnotes%
    \ifisfinal 
      \show@received\show@accepted%
    \fi
    {\large \@date}%
  \par
  \vskip 0.5em
}


\renewenvironment{abstract}{%
  \if@twocolumn
    \section*{\abstractname}%
  \else
    \vspace{5mm}
%    \small
      \noindent {\bfseries \abstractname.}%
  \fi}
{\if@twocolumn\else\vspace{3mm}\fi}


\renewcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\normalfont\normalsize\bfseries}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\normalsize\slshape}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\normalsize}}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {3.25ex \@plus1ex \@minus.2ex}%
                                    {-1em}%
                                    {\normalfont\normalsize\bfseries}}
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                       {3.25ex \@plus1ex \@minus .2ex}%
                                       {-1em}%
                                      {\normalfont\normalsize\bfseries}}

