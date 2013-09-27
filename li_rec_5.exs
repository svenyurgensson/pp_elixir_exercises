defmodule MyEnum do

  def all?([], _func), do: true
  def all?([head | tail], func), do: func.(head) && all?(tail, func)

  def filter([], _func), do: []
  def filter([head | tail], func) do
    if func.(head) do
      [head | filter(tail, func)]
    else
      filter(tail, func)
    end
  end

  def take([], _n), do: []
  def take(_, n) when n <= 0, do: []
  def take([head | tail], n) when n > 0, do: [head | MyEnum.take(tail, n - 1)]

  def each([], _func), do: :ok
  def each([head | tail], func) do
    func.(head)
    each(tail, func)
  end

end

#MyEnum.all? [1,2,3,4], &(&1 > 2)
#MyEnum.filter [1,2,3,4], &(&1 > 2)
#MyEnum.take [1,2,3,4], 2
#MyEnum.each([1,2,3,4], IO.inspect(&1))
