defmodule Exlox.Parser.Helpers do
  @doc """
  Converts a sequence of infix operators into a left-associative(?) AST.
  Examples:
    [true, :&&, false] is converted to {:&&, true, false}
    [true, :&&, false, :&&, true] is converted to {:&&, [{:&&, [true, false]}, true]}
  """
  def fold_infixl(acc) do
    acc
    |> Enum.reverse()
    |> Enum.chunk_every(2)
    |> List.foldr([], fn
      [l], [] -> l
      [r, op], l -> {op, [l, r]}
    end)
  end
end

defmodule Exlox.Parser do
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

  defcombinatorp(
    :expr,
    parsec(:term)
    |> repeat(or_ |> parsec(:term))
    |> reduce(:fold_infixl)
  )

  defparsec(
    :quoted_string,
    ignore(ascii_char([?"]))
    |> repeat(
      lookahead_not(ignore(ascii_char([?"])))
      |> utf8_char([])
    )
    |> ignore(ignore(ascii_char([?"])))
    |> reduce({List, :to_string, []})
    |> label("quoted string")
    |> tag(:quoted_string)
  )

  defparsec(:parse, parsec(:quoted_string))
end
