defmodule Lego.Theme do
  use Lego.Schema
  import Ecto.Changeset

  schema "themes" do
    field(:name, :string)
    field(:parent_id, :id)

    timestamps()
  end

  @doc false
  def changeset(theme, attrs) do
    theme
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> foreign_key_constraint(:parent_id, name: :themes_parent_id_fkey)
  end
end
