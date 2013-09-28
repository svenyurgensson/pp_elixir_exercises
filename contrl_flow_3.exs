# page 125

defmodule MyControl do

  def ok!(result) do
    case result do
      {:ok, data} -> data
      {_, msg}    -> raise Exception.normalize(msg)
    end
  end

end

MyControl.ok!(File.open("contrl_flow_3.exs"))
MyControl.ok!(File.open("somefile"))