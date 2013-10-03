defmodule CatCalculator do

  def run(scheduler) do
    scheduler <- { :ready, self }
    receive do
      { :calc, file, client } ->
        client <- { :answer, file, calculate(file), self }
        run(scheduler)
      { :shutdown } ->
        exit(0)
    end
  end

  def calculate(file) do
    f = File.open!(file)
    count = f
              |> IO.stream(:line)
              |> Enum.reduce(0, fn(line, acc) -> cat_calc(line) + acc end)
   File.close(f)
   count
  end

  defp cat_calc(line) do
    Regex.scan(%r/cat/i, line) |> length
  end

end

defmodule Scheduler do

  def run(num_processes, module, func, to_calculate) do
    (1..num_processes)
    |> Enum.map(fn(_) -> spawn(module, func, [self]) end)
    |> schedule_processes(to_calculate, [])
  end

  defp schedule_processes(processes, queue, results) do
    receive do
      {:ready, pid} when length(queue) > 0 ->
        [ next | tail ] = queue
        pid <- {:calc, next, self}
        schedule_processes(processes, tail, results)

      {:ready, pid} ->
        pid <- {:shutdown}
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn {n1,_}, {n2,_}  -> n1 <= n2 end)
        end

      {:answer, number, result, _pid} ->
        schedule_processes(processes, queue, [ {number, result} | results ])
    end
  end
end

path = "/Users/Shared/DC/книги/Разработка/FP"
to_process = Enum.map File.ls!(path), &("#{path}/#{&1}")

Enum.each 3..6, fn num_processes ->
  {time, result} = :timer.tc(Scheduler, :run,  [num_processes, CatCalculator, :run, to_process])
  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n #   time (s)"
  end
  :io.format "~2B     ~.2f~n", [num_processes, time/1000000.0]
end