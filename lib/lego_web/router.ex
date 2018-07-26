defmodule LegoWeb.Router do
  use LegoWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/" do
    pipe_through(:api)

    forward(
      "/api",
      Absinthe.Plug,
      schema: LegoWeb.Schema
    )

    forward(
      "/graphiql",
      Absinthe.Plug.GraphiQL,
      schema: LegoWeb.Schema,
      interface: :simple
    )
  end
end
