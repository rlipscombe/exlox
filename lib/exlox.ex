defmodule Exlox do
  def run(source) do
    Exlox.Parser.parse(source) |> unwrap |> Exlox.Interpreter.run
  end

  defp unwrap({:ok, ast, _rest, _, _, _}), do: ast
end
