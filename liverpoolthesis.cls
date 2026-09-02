% University of Liverpool PGR thesis class
% Version 1.5 (2026-09-02)
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{liverpoolthesis}[2026/09/02 v1.5 University of Liverpool thesis class]

\newif\if@uol@twoside
\@uol@twosidefalse
\newif\if@uol@parskip
\@uol@parskipfalse
\def\@uol@headerstyle{auto}
\DeclareOption{twoside}{\@uol@twosidetrue\PassOptionsToClass{twoside,openright}{book}}
\DeclareOption{oneside}{\@uol@twosidefalse\PassOptionsToClass{oneside,openany}{book}}
\DeclareOption{parskip}{\@uol@parskiptrue}
\DeclareOption{indent}{\@uol@parskipfalse}
\DeclareOption{header=auto}{\def\@uol@headerstyle{auto}}
\DeclareOption{header=left}{\def\@uol@headerstyle{left}}
\DeclareOption{header=right}{\def\@uol@headerstyle{right}}
\DeclareOption{header=inner}{\def\@uol@headerstyle{inner}}
\DeclareOption{header=outer}{\def\@uol@headerstyle{outer}}
% The University thesis body size is fixed here rather than exposed as an
% author option.
\DeclareOption{10pt}{\ClassWarning{liverpoolthesis}{The 10pt option is ignored; the thesis uses 12pt}}
\DeclareOption{11pt}{\ClassWarning{liverpoolthesis}{The 11pt option is ignored; the thesis uses 12pt}}
\DeclareOption{12pt}{}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ExecuteOptions{oneside,indent}
\ProcessOptions\relax
\LoadClass[12pt,a4paper]{book}

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
% Flush-left hanging footnotes: the marker sits at the text margin and wrapped
% lines align with the first line of footnote text.
\RequirePackage[hang,flushmargin]{footmisc}
\RequirePackage{hyperref}
\RequirePackage{bookmark}

