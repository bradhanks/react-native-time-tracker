defmodule :"Elixir.Timetrackergql.Repo.Migrations.Create-clock" do
  use Ecto.Migration

  def change do
    create table(:clocks) do
      add :elapsed, :integer
      add :isRunning, :boolean, default: false, null: false
      add :timer_id, references(:timers, on_delete: :delete_all), [default: 007, null: false]
      timestamps()
    end

end
end
