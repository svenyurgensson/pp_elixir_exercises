# page 104

defmodule MyStrings do

  def calculate(string) do
    op_idx          = Enum.find_index string, &(&1 in '-+*/')
    op              = Enum.at string, op_idx
    {first, second} = Enum.split string, op_idx
    calc(first, second, op)
  end

  defp calc(first, second, ?-), do: str2num(first) - str2num(second)
  defp calc(first, second, ?+), do: str2num(first) + str2num(second)
  defp calc(first, second, ?*), do: str2num(first) * str2num(second)
  defp calc(first, second, ?/), do: str2num(first) / str2num(second)

  defp str2num(string),       do: str2num(string, 0)
  defp str2num([], n),        do: n
  defp str2num([x | xs], n) when x in '0123456789', do: str2num(xs, n*10 + x - ?0)
  defp str2num([_x | xs], n), do: str2num(xs, n)

end

IO.inspect MyStrings.calculate('123+345')
IO.inspect MyStrings.calculate('123 - 345')
IO.inspect MyStrings.calculate('644 *345')
