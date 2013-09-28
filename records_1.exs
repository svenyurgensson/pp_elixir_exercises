# page 114

defmodule MyRecords do

  defrecord Order, id: nil, ship_to: nil, net_amount: 0, sales_tax: 0

  def parse(filename, rates) do
    filename
     |> File.open!
     |> IO.stream(:line)
     |> Enum.filter_map( &(valid_record?(&1)), &(convert(&1)) )
     |> calculate_total(rates)
  end

  defp convert(line) do
    [id, ship_to, net_amount] = line |> String.strip |> String.split(",")
    Order.new id: binary_to_integer(id),
             ship_to: binary_to_atom(String.slice(ship_to, 1, 2)),
             net_amount: binary_to_float(net_amount)
  end

  defp valid_record?(line) do
    String.starts_with? line, ["0", "1", "2", "3", "4", "5" ,"6", "7", "8", "9"]
  end

  defp calculate_total(orders, rates) do
    Enum.map orders,
         fn(order) ->
             {_, rate}  = List.keyfind rates, order.ship_to, 0, {:_, 0.0}
             total      = order.net_amount + rate
             Order.new id: order.id, ship_to: order.ship_to, net_amount: order.net_amount, sales_tax: total
         end
  end

end

tax_rates = [ NC: 0.075, TX: 0.08 ]
MyRecords.parse "str_bin_7.csv", tax_rates