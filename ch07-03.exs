# Write a max(list) that returns the element with the maximum value in the list.
# (This is slightly trickier than it sounds.)

defmodule MyList do

  def mapsum(l, f), do: reduce(l, 0, fn(value, acc) -> acc + f.(value) end)

  def max(l) do
    reduce(l, &Kernel.max(&1, &2))
  end

  def reduce([], _), do: raise "Empty list cannot be reduced without an initial value"
  def reduce([h|t], f), do: reduce(t, h, f)

  def reduce([], value, _), do: value
  def reduce([h|t], value, f), do: reduce(t, f.(h, value), f)
end

ExUnit.start

defmodule Ch07.Test do
  use ExUnit.Case

  test "MyList.max/1" do
    assert 3 === MyList.max [1, 2, 3]
    assert -3 === MyList.max [-10, -20, -3]
    assert 0 === MyList.max [0, -1, -2, -3]
    assert_raise RuntimeError, fn -> MyList.max [] end
  end
end
