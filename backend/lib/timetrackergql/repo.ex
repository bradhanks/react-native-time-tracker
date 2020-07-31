defmodule Timetrackergql.Repo do
  use Ecto.Repo,
    otp_app: :timetrackergql,
    adapter: Ecto.Adapters.Postgres
end
