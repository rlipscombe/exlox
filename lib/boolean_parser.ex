defmodule Exlox.BooleanParser do
  import NimbleParsec
  import Exlox.Parser.Helpers

  not_ = string("!") |> label("!")

  and_ = string("&&") |> replace(:&&) |> label("&&")
  or_ = string("||") |> replace(:||) |> label("||")

  lparen = ascii_char([?(]) |> label("(")
  rparen = ascii_char([?)]) |> label(")")

  true_ = string("true") |> replace(true) |> label("true")
  false_ = string("false") |> replace(false) |> label("false")
  const = choice([true_, false_]) |> label("boolean")

  negation = not_ |> ignore |> parsec(:factor) |> tag(:!)
  grouping = ignore(lparen) |> parsec(:expr) |> ignore(rparen)

  defcombinatorp(:factor, choice([negation, grouping, const]))

  defcombinatorp(
    :term,
    parsec(:factor)
    |> repeat(and_ |> parsec(:factor))
    |> reduce(:fold_infixl)
  )

  defparsec(
    :expr,
    parsec(:term)
    |> repeat(or_ |> parsec(:term))
    |> reduce(:fold_infixl)
  )
end
