defmodule Exlox.MathsParser do
  import NimbleParsec
  import Exlox.Parser.Helpers

  constant = integer(min: 1)

  plus_ = ascii_char([?+]) |> replace(:+)
  minus_ = ascii_char([?-]) |> replace(:-)
  plusminus_ = choice([plus_, minus_])

  mul_ = ascii_char([?*]) |> replace(:*)
  div_ = ascii_char([?/]) |> replace(:/)
  muldiv_ = choice([mul_, div_])

  lparen = ascii_char([?(]) |> label("(")
  rparen = ascii_char([?)]) |> label(")")
  grouping = ignore(lparen) |> parsec(:expr) |> ignore(rparen)

  defcombinatorp(:factor, choice([constant, grouping]))

  defcombinatorp(
    :term,
    parsec(:factor)
    |> repeat(plusminus_ |> parsec(:factor))
    |> reduce(:fold_infixl)
  )

  defparsec(
    :expr,
    parsec(:term)
    |> repeat(muldiv_ |> parsec(:term))
    |> reduce(:fold_infixl)
  )

  defparsec(
    :parse,
    parsec(:expr)
  )
end
