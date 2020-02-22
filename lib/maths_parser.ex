defmodule Exlox.MathsParser do
  import NimbleParsec
  import Exlox.Parser.Helpers

  bin_op = ascii_char([?+]) |> replace(:+)

  defcombinatorp(
    :sum,
    integer(min: 1)
    |> repeat(bin_op |> integer(min: 1))
    |> reduce(:fold_infixl)
  )

  defparsec(
    :parse,
    parsec(:sum)
  )
end
