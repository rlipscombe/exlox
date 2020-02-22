defmodule Exlox.Parser.Helpers do
  @doc """
  Converts a sequence of infix operators into a left-associative(?) AST.
  Examples:
    [true, :&&, false] is converted to {:&&, true, false}
    [true, :&&, false, :&&, true] is converted to {:&&, [{:&&, [true, false]}, true]}
  """
  def fold_infixl(acc) do
    acc
    |> Enum.reverse()
    |> Enum.chunk_every(2)
    |> List.foldr([], fn
      [l], [] -> l
      [r, op], l -> {op, [l, r]}
    end)
  end
end
