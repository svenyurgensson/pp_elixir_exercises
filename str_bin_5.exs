# page 110

defmodule MyStrings do

  def center(list) do
    max_len     = Enum.max_by(list, &(String.length(&1))) |> String.length
    sorted_list = Enum.sort(list, &(String.length(&1) < String.length(&2)))
    Enum.each sorted_list,
         fn(word) ->
             len = String.length(word)
             pad = div((max_len - len), 2) + len
             IO.puts String.rjust(word, pad)
         end
  end

end


MyStrings.center(["zebra", "cat", "elephant"])