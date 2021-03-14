defmodule InterviewPlanner.PlannerTest do
  use InterviewPlanner.DataCase

  alias InterviewPlanner.Planner

  describe "week_planners" do
    alias InterviewPlanner.Planner.WeekPlanner

    @valid_attrs %{end_time: ~N[2010-04-17 14:00:00], interval: 42, start_time: ~N[2010-04-17 14:00:00], step: 42, week_number: 42, year: 42}
    @update_attrs %{end_time: ~N[2011-05-18 15:01:01], interval: 43, start_time: ~N[2011-05-18 15:01:01], step: 43, week_number: 43, year: 43}
    @invalid_attrs %{end_time: nil, interval: nil, start_time: nil, step: nil, week_number: nil, year: nil}

    def week_planner_fixture(attrs \\ %{}) do
      {:ok, week_planner} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Planner.create_week_planner()

      week_planner
    end

    test "list_week_planners/0 returns all week_planners" do
      week_planner = week_planner_fixture()
      assert Planner.list_week_planners() == [week_planner]
    end

    test "get_week_planner!/1 returns the week_planner with given id" do
      week_planner = week_planner_fixture()
      assert Planner.get_week_planner!(week_planner.id) == week_planner
    end

    test "create_week_planner/1 with valid data creates a week_planner" do
      assert {:ok, %WeekPlanner{} = week_planner} = Planner.create_week_planner(@valid_attrs)
      assert week_planner.end_time == ~N[2010-04-17 14:00:00]
      assert week_planner.interval == 42
      assert week_planner.start_time == ~N[2010-04-17 14:00:00]
      assert week_planner.step == 42
      assert week_planner.week_number == 42
      assert week_planner.year == 42
    end

    test "create_week_planner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Planner.create_week_planner(@invalid_attrs)
    end

    test "update_week_planner/2 with valid data updates the week_planner" do
      week_planner = week_planner_fixture()
      assert {:ok, %WeekPlanner{} = week_planner} = Planner.update_week_planner(week_planner, @update_attrs)
      assert week_planner.end_time == ~N[2011-05-18 15:01:01]
      assert week_planner.interval == 43
      assert week_planner.start_time == ~N[2011-05-18 15:01:01]
      assert week_planner.step == 43
      assert week_planner.week_number == 43
      assert week_planner.year == 43
    end

    test "update_week_planner/2 with invalid data returns error changeset" do
      week_planner = week_planner_fixture()
      assert {:error, %Ecto.Changeset{}} = Planner.update_week_planner(week_planner, @invalid_attrs)
      assert week_planner == Planner.get_week_planner!(week_planner.id)
    end

    test "delete_week_planner/1 deletes the week_planner" do
      week_planner = week_planner_fixture()
      assert {:ok, %WeekPlanner{}} = Planner.delete_week_planner(week_planner)
      assert_raise Ecto.NoResultsError, fn -> Planner.get_week_planner!(week_planner.id) end
    end

    test "change_week_planner/1 returns a week_planner changeset" do
      week_planner = week_planner_fixture()
      assert %Ecto.Changeset{} = Planner.change_week_planner(week_planner)
    end
  end
end
