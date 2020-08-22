defmodule Timetrackergql.Repo.Migrations.CreateTimers do
  use Ecto.Migration

  def change do
    create table(:timers) do
      add :title, :string
      add :project, :string
      add :status, :string
      add :clock_id, references(:clocks), null: false

      timestamps()
    end

  end
end
