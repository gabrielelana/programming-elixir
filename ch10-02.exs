# Write a flatten(list) function that takes a list that may contain any number
# of sublists, which themselves may contain sublists, to any depth. It returns
# the elements of these lists as a flat list.

# iex> MyList.flatten([ 1, [ 2, 3, [4] ], 5, [[[6]]]])
# [1,2,3,4,5,6]


defmodule Programming.Elixir do
  defmodule List do
    @doc """
    Flattens the given list of nested lists.
    """

    @spec flatten(nested_list) :: list when nested_list: [any | nested_list]
    def flatten(l), do: flatten(l, [])

    @spec flatten(nested_list, list) :: list when nested_list: [any | nested_list]
    def flatten([h|t], flat) when is_list(h), do: flatten(h, flatten(t, flat))
    def flatten([h|t], flat), do: [h|flatten(t, flat)]
    def flatten([], flat), do: flat
  end

  ExUnit.start

  defmodule Test do
    use ExUnit.Case

    test "List.flatten/1" do
      assert [] === List.flatten([])
      assert [1] === List.flatten([1])
      assert [1] === List.flatten([[1]])
      assert [1] === List.flatten([[[[[1]]]]])
      assert [1,2] === List.flatten([[[[1]]], [2]])
      assert [1,2,3,4,5,6] === List.flatten([1, [2, 3, [4]], 5, [[[6]]]])
    end
  end
end
