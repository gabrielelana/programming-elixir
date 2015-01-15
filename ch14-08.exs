defmodule Programming.Elixir do
  defmodule Fibonacci do

    def init(scheduler), do: loop(scheduler)

    def loop(scheduler) do
      send scheduler, {:ready, self}
      receive do
        {:fib, n, client} ->
          send client, {:answer, n, calculate(n), self}
          loop(scheduler)
        :shutdown ->
          exit :normal
      end
    end

    def of(fib, n, from) do
      send fib, {:fib, n, from}
    end

    defp calculate(0), do: 0
    defp calculate(1), do: 1
    defp calculate(n), do: calculate(n-1) + calculate(n-2)
  end


  defmodule Scheduler do
    def run(workers, module, init, ask, queue) do
      1..workers
      |> Enum.map(fn _ -> spawn_link(module, init, [self]) end)
      |> schedule(queue, &(apply(module, ask, [&1, &2, self])), [])
    end

    defp schedule(workers, queue, ask, results) do
      receive do
        {:ready, pid} when length(queue) == 0 ->
          send pid, :shutdown
          workers = List.delete(workers, pid)
          if length(workers) > 0 do
            schedule(workers, queue, ask, results)
          else
            results
          end

        {:ready, pid} ->
          [question | tail] = queue
          ask.(pid, question)
          schedule(workers, tail, ask, results)

        {:answer, n, result, _pid} ->
          schedule(workers, queue, ask, [{n, result}|results])
      end
    end
  end

  questions = [37, 37, 37, 37, 37, 37]
  Enum.each 1..10, fn workers ->
    {time, result} = :timer.tc(Scheduler, :run, [workers, Fibonacci, :init, :of, questions])

    if workers == 1 do
      IO.puts inspect result
      IO.puts "\n # time (s)"
    end

    :io.format "~2B ~.2f~n", [workers, time/1000000.0]
  end
end
