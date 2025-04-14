import hobbylisp/keywords.{type Token}
import nibble/lexer

pub fn lexer() -> lexer.Lexer(Token, Nil) {
  lexer.simple([
    lexer.int(keywords.Num),
    lexer.token("(", keywords.LParen),
    lexer.token(")", keywords.RParen),
    lexer.token("+", keywords.Plus),
    lexer.token("-", keywords.Minus),
    lexer.whitespace(Nil)
      |> lexer.ignore,
  ])
}
