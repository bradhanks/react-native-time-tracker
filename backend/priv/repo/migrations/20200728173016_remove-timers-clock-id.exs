defmodule :"Elixir.Timetrackergql.Repo.Migrations.Remove-timers-clock-id" do
  use Ecto.Migration

  def change do
    alter table(:timers) do
      remove :clock_id, references(:clocks), null: false
    end
  end
end
