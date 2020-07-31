defmodule TimetrackergqlWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :timetrackergql
  use Absinthe.Phoenix.Endpoint

  socket "/socket", TimetrackergqlWeb.UserSocket,
    websocket: true,
    longpoll: false

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug CORSPlug

  plug TimetrackergqlWeb.Router
end
