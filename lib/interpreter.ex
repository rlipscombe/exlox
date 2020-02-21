defmodule Exlox.Interpreter do
  # TODO: Why sometimes a list, sometimes not?
  def run([true]), do: true
  def run([false]), do: false
  def run([{:!, factor}]), do: not run(factor)
  def run([{:&&, [lhs, rhs]}]), do: run([lhs]) && run([rhs])
  def run([{:||, [lhs, rhs]}]), do: run([lhs]) && run([rhs])
end
