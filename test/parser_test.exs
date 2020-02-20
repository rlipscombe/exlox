defmodule Exlox.ParserTest do
  use ExUnit.Case

  defp parse(input) do
    Exlox.Parser.parse(input) |> unwrap
  end

  defp unwrap({:ok, [acc], "", _, _, _}), do: acc
  defp unwrap({:error, reason, _rest, _, _, _}), do: {:error, reason}

  @err "expected boolean while processing !, followed by factor or boolean"

  test "parses consts" do
    assert true == parse("true")
    assert false == parse("false")
    assert {:error, @err} = parse("1")
  end

  test "parses negations" do
    assert {:!, [true]} == parse("!true")
    assert {:!, [false]} == parse("!false")
  end

  test "parses double negations" do
    assert {:!, [{:!, [true]}]} == parse("!!true")
    assert {:!, [{:!, [false]}]} == parse("!!false")
  end
end
