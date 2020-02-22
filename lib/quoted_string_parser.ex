defmodule Exlox.QuotedStringParser do
  import NimbleParsec

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
end
