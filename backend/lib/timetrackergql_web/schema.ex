defmodule TimetrackergqlWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Timetrackergql.Repo

  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias Timetrackergql.TimerContext
  alias TimetrackergqlWeb.Resolver

  object :timer do
    field :id, non_null(:id)
    field :title, non_null(:string)
    field :project, non_null(:string)
    field :status, non_null(:string)
    field :clock, non_null(:clock), resolve: dataloader(TimerContext)
  end

  object :clock do
    field :id, non_null(:id)
    field :elapsed, non_null(:integer)
    field :isRunning, non_null(:boolean)
    field :timer, non_null(:timer), resolve: dataloader(TimerContext)
  end

  query do

    @desc "List timers"
     field :timers, list_of(:timer) do
      arg( :filter, :timer_filter)
      resolve &Resolver.Timer.list_timers/3
     end

     @desc "Get timer"
     field :timer, :timer do
      arg(:id, :id)
      resolve &Resolver.Timer.get_timer!/3
     end

     @desc "Get clock"
     field :clock, :clock do
      arg :timer_id, non_null(:id)
      resolve &Resolver.Timer.get_timer!/3
     end

    end

    mutation do

      @desc "Create timer"
       field :create_timer, :timer do
        arg(:title, :string)
        arg(:project, :string)
        arg(:status, :string)
        resolve &Resolver.Timer.create_timer/3
       end

       @desc "Update timer"
       field :update_timer, :timer do
        arg(:id, :id)
        arg(:title, :string)
        arg(:project, :string)
        resolve &Resolver.Timer.update_timer/3
       end

       @desc "Delete timer"
       field :delete_timer, :timer do
        arg(:id, :id)
        resolve &Resolver.Timer.delete_timer/3
       end

       @desc "Hard delete timer"
       field :hard_delete_timer, :timer do
        arg(:id, :id)
        resolve &Resolver.Timer.hard_delete_timer/3
       end

      end

      # subscription do
      #   @desc "Subscribe to clock changes"
      #   field :clock_change, :clock do
      #     arg :id, non_null(:integer)
      #     #subscriptions don't use resolvers

      #     # args, Absinthe context struct
      #     config fn args, _info ->
      #       {:ok, topic: args.timer_id}
      #     end
      #   end
      # end

      @desc "Filters for timers"
      input_object :timer_filter do
        @desc "Matching title or project name"
        field :matching, :string

        @desc "Deleted or not?"
        field :status, :string

        @desc "Available for booking between a start and end date"
        field :elapsed, :integer
      end

      #Absinthe callback function
  def context(ctx) do
    IO.inspect ctx
    loader =
      Dataloader.new
      |> Dataloader.add_source(TimerContext, TimerContext.datasource())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

end



defmodule TimetrackergqlWeb.Schema.ChangesetErrors do
  @doc """
  Traverses the changeset errors and returns a map of
  error messages. For example:

  %{start_date: ["can't be blank"], end_date: ["can't be blank"]}
  """
  def error_details(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