% Thesis heading-number selector. The public secnumdepth values intentionally
% provide separate chapterless and chapter-based sequences:
% -1 none; 0 section; 1 section/subsection; 2 chapter;
% 3 chapter/section; 4 chapter/section/subsection.
\newif\ifuol@numberchapters
\newcount\uol@secnumdepth
\let\uol@latex@setcounter\setcounter
\newcommand{\uol@setsecnumdepth}[1]{%
  \uol@secnumdepth=#1\relax
  \ifcase\numexpr\uol@secnumdepth+1\relax
    \uol@numberchaptersfalse
    \uol@latex@setcounter{secnumdepth}{-1}%
  \or
    \uol@numberchaptersfalse
    \renewcommand{\thesection}{\arabic{section}}%
    \renewcommand{\thesubsection}{\thesection.\arabic{subsection}}%
    \uol@latex@setcounter{secnumdepth}{1}%
  \or
    \uol@numberchaptersfalse
    \renewcommand{\thesection}{\arabic{section}}%
    \renewcommand{\thesubsection}{\thesection.\arabic{subsection}}%
    \uol@latex@setcounter{secnumdepth}{2}%
  \or
    \uol@numberchapterstrue
    \renewcommand{\thesection}{\thechapter.\arabic{section}}%
    \renewcommand{\thesubsection}{\thesection.\arabic{subsection}}%
    \uol@latex@setcounter{secnumdepth}{0}%
  \or
    \uol@numberchapterstrue
    \renewcommand{\thesection}{\thechapter.\arabic{section}}%
    \renewcommand{\thesubsection}{\thesection.\arabic{subsection}}%
    \uol@latex@setcounter{secnumdepth}{1}%
  \or
    \uol@numberchapterstrue
    \renewcommand{\thesection}{\thechapter.\arabic{section}}%
    \renewcommand{\thesubsection}{\thesection.\arabic{subsection}}%
    \uol@latex@setcounter{secnumdepth}{2}%
  \else
    \ClassError{liverpoolthesis}{Invalid secnumdepth value `#1'}{Use -1, 0, 1, 2, 3 or 4.}%
  \fi
}
\newcommand{\uol@installsetcounter}{%
  \renewcommand{\setcounter}[2]{%
    \ifstrequal{##1}{secnumdepth}
      {\uol@setsecnumdepth{##2}}
      {\uol@latex@setcounter{##1}{##2}}%
  }%
}
\uol@installsetcounter
\uol@setsecnumdepth{4}

% Packages such as calc may replace \setcounter while the preamble is being
% read. Capture the author's final requested value and reinstall the selector
% before the document begins.
\AtBeginDocument{%
  \edef\uol@requestedsecnumdepth{\number\c@secnumdepth}%
  \expandafter\uol@setsecnumdepth\expandafter{\uol@requestedsecnumdepth}%
  \uol@installsetcounter
}

% Apply the selector to chapter contents entries and printed chapter heads.
% In chapterless modes a hidden chapter step resets section counters and keeps
% hyperlink destinations unique, while no chapter number is printed.
\let\uol@book@chapter\chapter
\newcommand{\uol@chapterheadingfont}{\normalfont\Huge\bfseries}
\def\@chapter[#1]#2{%
  \ifuol@numberchapters
    \if@mainmatter
      \refstepcounter{chapter}%
      \typeout{\@chapapp\space\thechapter.}%
      \addcontentsline{toc}{chapter}{\protect\numberline{\thechapter}#1}%
    \else
      \addcontentsline{toc}{chapter}{#1}%
    \fi
  \else
    % Even when chapter numbers are hidden, make the chapter counter the
    % current reference target.  A plain \stepcounter leaves \@currentlabel
    % (and the hyperlink anchor) pointing at the preceding section, so a
    % \label immediately after \chapter incorrectly records that section.
    \if@mainmatter\refstepcounter{chapter}\fi
    \addcontentsline{toc}{chapter}{#1}%
  \fi
  % This class replaces book's \@chapter after nameref/hyperref has patched
  % it, so restore the chapter-title metadata used by \nameref and PDF links.
  \NR@gettitle{#2}%
  \chaptermark{#1}%
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
  \if@twocolumn
    \@topnewpage[\@makechapterhead{#2}]%
  \else
    \@makechapterhead{#2}%
    \@afterheading
  \fi
}
\renewcommand{\@makechapterhead}[1]{%
  \vspace*{50\p@}%
  {\parindent \z@ \raggedright \uol@chapterheadingfont
    \ifuol@numberchapters
      \if@mainmatter
        \thechapter.\hspace{0.75em}%
      \fi
    \fi
    \interlinepenalty\@M
    #1\par\nobreak
    \vskip 40\p@
  }%
}
\let\uol@thesis@chapter\@chapter
\let\uol@thesis@makechapterhead\@makechapterhead
\newcommand{\uol@restorechapterselector}{%
  \let\chapter\uol@book@chapter
  \let\@chapter\uol@thesis@chapter
  \let\@makechapterhead\uol@thesis@makechapterhead
}

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
% e-TeX's plural penalty prevents two- and three-line paragraph endings from
% being stranded at the top of a page.  Four or more lines remain eligible,
% allowing TeX to balance the end of a chapter instead of producing a nearly
% empty continuation page.
\widowpenalties 4 10000 10000 10000 0
\displaywidowpenalty=10000
\brokenpenalty=5000
\interfootnotelinepenalty=10000
\setlength{\emergencystretch}{2em}
% Preserve a natural baseline rhythm on sparse pages; flexible heading and
% float skips still let TeX balance the material that is present.
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

% Reset the ordinary thesis text style at every matter boundary.  This keeps a
% locally changed font size or line spacing from leaking into later sections.
\newcommand{\uol@mattertextstyle}{\normalfont\normalsize\onehalfspacing}

% Front matter is lower-case Roman; main matter restarts at Arabic 1.
\renewcommand{\frontmatter}{\cleardoublepage\@mainmatterfalse\pagenumbering{roman}\uol@mattertextstyle}
\renewcommand{\mainmatter}{\cleardoublepage\@mainmattertrue\pagenumbering{arabic}\uol@mattertextstyle}
\renewcommand{\backmatter}{\if@openright\cleardoublepage\else\clearpage\fi\@mainmatterfalse\uol@mattertextstyle}

\newcommand{\uol@frontmatterchapter}[1]{%
  \chapter*{#1}%
  \phantomsection
  \addcontentsline{toc}{chapter}{#1}%
}

\newenvironment{abstract}{%
  \uol@frontmatterchapter{Abstract}%
  \begingroup\uol@mattertextstyle
}{%
  \par\endgroup
}

% PGR thesis declaration. Commands inside the environment store their values
% first; the completed declaration is rendered when the environment ends.
\newcommand{\uol@defaultdeclaration}{%
  \noindent I declare that the research described in this thesis was conducted in accordance with the University of Liverpool's Postgraduate Research Code of Practice. Except where explicitly stated otherwise, the work presented in this thesis is my own and all sources have been appropriately acknowledged and referenced.\par
  I confirm that I have not plagiarised or copied material, embellished, fabricated or falsified data, colluded inappropriately in producing the work, or submitted work that was commissioned or procured from another person or service.\par
  I declare that this thesis has not been submitted, in whole or in part, in support of an application for another degree or academic award at this or any other institution.\par
  Material arising from this doctoral research may have been published or submitted for publication. Where published material or collaborative research is incorporated in this thesis, my contribution and the contributions of others are identified clearly.\par
  I permit the University, in cases of suspected academic malpractice, to use source-matching software to verify that the submitted work is my own and that the work of others has been acknowledged and referenced correctly.\par
}
\newcommand{\uol@declarationsignaturefield}{%
  \ifdefempty{\uol@declarationsignature}
    {}
    {\IfFileExists{\uol@declarationsignature}
       {\includegraphics[width=42mm,height=13mm,keepaspectratio]{\uol@declarationsignature}}
       {\ClassWarning{liverpoolthesis}{Declaration signature file `\uol@declarationsignature' not found}%
        }}%
}
\newcommand{\uol@declarationdatefield}{%
  \ifdefempty{\uol@declarationdate}{}{\uol@declarationdate}%
}
\newenvironment{declaration}{%
  \def\uol@declarationcontent{\uol@defaultdeclaration}%
  \def\uol@declarationsignature{}%
  \def\uol@declarationdate{}%
  \long\def\content##1{\def\uol@declarationcontent{##1}}%
  \def\signature##1{\def\uol@declarationsignature{##1}}%
  \def\signdata##1{\def\uol@declarationdate{##1}}%
}{%
  \uol@frontmatterchapter{Declaration}%
  \begingroup\uol@mattertextstyle
  \uol@declarationcontent
  \vspace{1.5\baselineskip}%
  \noindent\begin{tabular}{@{}l@{\hspace{1.5em}}l@{}}
    \parbox[c][13mm][c]{25mm}{\textbf{Signature}} & \parbox[c][13mm][c]{50mm}{\uol@declarationsignaturefield} \\[2em]
    \parbox[c][7mm][c]{25mm}{\textbf{Date}} & \parbox[c][7mm][c]{50mm}{\uol@declarationdatefield}
  \end{tabular}%
  \par\endgroup
}
\newenvironment{acknowledgements}{\uol@frontmatterchapter{Acknowledgements}\begingroup\uol@mattertextstyle}{\par\endgroup}
\newenvironment{publications}{\uol@frontmatterchapter{List of Publications}\begingroup\uol@mattertextstyle\begin{enumerate}}{\end{enumerate}\endgroup}
\newenvironment{abbreviations}{\uol@frontmatterchapter{List of Abbreviations and Symbols}\begingroup\uol@mattertextstyle\begin{description}}{\end{description}\endgroup}
\newenvironment{dedication}{\cleardoublepage\thispagestyle{plain}\null\vfill\begin{center}\itshape}{\end{center}\vfill\null\clearpage}

