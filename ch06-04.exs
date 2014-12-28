# Implement and run a function sum(n) that uses recursion to calculate the sum of
# the integers from 1 to n. You’ll need to write this function inside a module in
# a separate file. Then load up iex, compile that file, and try your function.

defmodule Math do
  def sum(0), do: 0
  def sum(n), do: n + sum(n - 1)
end

ExUnit.start

defmodule Ch06.Test do
  use ExUnit.Case

  test "Math.sum/1" do
    assert 55 === Math.sum(10)
  end
end
