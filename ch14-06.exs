# Do the same as 14-04, but use spawn_monitor

defmodule Programming.Elixir do
  defmodule CallMeIfYouDie do
    import :timer, only: [sleep: 1]

    def child do
      raise "oops" # The exception gets logged
    end

    def start do
      spawn_monitor(__MODULE__, :child, [])
      sleep 500
      flush
    end

    defp flush do
      receive do
        message ->
          # The exception is received as the exit reason
          IO.puts("Received: #{inspect message}")
          flush
      after 100 ->
        IO.puts("End of messages")
      end
    end
  end

  CallMeIfYouDie.start

  # receives
  # > Received: {:DOWN, #Reference<0.0.0.128>, :process, #PID<0.55.0>, {%RuntimeError{message: "oops"}, [{Programming.Elixir.CallMeIfYouDie, :child, 0, [file: 'ch14-06.exs', line: 8]}]}}

  # instead of
  # > Received: {:EXIT, #PID<0.55.0>, {:undef, [{:oops, :exception, [[]], []}, {Programming.Elixir.CallMeIfYouDie, :child, 0, [file: 'ch14-04.exs', line: 9]}]}}
end
