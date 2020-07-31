defmodule TimetrackergqlWeb.Resolver.Timer do
  alias Timetrackergql.TimerContext
  @doc """
  Returns the list of timers.

  ## Examples

      iex> list_timers()
      [%Timer{}, ...]

  """
  def list_timers(_, attrs, _) do
    {:ok, TimerContext.list_timers(attrs)}
  end

  @doc """
  Gets a single timer.

  Raises `Ecto.NoResultsError` if the Timer does not exist.

  ## Examples

      iex> get_timer!(123)
      %Timer{}

      iex> get_timer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_timer!(_,attrs, _), do: {:ok, TimerContext.get_timer!(attrs.id)}

  @doc """
  Creates a timer.

  ## Examples

      iex> create_timer(%{field: value})
      {:ok, %Timer{}}

      iex> create_timer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_timer(_, args, _) do
    TimerContext.create_timer(args)
  end

  @doc """
  Updates a timer.

  ## Examples

      iex> update_timer(timer, %{field: new_value})
      {:ok, %Timer{}}

      iex> update_timer(timer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_timer(_, %{id: id} = args, _) do
    TimerContext.update_timer(TimerContext.get_timer!(id), args)
  end
  def create_timer(_, args, _) do
    { :ok, new_timer } = TimerContext.create_timer(args)
    # TimerContext.create_clock(new_timer, %{})
    {:ok, new_timer}
  end

  @doc """
  Deletes a timer.

  ## Examples

      iex> delete_timer(timer)
      {:ok, %Timer{}}

      iex> delete_timer(timer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_timer(_, attrs, _) do
    TimerContext.update_timer(TimerContext.get_timer!(attrs.id), %{status: "deleted"})
  end

  def hard_delete_timer(_, attrs, _) do
    {:ok, deletedTimer} = TimerContext.delete_timer(TimerContext.get_timer!(attrs.id))
  end

end
