#!/usr/bin/perl;

## =====================================================================================================================
## This script takes the TEX-file produced as an intermediate output from Quarto and changes it such that it confirms to
## the housestyle of REGION with respect of formatting code-chunk inputs and outputs.
## ----------------------------------------------------------
## In a first step, I check for the names of input and output files, request them, if they are not given properly in the
## program call. In Windows, parameters are only passed to @ARGV when the program is EXPLICITLY called with "perl", i.e.,
## "perl convert.pl <ARGS>".
## Infile and outfile can be specified with "in=" and "out=" or by position where the first parameter is the infile and 
## the second one is the outfile.
## The script outputs the names of the files and lets you interrupt if this is not OK.
## ----------------------------------------------------------
## In the second step, the script reads the whole infile into one string, splits it into the respective parts and 
## adjusts them accordingly.
## The following changes are made:
##   1. In the header (everything before \begin{document}), the theoremstyle "myexample" is defined and assigned to
##      the theorem "example".
##   2. Also in the header, the correct path is added to "\bibliographystyle{}".
##   3. In the body (everything after \begin{document}), I identify the code chunks as everything between \begin{RInput}
##      and \end{RInput} and send this to the subroutine "process_code_chunk". This subroutine replaces the current
##      LaTeX code with the required one in a series of regex commands.
## The produced LaTeX file increments the counter "code" every time it processes a code-chunk input. This way, the 
## code-chunk input and the (possibly) following output have the same number. Use the LaTeX commands \stepcounter{code}
## and \setcounter{code} in the qmd file when you need other numbers.
## =====================================================================================================================

# Catch a Ctrl-C
$SIG{INT} = \&interrupt;
$SIG{TERM} = \&interrupt;

sub interrupt {
    print STDERR "Aborted\n";
    exit; 
}

# Empty input and output files.
my $input_file  = "";
my $output_file = "";

# Check for arguments in the program call
if (@ARGV) {
    my $i = 0;
    foreach my $a (@ARGV) {  ## loop through arguments
        $i++;
        if ($a =~ /=/) {  ## if argument contains an equal sign, assign by key
            my ($key, $val) = split(/\s*=\s*/, $a);
            if ($key =~ /^in$/i) { $input_file = $val; }
            if ($key =~ /^out$/i) { $output_file = $val; }
        } else {  ## otherwise assign by position
            if ($i == 1) { $input_file = $a; } else { $output_file = $a; }
        }
    }
} else {  ## when there are no arguments in the program call, request the information.
    print "Cannot find any arguments in the program call.\n";
    print "You may need to explicitly use 'perl filename <ARGS>'\n";
    print "Alternatively, you can specify the input and output below:\n";
    print "\tInput File: ";
    $input_file = <stdin>;                   ## read name of input file
    chop($input_file);
    if ($input_file eq "") { exit(0); }      ## exit when empty.
    print "\tOutput File: ";
    $output_file = <stdin>;                  ## read name of output file 
    chop($output_file);
    if ($output_file eq "") { exit(0); }     ## exit when ampty.
#    print "IN : $input_file\n";
#    print "OUT: $output_file\n";
}

#print "IN : $input_file\n";
#print "OUT: $output_file\n";

# Double check for empty input or output file names. Exit when empty.
if ($input_file eq "") {
    print "NO INPUT FILE SPECIFIED! ";
    exit(0);
}
if ($output_file eq "") {
    print "NO OUTPUT FILE SPECIFIED! ";
    exit(0);
}

# Check whether the specified input or output file exists. 
my $input_file_info = " DOES NOT EXIST!!";
if (-e $input_file) { $input_file_info = " EXISTS"} else {print "INPUT FILE DOES NOT EXIST!!"; exit(0); }
my $output_file_info = " WILL BE CREATED";
if (-e $output_file) { $output_file_info = " WILL BE OVERWRITTEN!!"}
print "INFILE:  $input_file$input_file_info\nOUTFILE: $output_file$output_file_info\n\n";  ## output the info
print "Press ^C to abort, any other key to continue: ";   ## allow to abort
my $dummy = <stdin>;
sleep(0.5);

## -------------------------------------------------------------

# read the input file into one string
open my $fh, '<', $input_file or die "Can't open file $!";
my $file_content = do { local $/; <$fh> };

# open the output file
open (OUT, ">$output_file");

