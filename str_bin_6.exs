# page 111

defmodule MyStrings do

  def capitalize_sentences(string) do
    string |> String.split(". ") |> Enum.map(&String.capitalize(&1)) |> Enum.join(". ")
  end

end

MyStrings.capitalize_sentences("oh. a DOG. woof. Probably not need being capitalized")