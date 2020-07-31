defmodule :"Elixir.Timetrackergql.Repo.Migrations.Remove-isOpen-editFormOpen" do
  use Ecto.Migration

  # app handles this values client side

  def change do
    alter table("timers") do
      # reversible remove
      remove :isOpen, :boolean, default: false
      remove :editFormOpen, :boolean, default: false
    end
  end
end
