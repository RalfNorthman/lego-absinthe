defmodule Rgb do
  defp decode(hex) do
    <<color_code>> = Base.decode16!(hex)
    color_code
  end

  defp split(hexes) do
    hexes
    |> String.to_charlist()
    |> Enum.chunk_every(2)
    |> Enum.map(&List.to_string/1)
  end

  def transform(hexes) do
    [red, green, blue] =
      hexes
      |> split()
      |> Enum.map(&decode/1)

    %{red: red, green: green, blue: blue}
  end
end
