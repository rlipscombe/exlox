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

  true_ = string("true") |> replace(true) |> label("true")
  false_ = string("false") |> replace(false) |> label("false")
  const = choice([true_, false_]) |> label("boolean")

  negation = not_ |> ignore |> parsec(:factor) |> tag(:!)

  defcombinatorp(:factor, choice([negation, const]))

  defcombinatorp(
    :term,
    parsec(:factor)
    |> repeat(and_ |> parsec(:factor))
    |> reduce(:fold_infixl)
  )

  defparsec(:parse, parsec(:term))
end
