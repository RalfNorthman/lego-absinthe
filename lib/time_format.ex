defmodule TimeFormat do
  @defaults %{microseconds: false, timezone: false}

  def format(timex_value, opts \\ []) do
    %{
      microseconds: microseconds,
      timezone: timezone
    } = Enum.into(opts, @defaults)

    us = if(microseconds, do: "{ss}", else: "")
    tz = if(timezone, do: " {Zabbr}", else: "")
    format_string = "{YYYY}-{0M}-{0D} {h24}:{0m}:{0s}" <> us <> tz

    Timex.format(timex_value, format_string)
  end

  def format!(timex_value, opts \\ []) do
    {:ok, result} = format(timex_value, opts)
    result
  end
end
