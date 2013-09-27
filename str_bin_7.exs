# page 112

defmodule MyStrings do

  def parse(filename, rates) do
    filename
     |> File.open!
     |> IO.stream(:line)
     |> Enum.filter_map( &(valid_record?(&1)), &(convert(&1)) )
     |> calculate_total(rates)
  end

  defp convert(line) do
    [id, ship_to, net_amount] = line |> String.strip |> String.split(",")

    Enum.zip [:id, :ship_to, :net_amount],
             [binary_to_integer(id),
              binary_to_atom(String.slice(ship_to, 1, 2)),
              binary_to_float(net_amount)]
  end

  defp valid_record?(line) do
    String.starts_with? line, ["0", "1", "2", "3", "4", "5" ,"6", "7", "8", "9"]
  end

  defp calculate_total(orders, rates) do
    Enum.map orders,
         fn(order = [id: _, ship_to: ship_to, net_amount: na]) ->
             {_, rate}  = List.keyfind rates, ship_to, 0, {:_, 0.0}
             total      = na + rate
             Keyword.put order, :total_amount, total
         end
  end

end

tax_rates = [ NC: 0.075, TX: 0.08 ]
MyStrings.parse "str_bin_7.csv", tax_rates