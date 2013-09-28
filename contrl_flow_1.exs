# page 125

defmodule MyControl do


  def fizzbuzz(n) when n > 0 do
    div_by_3? = fn(n) -> rem(n, 3) == 0 end
    div_by_5? = fn(n) -> rem(n, 5) == 0 end
    divide    = fn(n) -> {div_by_3?.(n), div_by_5?.(n)} end

    1..n |> Enum.map fn(current)->
           case divide.(current) do
             {true, true}  -> "FizzBuzz"
             {true, false} -> "Fizz"
             {false, true} -> "Buzz"
             _ ->
               current
           end
       end
  end
end

MyControl.fizzbuzz(17)