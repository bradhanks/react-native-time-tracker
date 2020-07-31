defmodule :"Elixir.Timetrackergql.Repo.Migrations.Create-clock" do
  use Ecto.Migration

  def change do
    create table(:clocks) do
      add :elapsed, :integer
      add :isRunning, :boolean, default: false, null: false
      add :timer_id, references(:timers), null: false

      timestamps()
    end


  alter table(:timers) do
    add :clock_id, references(:clocks), null: false
  end

end
end
