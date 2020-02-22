defmodule Exlox.MathsParser do
  import NimbleParsec

  bin_op = ascii_char([?+])

  defcombinatorp(
    :sum,
    integer(min: 1)
    |> repeat(bin_op |> integer(min: 1))
  )

  defparsec(
    :parse,
    parsec(:sum)
  )
end
