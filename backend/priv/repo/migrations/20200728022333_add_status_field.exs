defmodule Timetrackergql.Repo.Migrations.AddStatusField do
  use Ecto.Migration

  def change do
    alter table("timers") do
      add :status, :string
    end
  end
end
