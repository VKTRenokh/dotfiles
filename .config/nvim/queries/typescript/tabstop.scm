(lexical_declaration
  (variable_declarator
    name: (identifier) @tabstop))

(arrow_function
  parameters: (formal_parameters) @tabstop
  body: (statement_block) @tabstop)

(call_expression
  function: (identifier) @tabstop
  arguments: (arguments) @tabstop)

(pair 
  key: (property_identifier) @tabstop
  value: _ @tabstop)
