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

    defp calculate(0), do: 0
    defp calculate(1), do: 1
    defp calculate(n), do: calculate(n-1) + calculate(n-2)
  end


  defmodule Scheduler do
    def run(workers, module, function, queue) do
      1..workers
      |> Enum.map(fn _ -> spawn_link(module, function, [self]) end)
      |> schedule(queue, [])
    end

    defp schedule(workers, queue, results) do
      receive do
        {:ready, pid} when length(queue) == 0 ->
          send pid, :shutdown
          workers = List.delete(workers, pid)
          if length(workers) > 0 do
            schedule(workers, queue, results)
          else
            Enum.sort(results, fn {n1,_}, {n2,_} -> n1 <= n2 end)
          end

        {:ready, pid} ->
          [n | tail] = queue
          send pid, {:fib, n, self}
          schedule(workers, tail, results)

        {:answer, n, result, _pid} ->
          schedule(workers, queue, [{n, result}|results])
      end
    end
  end

  questions = [37, 37, 37, 37, 37, 37]
  Enum.each 1..10, fn workers ->
    {time, result} = :timer.tc(Scheduler, :run, [workers, Fibonacci, :init, questions])

    if workers == 1 do
      IO.puts inspect result
      IO.puts "\n # time (s)"
    end

    :io.format "~2B ~.2f~n", [workers, time/1000000.0]
  end
end
