defmodule InterviewPlanner.Planner do
  @moduledoc """
  The Planner context.
  """

  import Ecto.Query, warn: false
  alias InterviewPlanner.Repo

  alias InterviewPlanner.Planner.WeekPlanner
  use Timex

  def list_week_planners do
    Repo.all(WeekPlanner)
  end

  def default_week_planner(curr_datetime) do
    {year, week_number, _} = Timex.iso_triplet(curr_datetime)

    %WeekPlanner{
      year: year,
      week_number: week_number,
      step: 30,
      interval: 10,
      start_time: ~T[12:00:00],
      end_time: ~T[20:00:01]
    }
  end

  def get_week_planner!(id), do: Repo.get!(WeekPlanner, id)

  def get_week_planner_by_date(incoming_date) do
    {year, week_number, _} = Timex.iso_triplet(incoming_date)

    WeekPlanner
    |> Repo.get_by(year: year, week_number: week_number)
  end

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
