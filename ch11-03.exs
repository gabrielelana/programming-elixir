# Write a function that takes a single-quoted string of the form number [+-*/]
# number and returns the result of the calculation. The individual numbers do
# not have leading plus or minus signs.
#
# > calculate('123 + 27') # => 150

defmodule Programming.Elixir do

  def calculate(expression) do
    {ln, expression} = number(expression)
    {op, expression} = operator(expression)
    {rn, _}          = number(expression)
    apply(Kernel, op, [ln, rn])
  end

  def number(expression), do: number(expression, '')
  def number([h|t], n) when h === ?\s, do: number(t, n)
  def number([h|t], n) when h in ?0..?9, do: number(t, [h|n])
  def number(expression, n) do
    {n |> Enum.reverse |> List.to_integer, expression}
  end

  def operator([h|t]) when h === ?\s, do: operator(t)
  def operator([h|t]) when h in [?+, ?-, ?*, ?/] do
    {[h] |> List.to_atom, t}
  end

  ExUnit.start

  defmodule Test do
    use ExUnit.Case

    test "number/1" do
      assert Programming.Elixir.number('10') == {10, ''}
      assert Programming.Elixir.number('10 + 10') == {10, '+ 10'}
      assert Programming.Elixir.number('123456') == {123456, ''}
    end

    test "operator/1" do
      assert Programming.Elixir.operator('+') == {:+, ''}
      assert Programming.Elixir.operator(' + 10') == {:+, ' 10'}
    end

    test "calculate/1" do
      assert Programming.Elixir.calculate('123 + 27') == 150
    end
  end
end
