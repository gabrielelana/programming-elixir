# Do the same as 14-03, but have the child raise an exception. What difference
# do you see in the tracing?

defmodule Programming.Elixir do
  defmodule CallMeIfYouDie do
    import :timer, only: [sleep: 1]

    def child do
      raise :oops # The exception gets logged
    end

    def start do
      Process.flag(:trap_exit, true)
      spawn_link(__MODULE__, :child, [])
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
end
