defmodule Chop do

  def guess(original, range) do
    guess(original, middle(range), range)
  end

  def guess(original, myguess, a.._) when original < myguess do
    IO.puts "Is it #{myguess}"
    guess(original, middle(a..myguess), a..myguess)
  end

  def guess(original, myguess, _a..b) when original > myguess do
    IO.puts "Is it #{myguess}"
    guess(original, middle(myguess..b), myguess..b)
  end

  def guess(original, myguess, _range) when original == myguess do
    IO.puts "#{myguess}"
  end

  def middle(a..b) do
    div((b - a), 2) + a
  end

end

Chop.guess(273, 1..1000)
