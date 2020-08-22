defmodule Timetrackergql.TimerContext.Timer do
  use Ecto.Schema
  import Ecto.Changeset
  alias Timetrackergql.TimerContext.Clock

  schema "timers" do
    field :title, :string
    field :project, :string
    field :status, :string
    has_one :clock, Clock
    timestamps()
  end

  @doc false
  def changeset(timer, attrs) do
    cast(timer, attrs, [:timer_id])
    |> foreign_key_constraint(:timer_id)
  #  |> validate_required([:title, :project, :status])
  end
end
