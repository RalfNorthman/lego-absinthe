defmodule LegoWeb.Schema do
  use Absinthe.Schema
  import_types(Absinthe.Type.Custom)
  alias Lego.{Color, Repo}
  import Ecto.Query

  query do
    @desc "List of all the possible colors of Lego pieces."
    field :colors, non_null(list_of(non_null(:color))) do
      arg(:matching, :string)

      resolve(fn
        _, %{matching: name}, _ when is_binary(name) ->
          query =
            from(
              c in Color,
              where: ilike(c.name, ^"%#{name}%"),
              order_by: [c.red, c.green, c.blue]
            )

          {:ok, Repo.all(query)}

        _, _, _ ->
          {:ok, Repo.all(Color)}
      end)
    end
  end

  mutation do
    @desc "Create a color"
    field :create_color, type: :color do
      arg(:name, non_null(:string))
      arg(:is_trans, non_null(:boolean))
      arg(:red, non_null(:integer))
      arg(:green, non_null(:integer))
      arg(:blue, non_null(:integer))

      resolve(fn
        _, args, _ ->
          changeset = Color.changeset(%Color{}, args)
          Repo.insert(changeset)
      end)
    end

    @desc "Delete a color"
    field :delete_color, type: :color do
      arg(:id, non_null(:id))

      resolve(fn
        _, %{id: id}, _ ->
          color = Repo.get(Color, String.to_integer(id))

          case color do
            nil -> {:error, "No color with that id."}
            _ -> Repo.delete(color)
          end
      end)
    end
  end

  @desc "Color of a lego piece."
  object :color do
    field(:id, :id)
    field(:name, non_null(:string))
    @desc "Is the color transparent or not?"
    field(:is_trans, non_null(:boolean))
    @desc "The red component of the RGB representation for the color."
    field(:red, non_null(:integer))
    @desc "The green component of the RGB representation for the color."
    field(:green, non_null(:integer))
    @desc "The blue component of the RGB representation for the color."
    field(:blue, non_null(:integer))
    field(:inserted_at, :datetime)
    field(:updated_at, :datetime)
  end
end
