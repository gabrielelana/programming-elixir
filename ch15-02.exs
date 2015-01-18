# Alter the code (see ch15-01) so that successive ticks are sent to each
# registered client (so the first goes to the first client, the second to the
# next client, and so on). Once the last client receives a tick, the process
# starts back at the first. The solution should deal with new clients being
# added at any time.

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
          generator(clients ++ [pid])
      after
        @interval ->
          IO.puts "#{inspect self} Tick"
          case clients do
            [client|clients] ->
              send client, :tick
              generator(clients ++ [client])
            [] ->
              generator(clients)
          end
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
