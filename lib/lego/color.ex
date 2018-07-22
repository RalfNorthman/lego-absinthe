defmodule Lego.Color do
  use Lego.Schema
  import Ecto.Changeset

  schema "colors" do
    field(:blue, :integer)
    field(:green, :integer)
    field(:is_trans, :boolean, default: false)
    field(:name, :string)
    field(:red, :integer)

    timestamps()
  end

  @doc false
  def changeset(color, attrs) do
    color
    |> cast(attrs, [:name, :red, :blue, :green, :is_trans])
    |> validate_required([:name, :red, :blue, :green, :is_trans])
  end
end
