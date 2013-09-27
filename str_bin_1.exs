# page 104

defmodule MyStrings do

  def only_printable?(string) do
    Regex.match? %r/\A[ -~]+\z/, string
  end

  def only_printable2?(string) do
    Enum.all? string, fn(s) -> s in ? ..?~ end
  end

end

IO.puts "Strings"
IO.inspect (MyStrings.only_printable? "Hello, ~World!")
IO.inspect (MyStrings.only_printable? "Hello, ~World!\n")

IO.puts "Single-quoted string"
IO.inspect (MyStrings.only_printable2? 'Hello, ~World!\n')
IO.inspect (MyStrings.only_printable2? 'Hello, ~World!')