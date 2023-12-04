---
editor_options: 
  markdown: 
    wrap: 72
---

# Article Format Template (AFT)

This is a Quarto template that assists you in creating a manuscript for
REGION. You can learn more about REGION as <https://region.ersa.org>

## Creating a New Article

You can use this as a template to create an article for REGION. To do
this, use the following command:

``` bash
quarto use template gunthermaier/REGION
```

This will install the extension and create an example qmd file and
bibiography that you can use as a starting place for your article.

## Installation For Existing Document

You may also use this format with an existing Quarto project or
document. From the quarto project or document directory, run the
following command to install this format:

``` bash
quarto add gunthermaier/REGION
```

## Usage

To use the format, you can use the format names `REGION-pdf` and
`REGION-html`. For example:

``` bash
quarto render article.qmd --to REGION-pdf
```

or in your document yaml

``` yaml
format:
  pdf: default
  REGION-pdf:
    keep-tex: true    
```

You can view a preview of the rendered template at
<https://quarto-journals.github.io/article-format-template/>.

## Format Options

This format supports the following options:

------------------------------------------------------------------------

### `title`

The standard option defining the title.

------------------------------------------------------------------------

### `format`

The standard option defining the format. To format for REGION (pdf and
LaTeX), use the sub-option `REGION-pdf` and the sub-sub-option
`keep-tex: true`. A specific sub-sub-option is `docstatus`.

------------------------------------------------------------------------

### `docstatus`

This sub-sub-option can be set to

-   `final` (default): This produces a fully formatted paper with header
    and author(s).
-   `draft`: This option suppresses the output of figures, including the
    header.
-   `review`: This option suppresses the output of the author(s)

------------------------------------------------------------------------

### `author`

The standard option for defining one or more authors. For every author
specify the sub-options `name` and `affiliations`. `name` is the name of
the author.

------------------------------------------------------------------------

### `affiliations`

This sub-option to `author` specifies the respective author's
affiliation(s). For every affiliation use the sub-sub-options `name`
(for the name of the organization, e.g., "University of Liverpool"),
`city` and `country` (for the city and the country where the affiliation
is located).

------------------------------------------------------------------------

### `abstract`

This standard option defines the abstract.

------------------------------------------------------------------------

### `bibliography`

This standard option defines the name of the bib-file that contains the
bibliography.

## ------------------------------------------------------------------------

### Options for the production editor

The production editor of REGION can use the following options in the
production of the final PDF-document. The author can set these options
for testing purposes, but should be aware that they will be changed in
production editing. The options for the production editor are the following:

## ------------------------------------------------------------------------

### `ojsnum`

This option specifies the document number in the OJS implementation of
REGION. The number is set automatically by OJS when an article is
submitted. It is used in the construction of the article's DOI-code.

------------------------------------------------------------------------

### `jvol`

The volume number of the published article. The information is used in
the construction of the article's DOI-code.

------------------------------------------------------------------------

### `jnum`

The issue number of the published article. The information is used in
the construction of the article's DOI-code.

------------------------------------------------------------------------

### `jpages`

The range of pages of the article. This information is used in the
header of the article.

------------------------------------------------------------------------

### `jyear`

The year of publication of the article. This information is used in the
header of the article.

------------------------------------------------------------------------

### `jauthor`

A short list (first names abbreviated) of the authors for the page
headings.

------------------------------------------------------------------------

### `received`

The date when the article was submitted to REGION (e.g., January 1,
2024)

------------------------------------------------------------------------

### `accepted`

The date when the article was accepted by REGION for publication (e.g.,
January 2, 2024)

------------------------------------------------------------------------
