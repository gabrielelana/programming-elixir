# The ticker process (see ch15-01) is a central server that sends events to
# registered clients. Reimplement this as a ring of clients. A client sends a
# tick to the next client in the ring.
#
# After 2 seconds, that client sends a tick
# to its next client. When thinking about how to add clients to the ring,
# remember to deal with the case where a client’s receive loop times out just as
# you’re adding a new process. What does this say about who has to be responsible
# for updating the links?

defmodule Programming.Elixir do
  defmodule Ring do
    @name :ring

    def start do
      pid = spawn(__MODULE__, :loop, [[]])
      :global.register_name(@name, pid)
    end

    def register(pid) do
      send :global.whereis_name(@name), {:register, pid}
    end

    def loop(pids) do
      receive do
        {:register, pid} ->
          IO.puts "Registering #{inspect pid}"
          case pids do
            [only|[]] ->
              send pid, {:next, only}
              send only, {:next, pid}
              loop([only|[pid]])
            [first|t] ->
              last = List.last(t)
              send pid, {:next, first}
              send last, {:next, pid}
              loop([first|t ++ [pid]])
            [] ->
              send pid, {:next, pid}
              send pid, :tick
              loop([pid])
          end
      end
    end
  end

  defmodule Client do
    @interval 2_000

    def start(name) do
      pid = spawn(__MODULE__, :ticker, [name, :none])
      Ring.register(pid)
    end

    def ticker(name, next) do
      receive do
        {:next, next} ->
          ticker(name, next)
        :tick ->
          IO.puts "<#{name}> I heard a tick"
          me = self
          spawn fn ->
            :timer.sleep(@interval)
            send me, :wakeup
          end
          ticker(name, next)
        :wakeup when next !== :none ->
          send next, :tick
          ticker(name, next)
        :wakeup ->
          exit(:nonext)
      end
    end
  end
end
