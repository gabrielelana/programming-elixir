
defmodule Programming.Elixir do
  defmodule Chain do

    def run(n) do
      IO.puts(inspect(:timer.tc(__MODULE__, :start, [n])))
    end

    def start(n) do
      last = Enum.reduce(1..n, self, fn(_, send_to) ->
        spawn(__MODULE__, :count, [send_to])
      end)

      send last, 0

      receive do
        last_counter when is_integer(last_counter) ->
          "Result is #{inspect(last_counter)}"
      end
    end

    def count(send_to) do
      receive do
        n -> send(send_to, n+1)
      end
    end
  end
end
