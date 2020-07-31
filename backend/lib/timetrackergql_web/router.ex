defmodule TimetrackergqlWeb.Router do
  use TimetrackergqlWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: TimetrackergqlWeb.Schema

    forward "/", Absinthe.Plug, schema: TimetrackergqlWeb.Schema
  end
end
