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
  end

  ExUnit.start

  defmodule Test do
    use ExUnit.Case
    import ExUnit.CaptureIO

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

    test "Enum.filter/2" do
      import Integer
      assert [] === Enum.filter([], &(&1))
      assert [1,3,5] === Enum.filter([1,3,5], &Integer.is_odd/1)
      assert [1,5] === Enum.filter([1,2,5], &Integer.is_odd/1)
    end
  end
end

