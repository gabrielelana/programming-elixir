# Do the same as 14-03, but use spawn_monitor

defmodule Programming.Elixir do
  defmodule CallMeIfYouDie do
    import :timer, only: [sleep: 1]

    def child(parent) do
      send parent, :ok
    end

    def start do
      spawn_monitor(__MODULE__, :child, [self])
      sleep 500
      flush
    end

    defp flush do
      receive do
        message ->
          IO.puts("Received: #{inspect message}")
          flush
      after 100 ->
        IO.puts("End of messages")
      end
    end
  end

  CallMeIfYouDie.start

  # receives
  # > Received: :ok
  # > Received: {:DOWN, #Reference<0.0.0.126>, :process, #PID<0.55.0>, :normal}
  # instead of
  # > Received: :ok
  # > Received: {:EXIT, #PID<0.55.0>, :normal}

end
