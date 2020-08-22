defmodule Timetrackergql.TimerContext.Clock do
  use Ecto.Schema
  import Ecto.Changeset
  alias Timetrackergql.TimerContext.Timer


  schema "clocks" do
    field :elapsed, :integer, default: 0
    field :isRunning, :boolean, default: false
    belongs_to :timer, Timer

    timestamps()
    end

   @doc false
   def changeset(clock, attrs) do
    cast(clock, attrs, [:timer_id])
    |> validate_required([:elapsed, :isRunning])
    |> assoc_constraint(:timer)
  end


end
