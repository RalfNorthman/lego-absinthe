defmodule Lego.Schema do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema

      @timestamps_opts [
        type: Timex.Ecto.TimestampWithTimezone,
        autogenerate: {Timex.Ecto.DateTime, :autogenerate, [:usec]}
      ]
    end
  end
end
