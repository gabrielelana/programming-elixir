defmodule Programming.Elixir do
  defmodule Sequence.Server do
    use GenServer

    def start do
      GenServer.start_link(__MODULE__, 100)
    end

    def next(pid) do
      GenServer.call(pid, :next)
    end

    def handle_call(:next, _from, current) do
      {:reply, current, current+1}
    end
  end

  ExUnit.start

  defmodule Sequence.Test do
    use ExUnit.Case

    test "next" do
      {:ok, server} = Sequence.Server.start
      assert Sequence.Server.next(server) == 100
      assert Sequence.Server.next(server) == 101
      assert Sequence.Server.next(server) == 102
    end

  end
end
