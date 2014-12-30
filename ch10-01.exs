# Implement the following Enum functions using no library functions or list
# comprehensions: all?, each, filter, split, and take

defmodule Programming.Elixir do
  defmodule Enum do

    @doc """
    Invokes the given fun for each item in the collection and returns false if
    at least one invocation returns false. Otherwise returns true.
    """
    @spec all?(Enumberable.t) :: boolean
    def all?(collection, fun \\ fn x -> x end)

    @spec all?(Enumberable.t, (any -> boolean)) :: boolean
    def all?([], _), do: true
    def all?([h|t], fun), do: fun.(h) and all?(t, fun)

  end

  ExUnit.start

  defmodule Test do
    use ExUnit.Case

    test "Enum.all?/2" do
      assert true === Enum.all?([])
      assert true === Enum.all?([true])
      assert false === Enum.all?([false])
      assert false === Enum.all?([true, false])
      assert false === Enum.all?([false, true])

      import Integer
      assert true === Enum.all?([1,3,5], &Integer.is_odd/1)
      assert false === Enum.all?([1,2,5], &Integer.is_odd/1)
    end
  end
end

