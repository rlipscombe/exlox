defmodule Exlox.ParserTest do
  use ExUnit.Case

  defp parse(input) do
    Exlox.Parser.parse(input) |> unwrap
  end

  defp unwrap({:ok, [acc], "", _, _, _}), do: acc
  #defp unwrap({:ok, _, rest, _, _, _}), do: {:error, "could not parse '" <> rest <> "'"}
  defp unwrap({:error, reason, _rest, _, _, _}), do: {:error, reason}

  @err "expected boolean while processing !, " <>
         "followed by factor or (, followed by expr, followed by ) or boolean"

  test "parses quoted strings" do
    assert {:quoted_string, ["Hello World"]} == Exlox.Parser.quoted_string(~S("Hello World")) |> unwrap
  end

  # test "parses consts" do
  #   assert true == parse("true")
  #   assert false == parse("false")
  #   assert {:error, @err} = parse("1")
  # end

  # test "parses negations" do
  #   assert {:!, [true]} == parse("!true")
  #   assert {:!, [false]} == parse("!false")
  # end

  # test "parses double negations" do
  #   assert {:!, [{:!, [true]}]} == parse("!!true")
  #   assert {:!, [{:!, [false]}]} == parse("!!false")
  # end

  # test "parses conjunctions" do
  #   assert {:&&, [true, false]} == parse("true&&false")
  #   assert {:&&, [false, true]} == parse("false&&true")

  #   assert {:&&, [{:&&, [true, false]}, true]} == parse("true&&false&&true")
  # end

  # test "parses disjunctions" do
  #   assert {:||, [true, false]} == parse("true||false")
  #   assert {:||, [false, true]} == parse("false||true")

  #   assert {:||, [{:&&, [true, false]}, true]} == parse("true&&false||true")
  # end

  # test "parses groups" do
  #   assert {:&&, [true, {:||, [false, true]}]} == parse("true&&(false||true)")
  # end
end
