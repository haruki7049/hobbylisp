import hobbylisp/token.{type Token}
import nibble/lexer

pub fn lexer() -> lexer.Lexer(Token, Nil) {
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
