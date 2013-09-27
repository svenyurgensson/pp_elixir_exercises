defmodule MyList do

  def is_prime?(n) do
    Enum.filter(2..n-1, &(rem(n, &1) == 0)) == []
  end

end

n = 34
list = Enum.to_list 2..n

Enum.filter list, MyList.is_prime?(&1)
