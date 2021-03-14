defmodule InterviewPlanner.Planner do
  @moduledoc """
  The Planner context.
  """

  import Ecto.Query, warn: false
  alias InterviewPlanner.Repo

  alias InterviewPlanner.Planner.WeekPlanner

  def list_week_planners do
    Repo.all(WeekPlanner)
  end

  def get_week_planner!(id), do: Repo.get!(WeekPlanner, id)

  def create_week_planner(attrs \\ %{}) do
    %WeekPlanner{}
    |> WeekPlanner.changeset(attrs)
    |> Repo.insert()
  end

  def update_week_planner(%WeekPlanner{} = week_planner, attrs) do
    week_planner
    |> WeekPlanner.changeset(attrs)
    |> Repo.update()
  end

  def delete_week_planner(%WeekPlanner{} = week_planner) do
    Repo.delete(week_planner)
  end

  def change_week_planner(%WeekPlanner{} = week_planner, attrs \\ %{}) do
    WeekPlanner.changeset(week_planner, attrs)
  end
end
