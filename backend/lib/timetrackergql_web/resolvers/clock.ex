defmodule Timertrackergql.Resolvers.Clock do
  alias Timetrackergql.TimerContext

  def get_clock!(_,attrs, _), do: {:ok, TimerContext.get_clock!(attrs.id)}
  def update_clock(_,attrs, _), do: {:ok, TimerContext.update_clock(TimerContext.get_clock!(attrs.id), attrs.id)}


end
