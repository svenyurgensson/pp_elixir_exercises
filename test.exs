prefix = fn prf -> (fn name -> "#{prf} #{name}" end) end

msr = prefix.("Mrs")
msr.("Smith")

prefix.("Elixir").("Rocks")
