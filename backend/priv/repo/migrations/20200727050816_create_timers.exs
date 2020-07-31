defmodule Timetrackergql.Repo.Migrations.CreateTimers do
  use Ecto.Migration

  def change do
    create table(:timers) do
      add :title, :string
      add :project, :string
      add :elapsed, :integer
      add :isRunning, :boolean, default: false, null: false
      add :isOpen, :boolean, default: false, null: false
      add :editFormOpen, :boolean, default: false, null: false

      timestamps()
    end

  end
end
