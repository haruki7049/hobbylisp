import gleam/option.{None, Some}
import hobbylisp/token.{type Token}
import nibble

pub fn parser() {
  use _ <- nibble.do(nibble.token(token.LParen))
  use function <- nibble.do(function_parser())
  use x <- nibble.do(int_parser())
  use y <- nibble.do(int_parser())
  use _ <- nibble.do(nibble.token(token.RParen))

  case function {
    token.Plus -> nibble.return(x + y)
    token.Minus -> nibble.return(x - y)
    _ -> panic
  }
}

pub fn int_parser() -> nibble.Parser(Int, Token, a) {
  use tok <- nibble.take_map("expected number")
  case tok {
    token.Num(n) -> Some(n)
    _ -> None
  }
}

pub fn function_parser() -> nibble.Parser(Token, Token, a) {
  use tok <- nibble.take_map("expected + or -")
  case tok {
    token.Plus -> Some(token.Plus)
    token.Minus -> Some(token.Minus)
    _ -> None
  }
}
