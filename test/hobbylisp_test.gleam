import gleeunit
import gleeunit/should
import hobbylisp/lexer as hl_lexer
import hobbylisp/parser as hl_parser
import nibble
import nibble/lexer

pub fn main() {
  gleeunit.main()
}

pub fn hobbylisp_recurse_sexp_test() {
  let assert Ok(tokens) = lexer.run("(+ 1 (+ 1 2))", hl_lexer.lexer())
  let assert Ok(value) = nibble.run(tokens, hl_parser.parser())

  value
  |> should.equal(4)

  // With whitespaces
  let assert Ok(tokens) = lexer.run("( + 1 ( + 1 2 ) )", hl_lexer.lexer())
  let assert Ok(value) = nibble.run(tokens, hl_parser.parser())

  value
  |> should.equal(4)

  // Using Minus
  let assert Ok(tokens) = lexer.run("( - 1 ( - 1 2 ) )", hl_lexer.lexer())
  let assert Ok(value) = nibble.run(tokens, hl_parser.parser())

  value
  |> should.equal(-2)
}

pub fn hobbylisp_test() {
  let assert Ok(tokens) = lexer.run("(+ 1 2)", hl_lexer.lexer())
  let assert Ok(value) = nibble.run(tokens, hl_parser.parser())

  value
  |> should.equal(3)

  // With whitespaces
  let assert Ok(tokens) = lexer.run("( + 1 2 )", hl_lexer.lexer())
  let assert Ok(value) = nibble.run(tokens, hl_parser.parser())

  value
  |> should.equal(3)

  // Using Minus
  let assert Ok(tokens) = lexer.run("( - 1 2 )", hl_lexer.lexer())
  let assert Ok(value) = nibble.run(tokens, hl_parser.parser())

  value
  |> should.equal(-1)
}
