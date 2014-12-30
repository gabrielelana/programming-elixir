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

    @doc """
    Invokes the given fun for each item in the collection. Returns :ok.
    """
    @spec each(Enumerable.t, (any -> any)) :: :ok
    def each([], _), do: :ok
    def each([h|t], fun) do
      fun.(h)
      each(t, fun)
    end

    @doc """
    Filters the collection, i.e. returns only those elements for which fun returns true.
    """
    @spec filter(Enumberable.t, (any -> boolean)) :: list
    def filter([], _), do: []
    def filter([h|t], fun) do
      if fun.(h) do
        [h|filter(t, fun)]
      else
        filter(t, fun)
      end
    end

    @doc """
    Splits the enumerable into two collections, leaving count elements in the
    first one. If count is a negative number, it starts counting from the back
    to the beginning of the collection.
    """
    @spec split(Enumberable.t, integer) :: {list, list}
    def split(collection, n) when n < 0, do: split(collection, max(0, count(collection) + n))
    def split(collection, n), do: split(collection, n, [])

    defp split(collection, 0, l), do: {reverse(l), collection}
    defp split([], _, l), do: split([], 0, l)
    defp split([h|t], n, l), do: split(t, n - 1, [h|l])

    @doc """
    Takes the first count items from the collection.

    If a negative count is given, the last count values will be taken. For
    such, the collection is fully enumerated keeping up to 2 * count elements
    in memory. Once the end of the collection is reached, the last count
    elements are returned.
    """
    @spec take(Enumerable.t, integer) :: list
    def take(collection, n) when n < 0, do: skip(collection, max(0, count(collection) + n))
    def take(collection, n), do: take(collection, n, [])

    defp take(_, 0, taken), do: reverse(taken)
    defp take([], _, taken), do: take([], 0, taken)
    defp take([h|t], n, taken), do: take(t, n - 1, [h|taken])

    defp skip(rest, 0), do: rest
    defp skip([], _), do: []
    defp skip([_|t], n), do: skip(t, n - 1)


    defp count([]), do: 0
    defp count([_|t]), do: 1 + count(t)

    defp reverse(l), do: reverse(l, [])
    defp reverse([], reversed), do: reversed
    defp reverse([h|t], reversed), do: reverse(t, [h|reversed])
  end

  ExUnit.start

  defmodule Test do
    use ExUnit.Case
    import ExUnit.CaptureIO
    import Integer

    test "Enum.take/2" do
      assert [] === Enum.take([], 0)
      assert [] === Enum.take([], 1)
      assert [1] === Enum.take([1], 1)
      assert [] === Enum.take([1], 0)
      assert [1,2,3] === Enum.take([1,2,3], 3)
      assert [1,2,3] === Enum.take([1,2,3], 10)
      assert [3] === Enum.take([1,2,3], -1)
      assert [2,3] === Enum.take([1,2,3], -2)
      assert [1,2,3] === Enum.take([1,2,3], -3)
      assert [1,2,3] === Enum.take([1,2,3], -10)
    end

    test "Enum.split/2" do
      assert {[], []} === Enum.split([], 0)
      assert {[], []} === Enum.split([], 1)
      assert {[1], []} === Enum.split([1], 1)
      assert {[], [1]} === Enum.split([1], 0)
      assert {[1,2,3], []} === Enum.split([1,2,3], 3)
      assert {[1,2,3], []} === Enum.split([1,2,3], 10)
      assert {[1,2], [3]} === Enum.split([1,2,3], -1)
      assert {[1], [2,3]} === Enum.split([1,2,3], -2)
      assert {[], [1,2,3]} === Enum.split([1,2,3], -3)
      assert {[], [1,2,3]} === Enum.split([1,2,3], -10)
    end

    test "Enum.filter/2" do
      assert [] === Enum.filter([], &(&1))
      assert [1,3,5] === Enum.filter([1,3,5], &is_odd/1)
      assert [1,5] === Enum.filter([1,2,5], &is_odd/1)
    end

    test "Enum.each/1" do
      assert :ok === Enum.each([], fn x -> x end)
      assert :ok === Enum.each([1,2,3], fn x -> x end)
      assert capture_io(
        fn -> Enum.each([1,2,3], &IO.puts/1) end
      ) === """
      1
      2
      3
      """
    end

    test "Enum.all?/2" do
      assert true === Enum.all?([])
      assert true === Enum.all?([true])
      assert false === Enum.all?([false])
      assert false === Enum.all?([true, false])
      assert false === Enum.all?([false, true])

      assert true === Enum.all?([1,3,5], &is_odd/1)
      assert false === Enum.all?([1,2,5], &is_odd/1)
    end
  end
end

