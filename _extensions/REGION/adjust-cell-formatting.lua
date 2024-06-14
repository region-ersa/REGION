--- This LUA filter is applied to all "Div" elements with a class of "cell-output"
--- (the output of R code chunks). It wraps this element in a LaTeX environment 
--- "ROutput". At the moment, this environment is defined in the partial "title.tex"
--- for the REGION template. One may expand this definition, or develop a PERL-script
--- that replaces this environment and the "verbatim" with the necessary code.

function Div(elem)
  if (elem.classes:includes "cell-output") then
    return {
      pandoc.RawInline('latex', '\\begin{ROutput}'),
      elem,
      pandoc.RawInline('latex', '\\end{ROutput}')
    }
  end
end

