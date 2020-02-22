defmodule Exlox.QuotedStringParserTest do
  use ExUnit.Case

  defp unwrap({:ok, [acc], "", _, _, _}), do: acc
  # defp unwrap({:ok, _, rest, _, _, _}), do: {:error, "could not parse '" <> rest <> "'"}
  defp unwrap({:error, reason, _rest, _, _, _}), do: {:error, reason}

  test "parses quoted strings" do
    assert {:quoted_string, ["Hello World"]} ==
             Exlox.QuotedStringParser.quoted_string(~S("Hello World")) |> unwrap
  end
end
