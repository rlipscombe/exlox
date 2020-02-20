defmodule Exlox.Parser do
  import NimbleParsec

  not_ = string("!") |> label("!")

  true_ = string("true") |> replace(true) |> label("true")
  false_ = string("false") |> replace(false) |> label("false")
  const = choice([true_, false_]) |> label("boolean")

  negation = not_ |> ignore |> parsec(:factor) |> tag(:!)

  defcombinatorp(:factor, choice([negation, const]))

  defparsec :parse, parsec(:factor)
end
