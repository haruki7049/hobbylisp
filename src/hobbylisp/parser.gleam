import gleam/option.{None, Some}
import hobbylisp/keywords.{type Token}
import nibble.{type Parser}

pub fn parser() -> Parser(Int, Token, Nil) {
  use _ <- nibble.do(nibble.token(keywords.LParen))
  use function <- nibble.do(function_parser())
  use x <- nibble.do(int_parser())
  use y <- nibble.do(int_parser())
  use _ <- nibble.do(nibble.token(keywords.RParen))

  case function {
    keywords.Plus -> nibble.return(x + y)
    keywords.Minus -> nibble.return(x - y)
    _ -> panic
  }
}

pub fn int_parser() -> nibble.Parser(Int, Token, a) {
  use tok <- nibble.take_map("expected number")
  case tok {
    keywords.Num(n) -> Some(n)
    _ -> None
  }
}

pub fn function_parser() -> nibble.Parser(Token, Token, a) {
  use tok <- nibble.take_map("expected + or -")
  case tok {
    keywords.Plus -> Some(keywords.Plus)
    keywords.Minus -> Some(keywords.Minus)
    _ -> None
  }
}
