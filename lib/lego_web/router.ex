defmodule LegoWeb.Router do
  use LegoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", LegoWeb do
    pipe_through :api
  end
end
