import :timer, only: [ sleep: 1 ]

defmodule Tick do
  @name :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    :global.whereis_name(@name) <- {:register, client_pid}
  end

  def notify(clients, pid) do
    case clients do
      [] ->
        []
      [x | []] ->
        [x]
      [x|xs] ->
        x <- {:set_pid, pid}
        notify(xs, x)
    end
  end

  def generator(clients) do
    receive do
      { :register, pid } ->
        IO.puts "registering #{inspect pid}"
        case notify(clients, pid) do
          [x] -> pid <- {:set_pid, x}
          _   -> nil
        end
        generator([pid|clients])
    end
  end

end

defmodule Client do

  def start do
    pid = spawn(__MODULE__, :receiver, [nil])
    Tick.register(pid)
  end

  def receiver(next_pid) do
    receive do
      { :tick } ->
        IO.puts "tock in client #{inspect self()}"
        case next_pid do
          nil -> receiver(nil)
          _   ->
            sleep 2000
            next_pid <- {:tick}
            receiver(next_pid)
        end
      {:set_pid, new_pid} ->
        receiver(new_pid)
    end
  end
end
