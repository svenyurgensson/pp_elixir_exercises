defmodule MyList do

  def flatten([]),             do: []
  def flatten(list),           do: flatten(list, [])
  def flatten([x | xs], list), do: list ++ flatten(x) ++ flatten(xs)
  def flatten(x, list),        do: [x | flatten(list)]

end

MyList.flatten([1, [ 2, 3, [4] ], 5, [[[6]]]])