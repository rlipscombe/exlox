defmodule Exlox.MathsParserTest do
  use ExUnit.Case

  defp unwrap({:ok, ast, "", _, _, _}), do: ast

  test "it" do
    # TODO: Why is it in a list?
    assert [1] == Exlox.MathsParser.parse("1") |> unwrap
  end
end
