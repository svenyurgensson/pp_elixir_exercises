import :timer, only: [ sleep: 1 ]

defmodule Multproc3 do

  def ch_method(parent) do
    parent <- "Hello from child!"
#    raise "Error in child!"
  end

  def run do
    #spawn_link(Multproc3, :ch_method, [self()])
    Process.spawn_monitor(Multproc3, :ch_method, [self()])
    sleep 500
    run_loop
  end

  def run_loop do
    receive do
      msg ->
        IO.puts "Message received: '#{inspect msg}'"
        run_loop
    end
  end

end