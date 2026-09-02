<p align="center">
  <a href="https://www.liverpool.ac.uk/">
    <img src="uol-figures/logo.png" alt="University of Liverpool" width="720">
  </a>
</p>

<h1 align="center">University of Liverpool PhD Thesis LaTeX Template</h1>

<p align="center">
  A structured, publication-ready LaTeX template for University of Liverpool PGR theses,
  with configurable front matter, discipline-aware BibTeX styles, technical-writing environments,
  and searchable PDF metadata.
</p>

<p align="center">
  <img alt="Version 1.5" src="https://img.shields.io/badge/version-1.5-101F6B">
  <a href="https://www.overleaf.com/latex/templates/university-of-liverpool-unofficial-thesis-template/tgdthwyrbtjx"><img alt="Open in Overleaf" src="https://img.shields.io/badge/Open%20in-Overleaf-47A141?logo=overleaf&logoColor=white"></a>
  <a href="#-build"><img alt="pdfLaTeX and BibTeX" src="https://img.shields.io/badge/local%20build-pdfLaTeX%20%2B%20BibTeX-008080?logo=latex&logoColor=white"></a>
  <a href="example.pdf"><img alt="Compiled example" src="https://img.shields.io/badge/example-PDF-B30B00?logo=adobeacrobatreader&logoColor=white"></a>
  <a href="https://www.liverpool.ac.uk/media/livacuk/tqsd/code-of-practice-on-assessment/annex-7.1-PGR-CoP.pdf"><img alt="UoL PGR guidance" src="https://img.shields.io/badge/guidance-UoL-101F6B"></a>
  <a href="LICENSE"><img alt="License: CC BY 4.0" src="https://img.shields.io/badge/license-CC%20BY%204.0-B48300"></a>
</p>

<p align="center">
  <a href="example.pdf">📄 Compiled example</a>
  &nbsp;·&nbsp;
  <a href="example.tex">🧾 Example source</a>
  &nbsp;·&nbsp;
  <a href="#-quick-start">🚀 Quick start</a>
  &nbsp;·&nbsp;
  <a href="#-bibliography-styles">📚 Bibliography styles</a>
  &nbsp;·&nbsp;
  <a href="LICENSE">⚖️ License</a>
</p>

<p align="center">
  <a href="https://www.liverpool.ac.uk/">
    <img src="uol-figures/campus.jpg" alt="University of Liverpool campus and Victoria Building" width="100%">
  </a>
</p>

> [!IMPORTANT]
> This template encodes a consistent interpretation of the University of Liverpool's PGR thesis-formatting guidance. It does not replace the School requirements, or advice from your supervisor. Verify the requirements that apply at the point of submission. If you find any discrepancies between this template and the official guidance, please report them through the Issues.

## ✨ Highlights

- **University-oriented front matter** — title page, abstract, declaration, acknowledgements, publications, contents, lists, abbreviations, and optional dedication.
- **Correct pagination flow** — lower-case Roman numbering for front matter and Arabic numbering restarted at Chapter 1; the title-page number is counted but hidden.
- **Discipline-aware references** — select a discipline once and the package chooses an appropriate BibTeX style, with explicit overrides available.
- **Technical-writing toolkit** — chapter-numbered theorem environments, mathematics, algorithms, source-code listings, journal-style tables, subfigures, and cross-references.
- **Thesis-oriented typography** — A4 layout, one-and-a-half spacing, Linux Libertine text, matching NewTX mathematics, restrained Liverpool colours, and configurable paragraph layout.
- **Searchable PDF output** — numbered bookmarks, Unicode mapping, URL line breaking, and title, author, subject, keyword, and language metadata.
- **Print configuration** — `oneside` and `twoside` modes with a conservative 35 mm binding edge.

## 📑 Contents

