# Use list comprehensions to return a list of the prime numbers from 2 to n.

defmodule Programming.Elixir do
  defmodule Prime do

    @doc """
    Generates prime numbers up to n
    """
    @spec upto(integer) :: list(integer)
    def upto(n) do
      for p <- 2..n, prime?(p), do: p
    end

    @spec prime?(integer) :: boolean
    def prime?(n) when n < 2, do: false
    def prime?(n) when n === 2, do: true
    def prime?(n) when rem(n, 2) === 0, do: false
    def prime?(n), do: prime?(n, 3)

    defp prime?(n, k) when k*k > n, do: true
    defp prime?(n, k) when rem(n, k) === 0, do: false
    defp prime?(n, k), do: prime?(n, k+2)
  end

  ExUnit.start

  defmodule Test do
    use ExUnit.Case

    test "Prime.upto/1" do
      assert [2,3,5,7,11,13,17,19] === Prime.upto(20)
    end
  end
end
