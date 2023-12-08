(
  ["(" "[" "<" "{"] @_a_start .
  (_) @_start @_end (_)? @_end .
  [")" "]" ">" "}"] @_a_end
  (#make-range! "braces.inner" @_start @_end)
  (#make-range! "braces.around" @_a_start @_a_end)
)

(
  ["'" "\""] @_a_start .
  (_) @_start @_end (_)? @_end .
  ["'" "\""] @_a_end
  (#make-range! "quotes.inner" @_start @_end)
  (#make-range! "quotes.around" @_a_start @_a_end)
)
