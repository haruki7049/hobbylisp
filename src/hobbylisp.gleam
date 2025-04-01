import gleam/int
import gleam/io
import hobbylisp/lexer as hl_lexer
import hobbylisp/parser as hl_parser
import nibble
import nibble/lexer

pub fn main() {
  let assert Ok(tokens) = lexer.run("(+ 1 2)", hl_lexer.lexer())
  let assert Ok(value) = nibble.run(tokens, hl_parser.parser())

  io.println(
    value
    |> int.to_string(),
  )
}
