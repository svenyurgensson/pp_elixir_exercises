defmodule MyList do

  def calculate_total(rates, orders) do
    Enum.map orders,
         fn(order) ->
             {_, id}         = List.keyfind order, :id, 0
             {_, ship_to}    = List.keyfind order, :ship_to, 0
             {_, net_amount} = List.keyfind order, :net_amount, 0
             {_, rate}       = List.keyfind rates, ship_to, 0, {:_, 0.0}
             total_amount    = net_amount + rate
             [id: id, ship_to: ship_to, net_amount: net_amount, total_amount: total_amount]
         end
  end

  def calculate_total2(rates, orders) do
    Enum.map orders,
         fn(order = [id: _, ship_to: ship_to, net_amount: na]) ->
             {_, rate}  = List.keyfind rates, ship_to, 0, {:_, 0.0}
             total      = na + rate
             Keyword.put order, :total_amount, total
         end
  end


end

tax_rates = [ NC: 0.075, TX: 0.08 ]

orders = [ [ id: 123, ship_to: :NC, net_amount: 100.00 ],
           [ id: 124, ship_to: :OK, net_amount:  35.50 ],
           [ id: 125, ship_to: :TX, net_amount:  24.00 ],
           [ id: 126, ship_to: :TX, net_amount:  44.80 ],
           [ id: 127, ship_to: :NC, net_amount:  25.00 ],
           [ id: 128, ship_to: :MA, net_amount:  10.00 ],
           [ id: 129, ship_to: :CA, net_amount: 102.00 ],
           [ id: 120, ship_to: :NC, net_amount:  50.00 ] ]

MyList.calculate_total(tax_rates, orders)
MyList.calculate_total2(tax_rates, orders)