# split into header and body
my ($header, $body) = split(/\\begin{document}/, $file_content);
print OUT &process_header($header); ## call the sub to process the header, print the result to OUT
print OUT "\\begin{document}";      ## print the line that was filtered out in the split to OUT
print OUT &process_body($body);     ## call the sub to process the body, print the result to OUT
print "DONE!\n";
##
## The following subroutine adjusts the header
##
sub process_header {
    my $txt = shift;
    my @parts = split(/\\usepackage{amsthm}/, $txt);   ## split the header
    $txt = $parts[0]."\\usepackage{amsthm}\n";         ## add the command used in the split
    $txt = $txt."
\\newtheoremstyle{myexample}% 〈name〉
{5pt}% 〈Space above〉1
{5pt}% 〈Space below 〉1
{}% 〈Body font〉
{}% 〈Indent amount〉2
{\\bfseries}% 〈Theorem head font〉
{:}% 〈Punctuation after theorem head 〉
{.5em}% 〈Space after theorem head 〉3
{}% 〈Theorem head spec (can be left empty, meaning ‘normal’ )〉
\\theoremstyle{myexample}

\\newtheorem{example}{Example}[section]
";                                                     ## add the commands to define the theoremstyle "myexample"
    # remove commands that became obsolete with the new theoremstyle
    $parts[1] =~ s/\\theoremstyle{definition}\n//;     
    $parts[1] =~ s/\\newtheorem{example}{Example}\[section\]\n//;
    # merge parts back into one string
    $txt = $txt.$parts[1];

    # add the correct path to the bibliographystyle 
    $txt =~ s/\\bibliographystyle{region}/\\bibliographystyle{_extensions\/region-ersa\/REGION\/region}/;
    return $txt;  ## return the string
}

## 
## The following subroutine adjusts the body
## 
sub process_body {
    my $txt = shift;                             ## get the body
    my @parts = split(/\\begin{RInput}/, $txt);  ## split it by \begin{RInput}
    foreach my $p (@parts) {                     ## loop through all the parts (each one did begin with \begin{RInput})
        $p = &process_RInput($p);                ## process each part via sub "process_RInput"
    }
    $txt = join("", @parts);                     ## glue all the parts back together
    return $txt;                                 ## return the string to calling routine
}

##
## The following subroutine separates code chunk parts from other
## 
sub process_RInput {
    my $txt = shift;                                     ## get the part
    my @parts = split(/\\end{RInput}/, $txt);            ## splits it by \end{RInput}
    my $nparts = @parts;                                 ## count the number of parts (the first part sent by process_body has only one part)
    if ($nparts == 1) {                                  ## when only one part,
        return $parts[0];                                ## just return it
    } else {                                             ## otherwise (when 2 parts)
        $parts[0] = &process_code_chunk($parts[0]);      ## send the first part (code chunk) to sub process_code_chunk
    }
    $txt = join("", @parts);                             ## glue all the parts back together
    return $txt;                                         ## return the string to calling routine
}

sub process_code_chunk {
    my $txt = shift;
    if ($txt =~ /^\s+$/g) { return ""; }   ## if the chunk contains only whitespace, return an empty string
    ## replace \begin{Shaded} and \end{Shaded}
    $txt =~ s/.?\\begin{Shaded}/\\begin{tcolorbox}[breakable, size=fbox, boxrule=1pt, pad at break*=1mm,colback=cellbackground, colframe=cellborder]\n\\stepcounter{code}\n\\prompt{In}{incolor}{\\arabic{code}}{\\boxspacing}/s;
    $txt =~ s/\\end{Shaded}/\\end{tcolorbox}/;
    $txt =~ s/\\begin{verbatim}\n\n/\\begin{verbatim}\n/s;    ## remove empty lines
    ## replace output environments
    $txt =~ s/\\begin{ROutput}\n?\n?\\begin{verbatim}/\\begin{tcolorbox}[breakable, size=fbox, boxrule=1pt, pad at break*=1mm,colback=celloutbackground, colframe=celloutborder]\n\\prompt{Out}{outcolor}{\\arabic{code}}{\\boxspacing}\n\\begin{Verbatim}[formatcom=\\footnotesize]/s;
    $txt =~ s/\\end{verbatim}\n?\n?\\end{ROutput}/\\end{Verbatim}\n\\end{tcolorbox}/s;
    return $txt;  ## return the string to calling routine
}