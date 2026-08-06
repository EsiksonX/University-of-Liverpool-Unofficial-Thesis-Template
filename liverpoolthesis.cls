% University of Liverpool PGR thesis class
% Version 1.2 (2026-07-31)
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{liverpoolthesis}[2026/07/31 v1.2 University of Liverpool thesis class]

\newif\if@uol@twoside
\@uol@twosidefalse
\newif\if@uol@parskip
\@uol@parskipfalse
\DeclareOption{twoside}{\@uol@twosidetrue\PassOptionsToClass{twoside,openright}{book}}
\DeclareOption{oneside}{\@uol@twosidefalse\PassOptionsToClass{oneside,openany}{book}}
\DeclareOption{parskip}{\@uol@parskiptrue}
\DeclareOption{indent}{\@uol@parskipfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ExecuteOptions{12pt,oneside,indent}
\ProcessOptions\relax
\LoadClass[a4paper]{book}

\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
% Load theorem support before newtxmath so proof symbols are coordinated.
\RequirePackage{amsthm}
% ACM-style typography: Linux Libertine text with matching NewTX mathematics.
\RequirePackage[tt=false,type1=true]{libertine}
\RequirePackage[libertine]{newtxmath}
\RequirePackage[varqu]{zi4}
\RequirePackage{graphicx}
\RequirePackage{geometry}
\RequirePackage{setspace}
\RequirePackage{etoolbox}
\RequirePackage{fancyhdr}
\RequirePackage{xurl}
\RequirePackage{hyperref}
\RequirePackage{bookmark}

% ACM-style searchable/copyable PDF text when compiling with pdfLaTeX.
\RequirePackage{iftex}
\ifPDFTeX
  \input{glyphtounicode}
  \pdfgentounicode=1
\fi

% The current University guidance prescribes A4 but does not set exact margins.
% These conservative margins suit electronic submission and optional binding.
\if@uol@twoside
  \geometry{a4paper,inner=35mm,outer=25mm,top=25mm,bottom=30mm,headheight=15pt}
\else
  \geometry{a4paper,left=35mm,right=25mm,top=25mm,bottom=30mm,headheight=15pt}
\fi
\onehalfspacing
\if@uol@parskip
  % Optional modern layout: paragraphs separated by restrained white space.
  \setlength{\parindent}{0pt}
  \setlength{\parskip}{0.65em plus 0.15em minus 0.10em}
\else
  % Default thesis/journal layout: first-line indent and no blank paragraph gap.
  \setlength{\parindent}{1.5em}
  \setlength{\parskip}{0pt plus 0.1pt}
\fi
% Avoid isolated first/last lines and fragile breaks around displayed material.
\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty=10000
\brokenpenalty=5000
\interfootnotelinepenalty=10000
\setlength{\emergencystretch}{2em}
\raggedbottom

\makeatletter
% Use the standard LaTeX \title, \author and \date interfaces.
\title{Title of the Thesis}
\author{Full Forenames and Surname}
\date{Month Year}
\newcommand{\@thesisfaculty}{}
\newcommand{\@thesisschool}{}
\newcommand{\@thesisdegree}{Doctor in Philosophy}
\newcommand{\@thesissubject}{Doctoral thesis}
\newcommand{\@thesiskeywords}{}
% The logo belongs to the template. Users do not set its path in thesis.tex.
\newcommand{\@uol@logofile}{uol-figures/logo.png}

\newcommand{\faculty}[1]{\gdef\@thesisfaculty{#1}}
\newcommand{\school}[1]{\gdef\@thesisschool{#1}}
\newcommand{\degree}[1]{\gdef\@thesisdegree{#1}}
\newcommand{\subject}[1]{\gdef\@thesissubject{#1}}
\newcommand{\keywords}[1]{\gdef\@thesiskeywords{#1}}

\renewcommand{\maketitle}{%
  \clearpage
  \begingroup
    \thispagestyle{empty}
    \centering
    \IfFileExists{\@uol@logofile}{%
      \includegraphics[width=.72\textwidth,height=35mm,keepaspectratio]{\@uol@logofile}\par
    }{%
      \ClassWarning{liverpoolthesis}{Template logo `\@uol@logofile' not found; title page has no logo}%
    }
    \vspace{1.2cm}
    \ifdefempty{\@thesisfaculty}{}{%
      {\large \@thesisfaculty\par}\vspace{0.25cm}%
    }
    \ifdefempty{\@thesisschool}{}{%
      {\large \@thesisschool\par}%
    }
    \vfill
    {\bfseries\LARGE \@title\par}
    \vfill
    {\large
      Thesis submitted in accordance with the requirements of the\\[0.35em]
      University of Liverpool for the degree of \@thesisdegree\\[0.35em]
      by\\[0.35em]
      \textbf{\@author}\par
    }
    \vfill
    {\large \@date\par}
    \clearpage
  \endgroup
}

% Front matter is lower-case Roman; main matter restarts at Arabic 1.
\renewcommand{\frontmatter}{\cleardoublepage\@mainmatterfalse\pagenumbering{roman}}
\renewcommand{\mainmatter}{\cleardoublepage\@mainmattertrue\pagenumbering{arabic}}
\renewcommand{\backmatter}{\if@openright\cleardoublepage\else\clearpage\fi\@mainmatterfalse}

\newcommand{\uol@frontmatterchapter}[1]{%
  \chapter*{#1}%
  \phantomsection
  \addcontentsline{toc}{chapter}{#1}%
}

\newenvironment{abstract}{%
  \uol@frontmatterchapter{Abstract}%
  \begingroup\singlespacing
}{%
  \par\endgroup
}

\newenvironment{declaration}{\uol@frontmatterchapter{Declaration}}{}
\newenvironment{acknowledgements}{\uol@frontmatterchapter{Acknowledgements}}{}
\newenvironment{publications}{\uol@frontmatterchapter{List of Publications}\begin{enumerate}}{\end{enumerate}}
\newenvironment{abbreviations}{\uol@frontmatterchapter{List of Abbreviations and Symbols}\begin{description}}{\end{description}}
\newenvironment{dedication}{\cleardoublepage\thispagestyle{plain}\null\vfill\begin{center}\itshape}{\end{center}\vfill\null\clearpage}

% The University requires all separate thesis sections to be identified in the
% table of contents. Standard book.cls omits these two lists, so add them here.
\let\@uol@listoffigures\listoffigures
\renewcommand{\listoffigures}{%
  \cleardoublepage\phantomsection
  \addcontentsline{toc}{chapter}{\listfigurename}%
  \@uol@listoffigures
}
\let\@uol@listoftables\listoftables
\renewcommand{\listoftables}{%
  \cleardoublepage\phantomsection
  \addcontentsline{toc}{chapter}{\listtablename}%
  \@uol@listoftables
}

\pagestyle{fancy}
\fancyhf{}
\if@uol@twoside
  \fancyhead[LE]{\nouppercase{\leftmark}}
  \fancyhead[RO]{\nouppercase{\rightmark}}
\else
  \fancyhead[R]{\nouppercase{\leftmark}}
\fi
\fancyfoot[C]{\thepage}
\renewcommand{\headrulewidth}{0.4pt}
\fancypagestyle{plain}{%
  \fancyhf{}
  \fancyfoot[C]{\thepage}
  \renewcommand{\headrulewidth}{0pt}
}

\hypersetup{
  unicode=true,
  bookmarksnumbered=true,
  colorlinks=true,
  linkcolor=black,
  citecolor=black,
  urlcolor=blue,
  pdflang={en-GB},
  pdfdisplaydoctitle=true
}
% Metadata must be assigned after the user's preamble commands have run.
\AtBeginDocument{%
  \hypersetup{%
    pdfauthor={\@author},
    pdftitle={\@title},
    pdfsubject={\@thesissubject},
    pdfkeywords={\@thesiskeywords},
    pdfcreator={LaTeX with liverpoolthesis, hyperref and biblatex}%
  }%
}
\makeatother

\endinput
