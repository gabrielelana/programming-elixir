# Use spawn_link to start a process, and have that process send a message to the
# parent and then exit immediately. Meanwhile, sleep for 500 ms in the parent,
# then receive as many messages as are waiting. Trace what you receive. Does it
# matter that you weren’t waiting for the notification from the child when it
# exited?

defmodule Programming.Elixir do
  defmodule CallMeIfYouDie do
    import :timer, only: [sleep: 1]

    def child(parent) do
      send parent, :ok
    end

    def start do
      Process.flag(:trap_exit, true)
      spawn_link(__MODULE__, :child, [self])
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
end
