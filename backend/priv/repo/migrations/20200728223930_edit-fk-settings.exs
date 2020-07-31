defmodule :"Elixir.Timetrackergql.Repo.Migrations.Edit-fk-settings" do
  use Ecto.Migration

  def change do
    drop constraint(:clocks, "clocks_timer_id_fkey")
    alter table("clocks") do
      modify :timer_id, references(:timers), [default: 007, null: false, on_delete: :delete_all]
    end
  end
end
