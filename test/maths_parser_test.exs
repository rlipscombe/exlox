defmodule Exlox.MathsParserTest do
  use ExUnit.Case

  defp unwrap({:ok, ast, "", _, _, _}), do: ast

  test "single integer" do
    # It's in a list, because each piece of the parser returns its bit separately.
    assert [1] == Exlox.MathsParser.parse("1") |> unwrap
  end

  test "simple addition" do
    assert [{:+, [1, 2]}] == Exlox.MathsParser.parse("1+2") |> unwrap
    assert [{:+, [{:+, [1, 2]}, 3]}] == Exlox.MathsParser.parse("1+2+3") |> unwrap
  end

  test "simple subtraction" do
    assert [{:-, [2, 3]}] == Exlox.MathsParser.parse("2-3") |> unwrap
    # subtraction is left-associative
    assert [{:-, [{:-, [2, 3]}, 4]}] == Exlox.MathsParser.parse("2-3-4") |> unwrap
    assert [{:-, [{:-, [2, 3]}, 4]}] == Exlox.MathsParser.parse("(2-3)-4") |> unwrap
  end

  test "simple multiplication" do
    assert [{:*, [2, 3]}] == Exlox.MathsParser.parse("2*3") |> unwrap
    assert [{:*, [{:*, [2, 3]}, 4]}] == Exlox.MathsParser.parse("2*3*4") |> unwrap
    assert [{:*, [{:*, [2, 3]}, 4]}] == Exlox.MathsParser.parse("(2*3)*4") |> unwrap
  end

  test "simple division" do
    assert [{:/, [2, 3]}] == Exlox.MathsParser.parse("2/3") |> unwrap
    assert [{:/, [{:/, [2, 3]}, 4]}] == Exlox.MathsParser.parse("2/3/4") |> unwrap
    assert [{:/, [{:/, [2, 3]}, 4]}] == Exlox.MathsParser.parse("(2/3)/4") |> unwrap
  end

  test "operator precedence" do
    assert [{:+, [2, {:*, [3, 4]}]}] = Exlox.MathsParser.parse("2+3*4") |> unwrap
  end

  test "grouping" do
    assert [{:*, [{:+, [2, 3]}, 4]}] = Exlox.MathsParser.parse("(2+3)*4") |> unwrap
    assert [{:+, [2, {:*, [3, 4]}]}] = Exlox.MathsParser.parse("2+(3*4)") |> unwrap
    assert [{:+, [{:*, [3, 4]}, 2]}] = Exlox.MathsParser.parse("(3*4)+2") |> unwrap
  end
end
