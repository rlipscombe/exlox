defmodule Exlox.MathsParser do
  import NimbleParsec

  nat = integer(min: 1) |> label("integer")
  # expr = nat |> ascii_char(?+) |> nat

  defparsec(:parse, nat)
end
