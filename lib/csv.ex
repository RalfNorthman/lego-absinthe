defmodule Csv do
  alias NimbleCSV.RFC4180, as: Nimble

  def read(file_path) do
    [names | values] =
      file_path
      |> File.stream!()
      |> Nimble.parse_stream(headers: false)
      |> Enum.to_list()

    keys = Enum.map(names, &String.to_atom/1)

    values
    |> Enum.map(fn x -> to_map(keys, x) end)
  end

  defp to_map(keys, values) do
    keys
    |> Enum.zip(values)
    |> Map.new()
  end
end
