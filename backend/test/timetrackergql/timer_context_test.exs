defmodule Timetrackergql.TimerContextTest do
  use Timetrackergql.DataCase

  alias Timetrackergql.TimerContext

  describe "timers" do
    alias Timetrackergql.TimerContext.Timer

    @valid_attrs %{editFormOpen: true, elapsed: 42, isOpen: true, isRunning: true, project: "some project", title: "some title"}
    @update_attrs %{editFormOpen: false, elapsed: 43, isOpen: false, isRunning: false, project: "some updated project", title: "some updated title"}
    @invalid_attrs %{editFormOpen: nil, elapsed: nil, isOpen: nil, isRunning: nil, project: nil, title: nil}

    def timer_fixture(attrs \\ %{}) do
      {:ok, timer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TimerContext.create_timer()

      timer
    end

    test "list_timers/0 returns all timers" do
      timer = timer_fixture()
      assert TimerContext.list_timers() == [timer]
    end

    test "get_timer!/1 returns the timer with given id" do
      timer = timer_fixture()
      assert TimerContext.get_timer!(timer.id) == timer
    end

    test "create_timer/1 with valid data creates a timer" do
      assert {:ok, %Timer{} = timer} = TimerContext.create_timer(@valid_attrs)
      assert timer.editFormOpen == true
      assert timer.elapsed == 42
      assert timer.isOpen == true
      assert timer.isRunning == true
      assert timer.project == "some project"
      assert timer.title == "some title"
    end

    test "create_timer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TimerContext.create_timer(@invalid_attrs)
    end

    test "update_timer/2 with valid data updates the timer" do
      timer = timer_fixture()
      assert {:ok, %Timer{} = timer} = TimerContext.update_timer(timer, @update_attrs)
      assert timer.editFormOpen == false
      assert timer.elapsed == 43
      assert timer.isOpen == false
      assert timer.isRunning == false
      assert timer.project == "some updated project"
      assert timer.title == "some updated title"
    end

    test "update_timer/2 with invalid data returns error changeset" do
      timer = timer_fixture()
      assert {:error, %Ecto.Changeset{}} = TimerContext.update_timer(timer, @invalid_attrs)
      assert timer == TimerContext.get_timer!(timer.id)
    end

    test "delete_timer/1 deletes the timer" do
      timer = timer_fixture()
      assert {:ok, %Timer{}} = TimerContext.delete_timer(timer)
      assert_raise Ecto.NoResultsError, fn -> TimerContext.get_timer!(timer.id) end
    end

    test "change_timer/1 returns a timer changeset" do
      timer = timer_fixture()
      assert %Ecto.Changeset{} = TimerContext.change_timer(timer)
    end
  end
end
