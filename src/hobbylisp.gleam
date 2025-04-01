import gleam/int
import gleam/io
import gleam/option.{None, Some}
import nibble
import nibble/lexer

pub type Token {
  Num(Int)
  Plus
  Minus
  LParen
  RParen
}

pub fn parser() {
  use _ <- nibble.do(nibble.token(LParen))
  use function <- nibble.do(function_parser())
  use x <- nibble.do(int_parser())
  use y <- nibble.do(int_parser())
  use _ <- nibble.do(nibble.token(RParen))

  case function {
    Plus -> nibble.return(x + y)
    Minus -> nibble.return(x - y)
    _ -> panic
  }
}

pub fn lexer() {
  lexer.simple([
    lexer.int(Num),
    lexer.token("(", LParen),
    lexer.token(")", RParen),
    lexer.token("+", Plus),
    lexer.token("-", Minus),
    lexer.whitespace(Nil)
      |> lexer.ignore,
  ])
}

pub fn int_parser() -> nibble.Parser(Int, Token, a) {
  use tok <- nibble.take_map("expected number")
  case tok {
    Num(n) -> Some(n)
    _ -> None
  }
}

pub fn function_parser() -> nibble.Parser(Token, Token, a) {
  use tok <- nibble.take_map("expected + or -")
  case tok {
    Plus -> Some(Plus)
    Minus -> Some(Minus)
    _ -> None
  }
}

pub fn main() {
  let assert Ok(tokens) = lexer.run("(+ 1 2)", lexer())
  let assert Ok(value) = nibble.run(tokens, parser())

  io.println(
    value
    |> int.to_string(),
  )
}
