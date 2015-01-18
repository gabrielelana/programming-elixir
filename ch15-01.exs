defmodule Programming.Elixir do
  defmodule Ticker do
    @interval 2_000
    @name :ticker

    def start do
      pid = spawn(__MODULE__, :generator, [[]])
      :global.register_name(@name, pid)
    end

    def register(pid) do
      send :global.whereis_name(@name), {:register, pid}
    end

    def generator(clients) do
      receive do
        {:register, pid} ->
          IO.puts "Registering #{inspect pid}"
          generator([pid|clients])
      after
        @interval ->
          IO.puts "#{inspect self} Tick"
          Enum.each clients, &(send &1, :tick)
          generator(clients)
      end
    end
  end

  defmodule Client do
    def start do
      pid = spawn(__MODULE__, :listen, [])
      Ticker.register(pid)
    end

    def listen do
      receive do
        :tick ->
          IO.puts "#{inspect self} I heard a tick"
          listen
      end
    end
  end
end