- [Quick start](#-quick-start)
- [Build](#-build)
- [Project structure](#-project-structure)
- [Document configuration](#-document-configuration)
- [Front matter and chapter flow](#-front-matter-and-chapter-flow)
- [Bibliography styles](#-bibliography-styles)
- [Tables, mathematics, algorithms, and code](#-tables-mathematics-algorithms-and-code)
- [Common customisations](#-common-customisations)
- [Troubleshooting](#-troubleshooting)
- [Official guidance](#-official-guidance)
- [License](#-license)

## 🚀 Quick start

1. Keep the class, package, bibliography style, bibliography database, and `uol-figures/` directory together.
2. Copy [`example.tex`](example.tex) to a new thesis source, for example `thesis.tex`.
3. Replace the demonstration metadata and front-matter text.
4. Select the appropriate `discipline=...` value.
5. Build in Overleaf (recommended), or use the local four-pass pdfLaTeX/BibTeX sequence below.
6. Inspect the final PDF page by page before submission.

A minimal preamble is:

```latex
\documentclass[oneside,header=right]{liverpoolthesis}
\usepackage[discipline=computer-science]{liverpoolthesis}

\title{Title of the Thesis}
\author{Full Forenames and Surname}
\faculty{Faculty Name}
\school{School, Institute or Department Name}
\degree{Doctor in Philosophy}
\date{Month Year}
\subject{Short description of the research}
\keywords{keyword one, keyword two, keyword three}

\setcounter{secnumdepth}{4}
```

See [`example.tex`](example.tex) for a complete working document and [`example.pdf`](example.pdf) for the compiled result.

## 🛠 Build

### Recommended: Overleaf

> [!CAUTION]
> Because Overleaf’s template review process can take some time, the version available on Overleaf Gallery may not always be the latest. Before using the template, please check that the version number in the `.cls` file matches the latest release on the GitHub repository. If the versions differ, you can download the latest release from GitHub and upload it to Overleaf manually.

Overleaf is the recommended build environment for this template because it provides a consistent TeX installation and runs the required bibliography and cross-reference passes automatically. Import the Overleaf template, then set your thesis source (for example, `thesis.tex`) as the **Main document** and select **pdfLaTeX** as the compiler.

**Overleaf template:** [Open the template in Overleaf](https://www.overleaf.com/latex/templates/university-of-liverpool-unofficial-thesis-template/tgdthwyrbtjx)

### Local build: pdfLaTeX → BibTeX → pdfLaTeX × 2

For local compilation, run the following commands from the repository root:

```bash
pdflatex -interaction=nonstopmode -halt-on-error thesis.tex
bibtex thesis
pdflatex -interaction=nonstopmode -halt-on-error thesis.tex
pdflatex -interaction=nonstopmode -halt-on-error thesis.tex
```

To compile the supplied guide, replace `thesis` with `example`:

```bash
pdflatex -interaction=nonstopmode -halt-on-error example.tex
bibtex example
pdflatex -interaction=nonstopmode -halt-on-error example.tex
pdflatex -interaction=nonstopmode -halt-on-error example.tex
```

The first pdfLaTeX pass writes citation and cross-reference data, BibTeX creates the bibliography, and the final two pdfLaTeX passes resolve citations, page numbers, contents, lists, and bookmarks.

<details>
<summary><strong>Optional latexmk command</strong></summary>

```bash
latexmk -pdf thesis.tex
```

`latexmk` is convenient when it is configured to run BibTeX automatically, but the explicit four-pass sequence above is the recommended and reproducible build recipe for this template.

</details>

## 🗂 Project structure

```text
.
├── README.md                 # Setup and usage documentation
├── LICENSE                   # Creative Commons Attribution 4.0
├── example.tex               # Working thesis example and user guide
├── example.pdf               # Compiled example
├── references.bib            # Example BibTeX database
├── liverpoolthesis.cls       # Layout, cover, front matter, numbering, metadata
├── liverpoolthesis.sty       # Headings, tables, maths, code, bibliography selector
├── liverpoolthesis.bst       # Bundled IEEE-compatible BibTeX style
├── .gitignore                # LaTeX build artefacts and editor files
└── uol-figures/
    ├── logo.png              # Logo used automatically on the title page
    └── campus.jpg            # Demonstration image used in the guide
```

The class resolves the logo internally as `uol-figures/logo.png`; do not set the logo path in the thesis source.

## ⚙️ Document configuration

### Class options

```latex
\documentclass[oneside,indent,header=right]{liverpoolthesis}
```

| Option | Effect |
|---|---|
| `oneside` | Single-sided layout with chapters allowed to start on either page. |
| `twoside` | Mirrored margins and chapters starting on right-hand pages. |
| `indent` | Traditional first-line paragraph indentation; this is the default. |
| `parskip` | Separated paragraphs with no first-line indentation. |
| `header=auto` | Right-aligned running heads in `oneside`, outer-edge running heads in `twoside`; this is the default. |
| `header=left` | Place every running head at the left edge. |
| `header=right` | Place every running head at the right edge. |
| `header=inner` | Place running heads on the left of odd pages and right of even pages. |
| `header=outer` | Place running heads on the right of odd pages and left of even pages. |

The template defaults to 12pt, so it does not need to be written in the document options. The University requires a clear and consistent font but does not prescribe a particular font size; standard `book` sizes such as `10pt` or `11pt` remain available when a supervisor or School specifically requests one.

### Metadata commands

| Command | Purpose |
|---|---|
| `\title{...}` | Thesis title and PDF title metadata. |
| `\author{...}` | Candidate name and PDF author metadata. |
| `\faculty{...}` | Configurable faculty line on the title page. |
| `\school{...}` | Configurable School, Institute, or Department line. |
| `\degree{...}` | Degree name; defaults to `Doctor in Philosophy`. |
| `\date{...}` | Submission month and year. |
| `\subject{...}` | PDF subject metadata. |
| `\keywords{...}` | PDF keyword metadata. |

## 📖 Front matter and chapter flow

The intended document order is:

```latex
\begin{document}

\frontmatter
\maketitle

\begin{abstract}
Abstract text.
\end{abstract}

\begin{declaration}
% \content{Customized declaration content.}
\signature{uol-figures/signature.png}
\signdata{16 July, 2025}
\end{declaration}

\begin{acknowledgements}
Acknowledgements text.
\end{acknowledgements}

\begin{publications}
  \item \publication{your-publication-key}
\end{publications}

\tableofcontents
\listoffigures
\listoftables

\begin{abbreviations}
  \item[UoL] University of Liverpool
\end{abbreviations}

\mainmatter
\chapter{Introduction}
```

The class provides these front-matter environments:

- `abstract` — uses the same 12pt type and one-and-a-half line spacing as the thesis body;
- `declaration` — prints a doctoral-thesis declaration based on the current PGR Academic Integrity Policy, with `\signature{...}` and `\signdata{...}` fields; an optional `\content{...}` replaces the default text;
- `acknowledgements`;
- `publications` — an enumerated list that can pull complete entries from BibTeX;
- `abbreviations` — a description list for abbreviations and symbols;
- `dedication` — centred optional dedication text.

The University PGR Academic Integrity Policy states that the formal Academic Honesty Declaration for a campus-based initial thesis is normally incorporated into the submission form, while its standalone annexe may be used when a separate declaration is required. The template's `Declaration` page is a doctoral-thesis declaration derived from those PGR requirements; candidates should confirm any School-specific wording before submission.

The `\signature{...}` command accepts PDF, PNG and JPEG files. Crop the file to the visible signature before use because the class preserves its page or image bounds and scales the complete file without format-specific trimming.

For a multi-file thesis, keep the document declaration in the main file and include chapters after `\mainmatter`:

```latex
\mainmatter
\include{chapters/introduction}
\include{chapters/literature-review}
\include{chapters/methodology}
\include{chapters/results}
\include{chapters/conclusions}
```

## 📚 Bibliography styles

Select the discipline once:

```latex
\usepackage[discipline=computer-science]{liverpoolthesis}
```

The package writes the selected bibliography style to the auxiliary file automatically. Use standard BibTeX data in `references.bib`, cite with `natbib` commands such as `\citep{...}` and `\citet{...}`, and print the references with:

```latex
\bibliography{references}
```

The template automatically starts the reference list on a fresh page, creates its PDF hyperlink target and adds `References` to the table of contents.

Numeric reference lists follow ACM-style author/year/title ordering rather than assigning bibliography numbers by first appearance. Multiple numeric citations at the same point are sorted and compressed automatically. Author-year styles retain their normal alphabetical ordering.

| Discipline group | Default citation style | BibTeX style |
|---|---|---|
| Engineering, computing, and technology | IEEE numeric | bundled `liverpoolthesis.bst` |
| Medicine, health, and natural sciences | Sorted compact numeric | `plainnat` |
| Psychology, education, management, and social sciences | APA author–year | `apalike` |
| Economics, humanities, and arts | Author–year | `plainnat` |
| Law | Author–title | `jurabib` |

`discipline=general` and unrecognised values fall back to APA. A School-mandated style can override the mapping:

```latex
\usepackage[
  discipline=computer-science,
  style=apa
]{liverpoolthesis}
```

Recognised symbolic overrides are `ieee`, `numeric-comp`, `apa`, `authoryear`, and `authortitle`. A direct `.bst` style name may also be supplied through `style=...`.

<details>
<summary><strong>Accepted <code>discipline=...</code> values</strong></summary>

**Engineering, computing, and technology — IEEE numeric**

```text
engineering, electrical-engineering, electronic-engineering,
mechanical-engineering, civil-engineering, aerospace-engineering,
chemical-engineering, materials-engineering, biomedical-engineering,
systems-engineering, energy-engineering, computer-science, computing,
data-science, artificial-intelligence, robotics, telecommunications
```

**Medicine, health, and natural sciences — compact numeric**

```text
physics, astronomy, chemistry, mathematics, statistics, medicine,
dentistry, veterinary-science, nursing, pharmacy, public-health,
health-sciences, life-sciences, biology, biochemistry, genetics,
neuroscience, environmental-science, earth-sciences, geology,
ocean-sciences, agriculture, food-science
```

**Psychology, education, management, and social sciences — APA**

```text
general, psychology, education, social-sciences, sociology, anthropology,
criminology, politics, international-relations, public-policy, social-work,
management, business, marketing, geography, sport-science
```

**Economics, humanities, and arts — author–year**

```text
economics, finance, accounting, humanities, history, archaeology, classics,
philosophy, literature, languages, linguistics, music, arts, architecture,
planning, communication, media-studies, theology
```

**Law — author–title**

```text
law
```

</details>

### List of publications

Publication entries can be generated from the same `.bib` database rather than typed twice:

```latex
\begin{publications}
  \item \publication{your-first-paper}
  \item \publication{your-second-paper}
\end{publications}
```

A List of Publications does not by itself constitute a thesis incorporating publications. Such theses must also follow the University's separate Annexe 2 requirements.

## 🧪 Tables, mathematics, algorithms, and code

### Journal-style tables

Use standard LaTeX table syntax. Table captions are placed above the table, and `booktabs` rules are available by default. Use `\caption[Short title]{Full descriptive caption}` when the List of Tables needs a concise entry; the same syntax applies to figures and the List of Figures. Captions that fit on one line are centred automatically, while captions that wrap over multiple lines are left-aligned:

```latex
\begin{table}[htbp]
  \centering
  \caption[Comparison of methods]{Example comparison using ordinary table syntax.}
  \label{tab:comparison}
  \begin{tabular}{lrr}
    \toprule
    \textbf{Method} & \textbf{Accuracy (\%)} & \textbf{Time (s)} \\
    \midrule
    Baseline & 84.2 & 12.6 \\
    Proposed & 91.7 & 8.4 \\
    \bottomrule
  \end{tabular}
\end{table}
```

Advanced tables can use `tabularx`, `longtable`, `threeparttable`, `siunitx` `S` columns, flexible `L`/`C`/`R` columns, or `P{width}` columns.

Paragraph, heading and float spacing uses flexible stretch and shrink components. LaTeX therefore balances each page automatically while preserving the template's preferred spacing between paragraphs, headings, text, figures and tables; authors do not need to insert manual `\vspace` commands.

### Theorems and proofs

The template defines chapter-numbered `theorem`, `lemma`, `proposition`, `corollary`, `conjecture`, `definition`, `assumption`, `example`, and `remark` environments, together with the standard `proof` environment.

### Algorithms

Use the `algorithm` float with `algpseudocode`. Algorithms are numbered by chapter and support standard labels and references.

### Source code

The default `liverpool` listings style provides line numbers, restrained colour, automatic wrapping, an embedded monospaced font, and a light background.

## 🔧 Common customisations

### Double-sided printing

```latex
\documentclass[twoside,header=outer]{liverpoolthesis}
```

Use `header=inner` for the reverse alternating arrangement. For a fixed position in an electronic edition, use `header=left` or `header=right`. The equivalent preamble command is `\thesisheaderstyle{left}`, `\thesisheaderstyle{right}`, `\thesisheaderstyle{inner}`, `\thesisheaderstyle{outer}`, or `\thesisheaderstyle{auto}`. Chapter-opening pages remain header-free by convention.

### Paragraphs separated by space

```latex
\documentclass[oneside,parskip,header=right]{liverpoolthesis}
```

### Heading-number depth

```latex
\setcounter{secnumdepth}{-1} % no heading numbers
\setcounter{secnumdepth}{0}  % sections only
\setcounter{secnumdepth}{1}  % sections and subsections
\setcounter{secnumdepth}{2}  % chapters only
\setcounter{secnumdepth}{3}  % chapters and sections
\setcounter{secnumdepth}{4}  % chapters, sections, and subsections (default)
```

### Appendices after references

Appendices may follow the reference list. Start them directly with `\appendix`:

```latex
\bibliography{references}

\appendix
\chapter{Supplementary Material}
```

Do **not** place `\backmatter` before these appendices: the underlying `book` class would suppress `Appendix A`, `Appendix B`, and subsequent appendix numbering.

## 🩺 Troubleshooting

| Symptom | Resolution |
|---|---|
| Citations show as `?` or the reference list is empty | Run the complete `pdflatex → bibtex → pdflatex → pdflatex` sequence. |
| The title-page logo is missing | Preserve the path `uol-figures/logo.png` relative to the main `.tex` file. |
| Figures are missing | Check image paths and keep `uol-figures/campus.jpg` when compiling the supplied example. |
| Appendix letters disappear | Remove `\backmatter` before `\appendix`. |
| An unknown discipline warning appears | Use one of the accepted lower-case, hyphenated values; otherwise APA is selected as the fallback. |
| A required package is unavailable | Install the missing package through the TeX distribution and rebuild from the first pdfLaTeX pass. |
| Cross-references or contents are stale | Run the final two pdfLaTeX passes again. |

## 🏛 Official guidance

- [Postgraduate Research Code of Practice](https://www.liverpool.ac.uk/study/academic-quality-and-standards-division/academic-codes-of-practice/postgraduate-research-code-of-practice/)
- [Annexe 1 — Guidelines for formatting and presentation of a PGR degree thesis](https://www.liverpool.ac.uk/media/livacuk/tqsd/code-of-practice-on-assessment/annex-7.1-PGR-CoP.pdf)
- [Annexe 2 — Guidelines on presentation of publications within a PGR thesis](https://www.liverpool.ac.uk/media/livacuk/tqsd/code-of-practice-on-assessment/annex-7.2-PGR-CoP.pdf)

The example guide also includes a pre-submission checklist covering placeholders, word-count rules, figures and tables, references, permissions, supporting material, pagination, bookmarks, equations, appendices, and embedded fonts.

## ⚖️ License

This template is licensed under the [Creative Commons Attribution 4.0 International License](LICENSE) (`CC BY 4.0`).

When redistributing or adapting the template, retain appropriate attribution and the license notice.
