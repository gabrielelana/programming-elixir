defmodule Programming.Elixir do

  defmodule Fib do
    def of(0), do: 0
    def of(1), do: 1
    def of(n), do: Fib.of(n-1) + Fib.of(n-2)
  end

  ExUnit.start

  defmodule Test do
    use ExUnit.Case

    test "fib" do
      worker = Task.async(fn -> Fib.of(20) end)
      result = Task.await(worker)
      assert 6765 == result
    end
  end
end
