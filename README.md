# University of Liverpool PhD thesis LaTeX template

This template follows the University of Liverpool's 2025/26 *Guidelines for formatting and presentation of a PGR degree thesis to UoL for examination* (Appendix 7, Annexe 1), while exposing configurable faculty and school fields for the cover. The logo path is internal to the class and is not set in the thesis source.

## Files

- `liverpoolthesis.cls`: document class, A4 layout, cover, metadata, front/main
  matter and page-number handling.
- `liverpoolthesis.sty`: the single companion style containing headings,
  captions, tables, lists, maths and discipline-aware bibliography selection.
- `liverpoolthesis.bst`: the single bundled IEEE-compatible BibTeX style.
- `example.tex`: template guide and working thesis example.
- `references.bib`: example bibliography database.
- `uol-figures/logo.png`: template-owned logo used automatically by the title page.
- `uol-figures/campus.jpg`: campus image used by the template guide.

## Compile

```bash
latexmk -pdf example.tex
```

Edit the metadata commands at the top of `example.tex`. Use `\frontmatter` before the cover and preliminary pages, then `\mainmatter` immediately before Chapter 1. The title page is counted as Roman page i but its number is intentionally hidden; the following preliminary pages display lower-case Roman numerals. Main matter restarts at Arabic page 1.

The example front matter contains Abstract, Declaration, Acknowledgements, List of Publications, Table of Contents, List of Figures, List of Tables, and List of Abbreviations and Symbols.

Standard LaTeX interfaces are used wherever they exist: `\title`, `\author`, `\date`, `\maketitle` and the `abstract` environment. The Liverpool-specific cover fields are `\faculty`, `\school` and `\degree`; PDF metadata can additionally be set with `\subject` and `\keywords`.

The University does not prescribe one University-wide reference style. It requires a consistent style currently accepted in the relevant discipline and advises candidates to consult their supervisors when in doubt. Select the discipline once:

```latex
\usepackage[discipline=computer-science]{liverpoolthesis}
```

Engineering and computing select IEEE; medicine, health and most natural sciences select a compact numeric style; psychology, education and most social sciences select APA; economics, humanities and arts select author--year; and law selects author--title. `discipline=general` and unknown values fall back to APA. Use `style=...` to override a School requirement.

The selector loads `natbib` and automatically writes the matching BibTeX `.bst` name to the auxiliary file. Engineering and computing use the bundled `liverpoolthesis.bst`; other disciplines use standard styles supplied by the TeX installation. References are processed by BibTeX during the normal build.

Entries in the List of Publications are generated from `references.bib` with the template command, for example `\item \publication{paper-key}`. A thesis that incorporates publications as chapters must additionally follow Appendix 7 Annexe 2, including its Introduction, Conclusion, chapter-linking, contribution declaration, permission and reformatting requirements.

For double-sided printing, change `oneside` to `twoside`. The official guidance does not prescribe exact margins; this class uses a conservative 35 mm binding edge, 25 mm outer/top edge and 30 mm bottom edge. Confirm any School-specific preferences with the supervisor before submission.

## Typography and paragraph layout

The template uses the same broad font approach as the ACM article class: Linux Libertine for text and NewTX Libertine mathematics. The University requires a clear and consistent font, but does not mandate a particular typeface.

The default `indent` class option uses traditional first-line paragraph indents with no blank gap. To use separated paragraphs instead, select:

```latex
\documentclass[12pt,oneside,parskip]{liverpoolthesis}
```

Both modes include widow/orphan prevention, display-break protection and a small emergency line-breaking allowance suitable for long technical documents.

## Journal-style tables

Use ordinary LaTeX `table` and `tabular` environments. The template automatically applies the table font size, caption position, row spacing, column padding, numbering and float spacing. A typical table therefore needs only:

```latex
\begin{table}[htbp]
  \centering
  \caption{Results.}
  \label{tab:results}
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

The standard `booktabs` rules are available and vertical rules are discouraged. For tables that genuinely need them, optional `tabularx`, `S` numerical columns, `L`/`C`/`R` flexible-width columns, `P{width}` columns and `tablenotes` remain available. There is no custom table wrapper environment.

## Appendices after references

The example places appendices after the reference list. Use `\appendix` directly after `\bibliography{references}`, followed by ordinary `\chapter` commands. Do not put `\backmatter` before these appendices, because `book.cls` would then suppress their Appendix A, Appendix B numbering.

## Technical-writing components

The companion style includes chapter-numbered theorem, lemma, proposition, corollary, conjecture, definition, assumption, example and remark environments, plus the standard `proof` environment. Algorithms use `algorithm` with `algpseudocode`; code listings use the `liverpool` listings style. Use ordinary LaTeX cross-references such as `Figure~\ref{fig:result}` and `Theorem~\ref{thm:bound}`.

Heading numbering is author-controlled in `example.tex`. The default `\setcounter{secnumdepth}{2}` numbers chapters, sections and subsections, with a top-level heading such as `1. Introduction`. Use `1` to stop after sections, `0` for chapter numbers only, or `-1` to suppress all heading numbers.

Float placement follows restrained journal-style thresholds: several top floats are allowed without creating nearly empty text pages, while dedicated float pages must be substantially filled. Lists keep moderate vertical separation rather than conference-paper-level compression.

PDF output includes numbered bookmarks, language, title, author, subject and keyword metadata, embedded Type 1 fonts, Unicode character mapping and improved URL line breaking. Set subject and keywords in `example.tex` with `\subject{...}` and `\keywords{...}`.

Official guidance: https://www.liverpool.ac.uk/study/academic-quality-and-standards-division/academic-codes-of-practice/postgraduate-research-code-of-practice/
# University-of-Liverpool-Unofficial-Thesis-Template
# University-of-Liverpool-Unofficial-Thesis-Template
