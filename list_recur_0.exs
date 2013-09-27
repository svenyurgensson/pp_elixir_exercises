defmodule MyList do

  def caesar([], _adder), do: []

  def caesar([head | tail], adder) when (head + adder) <= 'z' do
    [head + adder | caesar(tail, adder)]
  end

  def caesar([head | tail], adder) when (head + adder) > 'z' do
    [head + adder - 'z' | caesar(tail, adder)]
  end

end

MyList.caesar('ryvkve', 13)