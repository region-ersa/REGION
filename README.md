# Article Format Template (AFT)

This repository contains a Quarto template that assists you in creating a manuscript for
REGION. The lines below describes how to use this repository. 

You can learn more about REGION at <https://region.ersa.org>

## Creating a New Article

Next, use our template to create an article for REGION. To do
this, use the following command on the terminal on RStudio:

``` bash
quarto use template region-ersa/REGION
```
After you run this, you will be asked:

``` bash
? Do you trust the authors of this template (Y/n)
```
Type "Y" and:

``` bash
? Directory name:
```
Type the directory where you would like to store the template.

These lines will install the extension and create an example qmd file and
bibliography that you can use as a starting place for your article.

## Installation For Existing Document

Next, run the following command from the terminal to install this format:

``` bash
quarto add region-ersa/REGION
```
After running this command, you will be asked:

``` bash
? Do you trust the authors of this extension (Y/n) ›
```

Type "Y".

``` bash
? Would you like to continue (Y/n) ›
```

Type "Y".

``` bash
? View documentation using default browser? (Y/n) ›
```

Type "n"

## Usage

Go to the directory where you saved the template and use the qmd file you will find there. 

Open this file in RStudio and render it.

You can render it by clicking "Render" or by typing:

``` bash
quarto render [.qmd file] --to [.pdf file]
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

------------------------------------------------------------------------

### Options for the production editor

The production editor of REGION can use the following options in the
production of the final PDF-document. The author can set these options
for testing purposes, but should be aware that they will be changed in
production editing. The options for the production editor are the following:

------------------------------------------------------------------------

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

# Code chunk formatting

The template also applies two lua-filters that wrap code chunk input and 
output into special formatting. In the standard PDF-output, input elements
show a grey background, output elements a reddish background. The template
also provides a PERL-script named `adjust_code_tex.pl` that changes this
formatting to the type of code chunk formatting we need for REGION. With
a PERL interpreter available, just call this script, specify input and 
output file (both tex-files), and compile the output tex-file to PDF. For
more details see the comments in `adjust_code_tex.pl`. The script also 
makes some other small adjustments.