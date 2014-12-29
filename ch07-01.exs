# Write a mapsum function that takes a list and a function. It applies the
# function to each element of the list and then sums the result, so
#
# iex> MyList.mapsum [1, 2, 3], &(&1 * &1)
# 14

defmodule MyList do

  def mapsum(l, f), do: reduce(l, 0, fn(value, acc) -> acc + f.(value) end)

  def reduce([], value, _), do: value
  def reduce([h|t], value, f), do: reduce(t, f.(h, value), f)
end

ExUnit.start

defmodule Ch07.Test do
  use ExUnit.Case

  test "MyList.mapsum/3" do
    assert 14 === MyList.mapsum [1, 2, 3], &(&1 * &1)
  end
end
