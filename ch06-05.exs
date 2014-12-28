# Write a function gcd(x,y) that finds the greatest common divisor between two
# nonnegative integers. Algebraically, gcd(x,y) is x if y is zero; it’s gcd(y,
# rem(x,y)) otherwise.

defmodule Math do
  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))
end

ExUnit.start

defmodule Ch06.Test do
  use ExUnit.Case

  test "Math.gcd/2" do
    assert 2 === Math.gcd(4, 2)
    assert 2 === Math.gcd(2, 4)
    assert 7 === Math.gcd(49, 28)
    assert 4 === Math.gcd(142532, 2313524)
  end
end
