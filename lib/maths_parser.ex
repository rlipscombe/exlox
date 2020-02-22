defmodule Exlox.MathsParser do
  import NimbleParsec

  nat = integer(min: 1)

  defparsec(:parse, nat)
end
