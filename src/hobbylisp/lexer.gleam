import hobbylisp/token
import nibble/lexer

pub fn lexer() {
  lexer.simple([
    lexer.int(token.Num),
    lexer.token("(", token.LParen),
    lexer.token(")", token.RParen),
    lexer.token("+", token.Plus),
    lexer.token("-", token.Minus),
    lexer.whitespace(Nil)
      |> lexer.ignore,
  ])
}
