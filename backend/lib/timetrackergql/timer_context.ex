defmodule Timetrackergql.TimerContext do
  @moduledoc """
  The TimerContext context.
  """

  import Ecto.Query, warn: false
  alias Timetrackergql.Repo
  alias Timetrackergql.TimerContext.Timer
  alias Timetrackergql.TimerContext.Clock

  @doc """
  Returns the list of timers.

  ## Examples

      iex> list_timers()
      [%Timer{}, ...]

  """
  def list_timers(attrs) do
    query = from t in Timer

    Enum.reduce(attrs, query, fn
      {:filter, filters}, query ->
        filter_with(filters, query)
    end)
    |> Repo.all
  end

  defp filter_with(filters, query) do
    Enum.reduce(filters, query, fn
      {:matching, term}, query ->
        pattern = "%#{term}%"

        from q in query,
          where:
            ilike(q.title, ^pattern) or
              ilike(q.project, ^pattern)

      {:status, value}, query ->
        from q in query, where: q.status == ^value

      {:elapsed, seconds}, query ->
        from q in query, where: q.elapsed <= ^seconds

    end)
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
  def get_clock!(timerid), do: Repo.get_by!(Clock, timer_id: timerid)

  def get_timer!(id), do: Repo.get!(Timer, id)

  @doc """
  Creates a timer.

  ## Examples

      iex> create_timer(%{field: value})
      {:ok, %Timer{}}

      iex> create_timer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_timer(attrs \\ %{}) do
    %Timer{}
    |> Timer.changeset(attrs)
    |> Repo.insert()

  end
  def create_clock(%Timer{} = timer, attrs) do
    %Clock{}
    |> Clock.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:timer, timer)
    |> Repo.insert()

  end

  @doc """
  Updates a timer.

  ## Examples

      iex> update_timer(timer, %{field: new_value})
      {:ok, %Timer{}}

      iex> update_timer(timer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_timer(timer, attrs) do
    timer
    |> Timer.changeset(attrs)
    |> Repo.update()
  end

  def update_clock(clock, attrs) do
    clock
    |> Clock.changeset(attrs)
    |> Repo.update()
  end
  @doc """
  Deletes a timer.

  ## Examples

      iex> delete_timer(timer)
      {:ok, %Timer{}}

      iex> delete_timer(timer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_timer(timer) do
    Repo.delete(timer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking timer changes.

  ## Examples

      iex> change_timer(timer)
      %Ecto.Changeset{source: %Timer{}}

  """
  def change_timer(%Timer{} = timer) do
    Timer.changeset(timer, %{})
  end

    # Dataloader

    def datasource() do
      Dataloader.Ecto.new(Repo, query: &query/2)
    end

    def query(queryable, _) do
      queryable
    end

end
