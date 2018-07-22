defmodule Wrangle do
  defp trans_to_bool(letter) do
    case letter do
      "f" -> false
      "t" -> true
    end
  end

  defp update_trans_to_bool(map) do
    Map.update!(map, :is_trans, &trans_to_bool/1)
  end

  defp update_rgb(map) do
    map.rgb
    |> Rgb.transform()
    |> Enum.into(map)
    |> Map.drop([:rgb])
  end

  defp update_id(map) do
    Map.update!(map, :id, &String.to_integer/1)
  end

  def color(maplist) do
    maplist
    |> Enum.map(&update_trans_to_bool/1)
    |> Enum.map(&update_rgb/1)
    |> Enum.map(&update_id/1)
    |> Enum.map(fn map -> struct(Lego.Color, map) end)
  end
end
