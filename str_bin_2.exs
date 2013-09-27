# page 104

defmodule MyStrings do

  def anagram?(word1, word2) do
    word1 -- word2 == []
  end

end

IO.inspect MyStrings.anagram?('algo', 'galo')
IO.inspect MyStrings.anagram?('algo', 'gala')