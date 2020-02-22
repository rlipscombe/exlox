defmodule Exlox.MathsParser do
  import NimbleParsec

  sum = integer(min: 1) |> ascii_char([?+]) |> integer(min: 1)

  defparsec(
    :parse,
    sum
  )
end
