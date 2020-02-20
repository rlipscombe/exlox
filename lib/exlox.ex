defmodule Exlox do
  @spec hello :: :ok
  def hello do
    run(~S"""
    print("Hello World");
    """)
  end

  @spec run(String.t()) :: :ok
  def run(source) do
    Exlox.Parser.parse(source) |> IO.inspect
  end
end
