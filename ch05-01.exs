ExUnit.start

defmodule Ch05.Test do
  use ExUnit.Case

  test "list_concat" do
    list_concat = fn(ll, rl) -> ll ++ rl end
    assert [:a, :b, :c, :d] === list_concat.([:a, :b], [:c, :d])
  end

  test "sum" do
    sum = fn(n1, n2, n3) -> n1 + n2 + n3 end
    assert 6 === sum.(1, 2, 3)
  end

  test "pair_tuple_to_list" do
    pair_tuple_to_list = fn({a, b}) -> [a, b] end
    assert [1234, 5678] === pair_tuple_to_list.({1234, 5678})
  end
end
