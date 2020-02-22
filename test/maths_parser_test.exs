defmodule Exlox.MathsParserTest do
  use ExUnit.Case

  defp unwrap({:ok, ast, "", _, _, _}), do: ast

  test "single integer" do
    # TODO: Why is it in a list?
    assert [1] == Exlox.MathsParser.parse("1") |> unwrap
  end

  test "simple addition" do
    assert {:+, [1, 2]} == Exlox.MathsParser.parse("1+2") |> unwrap
  end
end
