defmodule :"Elixir.Timetrackergql.Repo.Migrations.Edit-fk-settings-again" do
  use Ecto.Migration

  def change do
    drop constraint(:clocks, "clocks_timer_id_fkey")
    alter table("clocks") do
      modify :timer_id, references(:timers, on_delete: :delete_all), [default: 007, null: false]
    end
  end
end