% The University requires all separate thesis sections to be identified in the
% table of contents. Insert each entry immediately after the standard book.cls
% heading so that book.cls remains responsible for the single required page
% break.
\patchcmd{\listoffigures}
  {\chapter*{\listfigurename}}
  {\chapter*{\listfigurename}\phantomsection
   \addcontentsline{toc}{chapter}{\listfigurename}}
  {}
  {\ClassWarning{liverpoolthesis}{Could not add List of Figures to the table of contents}}
\patchcmd{\listoftables}
  {\chapter*{\listtablename}}
  {\chapter*{\listtablename}\phantomsection
   \addcontentsline{toc}{chapter}{\listtablename}}
  {}
  {\ClassWarning{liverpoolthesis}{Could not add List of Tables to the table of contents}}

\pagestyle{fancy}
\newcommand{\@uol@headertext}{\nouppercase{\leftmark}}
\newcommand{\@uol@header@left}{\fancyhead[L]{\@uol@headertext}}
\newcommand{\@uol@header@right}{\fancyhead[R]{\@uol@headertext}}
% On recto (odd) pages the inner edge is left and the outer edge is right;
% the positions reverse on verso (even) pages.
\newcommand{\@uol@header@inner}{%
  \fancyhead[L]{\ifodd\value{page}\@uol@headertext\fi}%
  \fancyhead[R]{\ifodd\value{page}\else\@uol@headertext\fi}%
}
\newcommand{\@uol@header@outer}{%
  \fancyhead[L]{\ifodd\value{page}\else\@uol@headertext\fi}%
  \fancyhead[R]{\ifodd\value{page}\@uol@headertext\fi}%
}
\newcommand{\@uol@header@auto}{%
  \if@uol@twoside\@uol@header@outer\else\@uol@header@right\fi
}
\newcommand{\@uol@applyheaderstyle}{%
  \fancyhf{}%
  \ifcsdef{@uol@header@\@uol@headerstyle}
    {\csuse{@uol@header@\@uol@headerstyle}}
    {\ClassError{liverpoolthesis}{Unknown header style `\@uol@headerstyle'}
       {Use auto, left, right, inner or outer.}%
     \@uol@header@auto}%
  \fancyfoot[C]{\thepage}%
}
\newcommand{\thesisheaderstyle}[1]{%
  \gdef\@uol@headerstyle{#1}%
  \@uol@applyheaderstyle
}
\@uol@applyheaderstyle
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
  urlcolor=black,
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
    pdfcreator={LaTeX with liverpoolthesis, hyperref and BibTeX}%
  }%
}
\makeatother

\endinput
